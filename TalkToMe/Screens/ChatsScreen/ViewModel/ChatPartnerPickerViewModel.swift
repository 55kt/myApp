import Foundation
import FirebaseAuth

enum ChatCreationRoute {
    case groupPartnerPicker
    case setUpGroupChat
}

enum ChatContants {
    static let maxGroupMembers = 12
}

enum ChannelCreationError: Error {
    case noChatPartner
    case failedToCreateUniqueIds
}

@MainActor
final class ChatPartnerPickerViewModel: ObservableObject {
    // MARK: - Properties
    @Published var navStack = [ChatCreationRoute]() // variable to keep track of navigation
    @Published var selectedChatPartners = [UserItem]() // variable to keep track of selected users
    @Published private(set) var users = [UserItem]()
    @Published var errorState: (showError: Bool, errorMessage: String) = (false, "Oh No")
    
    private var lastCursor: String?
    
    var showSelectedUsers: Bool {
        return !selectedChatPartners.isEmpty
    }
    
    var disableNextButton: Bool {
        return selectedChatPartners.isEmpty
    }
    
    var isPaginatable: Bool {
        return !users.isEmpty
    }
    
    private var isDirectChannel: Bool {
        return selectedChatPartners.count == 1
    }
    
    // MARK: - Initializer
    init() {
        Task {
            await fetchUsers()
        }
    }
    
    // MARK: - Public Methods
    func fetchUsers() async {
        do {
            let userNode = try await UserService.paginateUsers(lastCursor: lastCursor, pageSize: 5)
            var fetchedUsers = userNode.users
            guard let currentUid = Auth.auth().currentUser?.uid else { return }
            fetchedUsers = fetchedUsers.filter { $0.uid != currentUid }
            self.users.append(contentsOf: fetchedUsers)
            self.lastCursor = userNode.currentCursor
            print("lastCursor: \(lastCursor ?? "") \(users.count)")
        } catch {
            print("💿 Failed to fetch users in ChatPartnerPickerViewModel")
        }
    }
    
    func deselectAllChatPartners() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.selectedChatPartners.removeAll()
        }
    }
    
    func handleItemSelection(_ item: UserItem) {
        if isUserSelected(item) {
            guard let index = selectedChatPartners.firstIndex(where: { $0.uid == item.uid }) else { return }
            selectedChatPartners.remove(at: index)
        } else {
            
            guard selectedChatPartners.count < ChatContants.maxGroupMembers else {
                let errorMessage = "Sorry, We only allow a Maximum of \(ChatContants.maxGroupMembers) members in a group chat  "
                showError(errorMessage)
                return
            }
            selectedChatPartners.append(item)
        }
    }
    
    // function to check if user is selected
    func isUserSelected(_ user: UserItem) -> Bool {
        let isSelected = selectedChatPartners.contains { $0.uid == user.uid }
        return isSelected
    }
    
    func createDirectChannel(_ chatPartner: UserItem, completion: @escaping (_ newChannel: ChannelItem) -> ()) {
        selectedChatPartners.append(chatPartner)
        Task {
            if let channelId = await verifyDirectChannelExists(with: chatPartner.uid) {
                let snapshot = try await FirebaseConstants.ChannelsRef.child(channelId).getData()
                var channelDict = snapshot.value as! [String: Any]
                var directChannel = ChannelItem(channelDict)
                directChannel.members = selectedChatPartners
                completion(directChannel)
                
            } else {
                let channelCreation = createChannel(nil)
                switch channelCreation {
                case .success(let channel):
                    completion(channel)
                case .failure(let failure):
                    showError("Sorry! Something Went Wrong While We Were Trying To Setup Your Chat")
                    print("Failed to create a Direct Channel: \(failure.localizedDescription)")
                }
            }
        }
    }
    
    typealias ChannelId = String
    private func verifyDirectChannelExists(with chatPartnerId: String) async -> ChannelId? {
        guard let currentUid = Auth.auth().currentUser?.uid,
              let snapshot = try? await FirebaseConstants.UserDirectChannels.child(currentUid).child(chatPartnerId).getData(),
              snapshot.exists()
        else { return nil }
        
        let directMessageDict = snapshot.value as! [String: Bool]
        let channelId = directMessageDict.compactMap { $0.key }.first
            return channelId
    }
    
    func createGroupChannel(_ groupName: String?, completion: @escaping (_ newChannel: ChannelItem) -> ()) {
        let channelCreation = createChannel(groupName)
        switch channelCreation {
        case .success(let channel):
            completion(channel)
        case .failure(let failure):
            showError("Sorry! Something Went Wrong While We Were Trying To Setup Your Group Chat")
            print("Failed to create a Group Channel: \(failure.localizedDescription)")
        }
    }
    
    private func showError(_ errorMessage: String) {
        errorState.errorMessage = errorMessage
        errorState.showError = true
    }
    
    // This function is a helper function to create a new channel
    private func createChannel(_ channelName: String?) -> Result<ChannelItem, Error> {
        guard !selectedChatPartners.isEmpty else { return .failure(ChannelCreationError.noChatPartner) }
        
        guard
            let channelId = FirebaseConstants.ChannelsRef.childByAutoId().key,
            let currentUid = Auth.auth().currentUser?.uid,
            let messageId = FirebaseConstants.MessagesRef.childByAutoId().key
        else { return .failure(ChannelCreationError.failedToCreateUniqueIds) }
        
        let timeStamp = Date().timeIntervalSince1970
        var membersUids = selectedChatPartners.compactMap { $0.uid }
        membersUids.append(currentUid)
        
        let newChannelBroadcast = AdminMessageType.channelCreation.rawValue
        
        var channelDict: [String: Any] = [
            .id: channelId,
            .lastMessage: "",
            .creationDate: timeStamp,
            .lastMessageTimeStamp: timeStamp,
            .membersUids: membersUids,
            .membersCount: membersUids.count,
            .adminUids: [currentUid],
            .createdBy: currentUid
        ]
        
        if let channelName = channelName, !channelName.isEmptyOrWhitespace {
            channelDict[.name] = channelName
        }
        
        let messageDict: [String: Any] = [.type: newChannelBroadcast, .timeStamp: timeStamp, .ownerUid: currentUid]
        
        FirebaseConstants.ChannelsRef.child(channelId).setValue(channelDict)
        FirebaseConstants.MessagesRef.child(channelId).child(messageId).setValue(messageDict)
        
        // keeping an index of the channel that a specific user belongs to
        membersUids.forEach { userId in
            FirebaseConstants.UserChannelsRef.child(userId).child(channelId).setValue(true)
        }
        if isDirectChannel {
            let chatPartner = selectedChatPartners[0]
            FirebaseConstants.UserDirectChannels.child(currentUid).child(chatPartner.uid).setValue([channelId: true])
            FirebaseConstants.UserDirectChannels.child(chatPartner.uid).child(currentUid).setValue([channelId: true])
        }
        
        var newChannelItem = ChannelItem(channelDict)
        newChannelItem.members = selectedChatPartners
        return .success(newChannelItem)
    }
}
