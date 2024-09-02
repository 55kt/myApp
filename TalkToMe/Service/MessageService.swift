import Foundation

// MARK: - Handles sending and fetching messages and settings reactions
struct MessageService {
    
    static func sendTextMessage(to channel: ChannelItem, from currentUser: UserItem, _ textMessage: String, onComplete: () -> ()) {
        let timeStamp = Date().timeIntervalSince1970
        
        guard let messageId = FirebaseConstants.MessagesRef.childByAutoId().key else { return }
        
        let channelDict: [String: Any] = [
            .lastMessage: textMessage,
            .lastMessageTimeStamp: timeStamp
        ]
        
        let messageDict: [String: Any] = [
            .text: textMessage,
            .type: MessageType.text.title,
            .timeStamp: timeStamp,
            .ownerUid: currentUser.uid,
        ]
        
        FirebaseConstants.ChannelsRef.child(channel.id).updateChildValues(channelDict)
        FirebaseConstants.MessagesRef.child(channel.id).child(messageId).setValue(messageDict)
        
        onComplete()
    }
}
