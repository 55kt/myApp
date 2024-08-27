import Foundation

enum ChatCreationRoute {
    case groupPartnerPicker
    case setUpGroupChat
}

enum ChatContants {
    static let maxGroupMembers = 12
}

final class ChatPartnerPickerViewModel: ObservableObject {
    @Published var navStack = [ChatCreationRoute]() // variable to keep track of navigation
    @Published var selectedChatPartners = [UserItem]() // variable to keep track of selected users
    
    var showSelectedUsers: Bool {
        return !selectedChatPartners.isEmpty
    }
    
    var disableNextButton: Bool {
        return selectedChatPartners.isEmpty
    }
    
    // MARK: - Public Methods
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
