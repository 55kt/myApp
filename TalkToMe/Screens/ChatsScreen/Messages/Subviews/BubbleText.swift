import SwiftUI

struct BubbleText: View {
    // MARK: - Properties
    let item: MessageItemModel
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: item.horizontalAlignment, spacing: 3) {
            Text("Hello, World! And whats app this is my app and this message is for testing bubble view")
                .padding(10)
                .background(item.backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .applyTail(direction: item.direction)
            
            timeStampTextView()
        }
        .shadow(color: Color(.systemGray3).opacity(0.1), radius: 5, x: 0, y: 20)
        .frame(maxWidth: .infinity, alignment: item.alignment)
        .padding(.leading, item.direction == .received ? 5 : 100)
        .padding(.trailing, item.direction == .received ? 100 : 5)
    }
    
    // Time View Function
    private func timeStampTextView() -> some View {
        HStack {
            Text("01:30 PM")
                .font(.system(size: 13))
                .foregroundStyle(.white)
            
            if item.direction == .sent {
                Image(.seen)
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 15, height: 15)
                    .foregroundStyle(Color(.systemBlue))
            }
        }
    }
}

// MARK: - Preview
#Preview {
    ScrollView {
        BubbleText(item: .sentPlaceholder)
        BubbleText(item: .receivedPlaceholder)
    }
    .frame(maxWidth: .infinity)
    .background(Color.gray.opacity(0.2))
}
