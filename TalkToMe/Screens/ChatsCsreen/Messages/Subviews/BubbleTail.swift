import SwiftUI

struct BubbleTail: View {
    // MARK: - Properties
    var direction: MessageDirection
    
    // Variable for background color
    private var backgroundColor: Color {
        return direction == .received ? .bubbleWhite : .bubbleGreen
    }
    
    // MARK: - Body
    var body: some View {
        Image(direction == .sent ? .outgoingTail : .incomingTail)
            .renderingMode(.template)
            .resizable()
            .frame(width: 10, height: 10)
            .offset(y: 3)
            .foregroundStyle(backgroundColor)
    }
}

// MARK: - Preview
#Preview {
    ScrollView {
        BubbleTail(direction: .sent)
        BubbleTail(direction: .received)
    }
    .frame(maxWidth: .infinity)
    .background(Color.gray.opacity(0.5))
}
