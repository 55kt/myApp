import Foundation
import FirebaseAuth

enum ChatCreationRoute {
    case groupPartnerPicker
    case setUpGroupChat
}

enum ChatContants {
    static let maxGroupMembers = 12
}

@MainActor
final class ChatPartnerPickerViewModel: ObservableObject {
    // MARK: - Properties
    @Published var navStack = [ChatCreationRoute]() // variable to keep track of navigation
    @Published var selectedChatPartners = [UserItem]() // variable to keep track of selected users
    @Published private(set) var users = [UserItem]()
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
            print("lastCursor: \(lastCursor) \(users.count)")
        } catch {
            print("💿 Failed to fetch users in ChatPartnerPickerViewModel")
        }
    }
    
    func handleItemSelection(_ item: UserItem) {
        if isUserSelected(item) {
            guard let index = selectedChatPartners.firstIndex(where: { $0.uid == item.uid }) else { return }
            selectedChatPartners.remove(at: index)
        } else {
            selectedChatPartners.append(item)
        }
    }
    
    // function to check if user is selected
    func isUserSelected(_ user: UserItem) -> Bool {
        let isSelected = selectedChatPartners.contains { $0.uid == user.uid }
        return isSelected
    }
}
