import Foundation

enum AdminMessageType: String {
    case channelCreation
    case memberAdded
    case memberLeft
    case channelNameChanged
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
