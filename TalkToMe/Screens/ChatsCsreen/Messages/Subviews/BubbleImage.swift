import SwiftUI

struct BubbleImage: View {
    // MARK: - Properties
    let item: MessageItemModel
    
    // MARK: - Body
    var body: some View {
        HStack {
            if item.direction == .sent { Spacer() }
            
            HStack {
                if item.direction == .sent { shareButton() }
                
                messageTextView()
                    .shadow(color: Color(.systemGray3).opacity(0.1), radius: 5, x: 0, y: 20)
                    .overlay {
                        playButton()
                            .opacity(item.type == .video ? 1 : 0)
                    }
                
                if item.direction == .received { shareButton() }
            }
            
            if item.direction == .received { Spacer() }
        }
    }
    
    // MARK: - Methods
    private func playButton() -> some View {
        Image(systemName: "play.fill")
            .padding()
            .imageScale(.large)
            .foregroundStyle(.gray)
            .background(.thinMaterial)
            .clipShape(Circle())
    }
    
    private func messageTextView() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Image(.stubImage0)
                .resizable()
                .scaledToFill()
                .frame(width: 220, height: 180)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                .background {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color(.systemGray5))
                }
//                .overlay(RoundedRectangle(cornerRadius: 10, style: .continuous).stroke(Color(.systemGray5)))
                .padding(5)
                .overlay(alignment: .bottomTrailing) {
                    timeStampTextView()
                }
            
            Text(item.text)
                .padding([.horizontal, .bottom], 8)
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(width: 220)
        }
        .background(item.backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .applyTail(direction: item.direction)
    }
    
    private func shareButton() -> some View {
        Button {
            // Some action
        } label: {
            Image(systemName: "arrowshape.turn.up.right.fill")
                .padding(10)
                .foregroundStyle(.white)
                .background(Color.gray)
                .background(.thinMaterial)
                .clipShape(Circle())
        }
    }
    
    private func timeStampTextView() -> some View {
        HStack {
            Text("11:32 AM")
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
        .padding(.vertical, 1)
        .padding(.horizontal, 7)
        .foregroundStyle(.white)
        .background(Color(.systemGray))
        .clipShape(Capsule())
        .padding(12)
    }
}

// MARK: - Preview
#Preview {
    ScrollView {
        BubbleImage(item: .receivedPlaceholder)
        BubbleImage(item: .sentPlaceholder)
    }
    .frame(maxWidth: .infinity)
    .padding(.horizontal)
    .background(Color.gray.opacity(0.2))
}
