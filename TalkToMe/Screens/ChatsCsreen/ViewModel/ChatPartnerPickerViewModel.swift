import Foundation

enum ChatCreationRoute {
    case addGroupChatMembers
    case setUpGroupChat
}

final class ChatPartnerPickerViewModel: ObservableObject {
    @Published var navStack = [ChatCreationRoute]()
    @Published var selectedChatPartners = [UserItem]()
    
    var showSelectedUsers: Bool {
        return !selectedChatPartners.isEmpty
    }
    
    // MARK: - Public Methods
    func handleItemSelection(_ item: UserItem) {
        
    }
    
    func handleItemSelection(_ item: UserItem) {
        
    }
}
