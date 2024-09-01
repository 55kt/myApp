import Foundation
import Combine

final class ChatRoomViewModel: ObservableObject {
    @Published var textMessage = ""
    
    func sendMessage() {
        print("textMessage: \(textMessage)")
    }
}
