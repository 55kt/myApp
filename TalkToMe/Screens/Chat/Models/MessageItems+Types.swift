import Foundation

enum MessageMenuAction: String, CaseIterable, Identifiable {
    case reply, forward, copy, delete
    
    var id: String {
        return rawValue
    }
    
    var systemImage: String {
        switch self {
        case .reply:
            return "arrowshape.turn.up.left"
        case .forward:
            return "paperplane"
        case .copy:
            return "doc.on.doc"
        case .delete:
            return "trash"
        }
    }
}


enum Reaction: Int {
    case like
    case hearth
    case laugh
    case shocked
    case sad
    case pray
    case more
    
    var emoji: String {
        switch self {
        case .like:
            return "👍"
        case .hearth:
            return "❤️"
        case .laugh:
            return "😂"
        case .shocked:
            return "😱"
        case .sad:
            return "😢"
        case .pray:
            return "🙏"
        case .more:
            return "+"
        }
    }
}

enum AdminMessageType: String {
    case channelCreation
    case memberAdded
    case memberLeft
    case channelNameChanged
}

enum MessageType: Hashable {
    case admin(_ type: AdminMessageType), text, photo, video, audio
    
    var title: String {
        switch self {
        case .admin:
            return "admin"
        case .text:
            return "text"
            
        case .photo:
            return "photo"
            
        case .video:
            return "video"
            
        case .audio:
            return "audio"
            
        }
    }
    
    var iconName: String {
        switch self {
        case .admin:
            return "megaphone.fill"
        case .text:
            return ""
            
        case .photo:
            return "photo.fill"
            
        case .video:
            return "video.fill"
            
        case .audio:
            return "mic.fill"
            
        }
    }
    
    init?(_ stringValue: String) {
        switch stringValue {
        case .text:
            self = .text
        case "photo":
            self = .photo
        case "video":
            self = .video
        case "audio":
            self = .audio
            
        default:
            if let adminMessageType = AdminMessageType(rawValue: stringValue) {
                self = .admin(adminMessageType)
            } else {
                return nil
            }
        }
    }
}

extension MessageType: Equatable {
    static func ==(lhs: MessageType, rhs: MessageType) -> Bool {
        switch(lhs, rhs) {
        case (.admin(let leftAdmin), .admin(let rightAdmin)):
            return leftAdmin == rightAdmin
            
        case (.text, .text),
            (.photo, .photo),
            (.video, .video),
            (.audio, .audio):
            return true
            
        default: return false
            
        }
    }
}

enum MessageDirection {
    case sent, received
    
    static var random: MessageDirection {
        return [MessageDirection.sent, .received].randomElement() ?? .sent
    }
}
