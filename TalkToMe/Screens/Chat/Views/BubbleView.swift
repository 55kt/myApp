import SwiftUI

struct BubbleView: View {
    
    // MARK: - Properties
    let message: MessageItem
    let channel: ChannelItem
    let isNewDay: Bool
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            if isNewDay {
                newDayTimeStampTextView()
                    .padding()
            }
            composeDinamicBubbleView()
        }
        .frame(maxWidth: .infinity)
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
                newDayTimeStampTextView()
                
                ChannelCreationTextView()
                    .padding()
                
                if channel.isGroupChat {
                    AdminMessageTextView(channel: channel)
                }
            default:
                Text("UNKNOWN ADMIN MESSAGE")
            }
        }
    }
    
    private func newDayTimeStampTextView() -> some View {
        Text(message.timeStamp.relativeDateString)
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
    BubbleView(message: .sentPlaceholder, channel: .placeholder, isNewDay: false)
}
