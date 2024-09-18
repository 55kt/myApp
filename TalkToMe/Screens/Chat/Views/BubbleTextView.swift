import SwiftUI

struct BubbleTextView: View {
    let item: MessageItem
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 6) {
            if item.showGroupPartnerInfo {
                CircularProfileImageView(item.sender?.profileImageUrl, size: .mini)
                    .offset(y: 3)
            }
            
            if item.direction == .sent {
                timeStampTextView()
            }
            Text(item.text)
                .padding(10)
                .background(item.backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .applyTail(item.direction)
            
            if item.direction == .received {
                timeStampTextView()
            }
        }
        .shadow(color: Color(.systemGray3).opacity(0.1), radius: 5, x: 0, y: 20)
        .frame(maxWidth: .infinity, alignment: item.alignment)
        .padding(.leading, item.leadingPadding)
        .padding(.trailing, item.trailingPadding)
        .overlay(alignment: item.reactionAnchor) {
            MessageReactionView(message: item)
                .offset(x: item.showGroupPartnerInfo ? 50 : 0, y: 15)
        }
    }
    
    private func timeStampTextView() -> some View {
        HStack {
            Text(item.timeStamp.formatToTime)
                .font(.footnote)
                .foregroundStyle(.gray)
        }
    }
}

#Preview {
    ScrollView {
        BubbleTextView(item: .sentPlaceholder)
        BubbleTextView(item: .receivedPlaceholder)

    }
    .frame(maxWidth: .infinity)
    .background(Color.gray.opacity(0.4))
}
