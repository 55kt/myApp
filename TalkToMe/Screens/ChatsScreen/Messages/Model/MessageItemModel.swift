import Foundation
import SwiftUI


struct MessageItemModel: Identifiable {

    let id = UUID().uuidString
    let text: String
    let type: MessageType
    let direction: MessageDirection
    
    
    static let sentPlaceholder = MessageItemModel(text: "Lorem ipsum dolor sit amet.", type: .text, direction: .sent)
    
    static let receivedPlaceholder = MessageItemModel(text: "Donec sit amet nunc sapien.", type: .text, direction: .received)
    
    var alignment: Alignment {
        return direction == .sent ? .leading : .trailing
    }
    
    var horizontalAlignment: HorizontalAlignment {
        return direction == .received ? .leading : .trailing
    }
    
    var backgroundColor: Color {
        return direction == .sent ? Color.bubbleGreen : .bubbleWhite
    }
    
    static let stubMessages: [MessageItemModel] = [
        MessageItemModel(text: "Hello, World!", type: .text, direction: .sent),
        MessageItemModel(text: "Check this photo", type: .photo, direction: .received),
        MessageItemModel(text: "Check out this video", type: .video, direction: .sent),
        MessageItemModel(text: "", type: .audio, direction: .received)
    ]
}

enum MessageType {
    case text, photo, video, audio
}

enum MessageDirection {
    case sent, received

    static var random: MessageDirection {
        return [MessageDirection.sent, .received].randomElement() ?? .sent
    }
}
