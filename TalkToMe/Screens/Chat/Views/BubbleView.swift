import SwiftUI

struct BubbleView: View {
    
    // MARK: - Properties
    let message: MessageItem
    let channel: ChannelItem
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            newDayTimeStampTextView()
            composeDinamicBubbleView()
        }
    }
    
    // MARK: - Methods
    @ViewBuilder
    private func composeDinamicBubbleView() -> some View {
        switch message.type {
        case .text:
            BubbleTextView(item: message)
        case .video, .photo:
            BubbleImageView(item: message)
        case .audio:
            BubbleAudioView(item: message)
        case .admin(let adminType):
            switch adminType {
            case .channelCreation:
                ChannelCreationTextView()
                
                if channel.isGroupChat {
                    AdminMessageTextView(channel: channel)
                }
            default:
                Text("UNKNOWN ADMIN MESSAGE")
            }
        }
    }
    
    private func newDayTimeStampTextView() -> some View {
        Text(message.timeStamp.formatToTime)
            .font(.caption)
            .bold()
            .padding(.vertical, 3)
            .padding(.horizontal)
            .background(Color.black.opacity(0.1))
            .clipShape(Capsule())
            .frame(maxWidth: .infinity)
    }
}

// MARK: - Preview
#Preview {
    BubbleView(message: .sentPlaceholder, channel: .placeholder)
}
