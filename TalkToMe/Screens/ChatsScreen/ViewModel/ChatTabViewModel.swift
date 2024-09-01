import Foundation
import FirebaseAuth

final class ChatTabViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var navigateToChatRoom = false
    @Published var newChannel: ChannelItem?
    @Published var showChatPartnerPicker: Bool = false
    @Published var channels = [ChannelItem]()
    
    // MARK: - Initializer
    init() {
        fetchCurrentUserChannels()
    }
    
    // MARK: - Methods
    func onNewChannelCreation(_ channel: ChannelItem) {
        showChatPartnerPicker = false
        newChannel = channel
        navigateToChatRoom = true
    }
    
    private func fetchCurrentUserChannels() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        FirebaseConstants.UserChannelsRef.child(currentUid).observe(.value) {[weak self] snapshot in
            guard let dict = snapshot.value as? [String: Any] else { return }
            dict.forEach { key, value in
            let channelId = key
                self?.getChannel(with: channelId)
            }
        } withCancel: { error in
            print("Failed to get current user channels \(error.localizedDescription)")
        }
    }
    
    private func getChannel(with channelId: String) {
        FirebaseConstants.ChannelsRef.child(channelId).observe(.value) {[weak self] snapshot in
            guard let dict = snapshot.value as? [String: Any] else { return }
            var channel = ChannelItem(dict)
            self?.getChannelMembers(channel) { members in
                channel.members = members
                self?.channels.append(channel)
                print("channel: \(channel.title)")
            }
        } withCancel: { error in
            print("Failed to get the channel for id \(channelId): \(error.localizedDescription)")
        }
    }
    
    private func getChannelMembers(_ channel: ChannelItem, completion: @escaping (_ members: [UserItem]) -> ()) {
        UserService.getUsers(with: channel.membersUids) { userNode in
            completion(userNode.users)
        }
    }
}
