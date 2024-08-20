import Foundation
import SwiftUI


struct MessageItemModel: Identifiable {

    let id = UUID().uuidString
    let text: String
    let direction: MessageDirection
    
    
    static let sentPlaceholder = MessageItemModel(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras ex urna, congue nec mi in, hendrerit ultricies neque. Vivamus ac ipsum placerat, luctus mi aliquet, pulvinar ex.", direction: .sent)
    
    static let receivedPlaceholder = MessageItemModel(text: "Donec sit amet nunc sapien. Aenean convallis, mi a fringilla maximus, arcu libero volutpat mauris, sit amet lobortis massa dui id odio.", direction: .received)
    
    var alignment: Alignment {
        return direction == .sent ? .leading : .trailing
    }
    
    var horizontalAlignment: HorizontalAlignment {
        return direction == .received ? .leading : .trailing
    }
    
    var backgroundColor: Color {
        return direction == .sent ? Color.bubbleGreen : .bubbleWhite
    }
}

enum MessageDirection {
    case sent, received

    static var random: MessageDirection {
        return [MessageDirection.sent, .received].randomElement() ?? .sent
    }
}
