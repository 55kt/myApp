import SwiftUI

struct BubbleAudio: View {
    // MARK: - Properties
    let item: MessageItemModel
    @State private var sliderValue: Double = 0
    @State private var sliderRange: ClosedRange<Double> = 0...20
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: item.horizontalAlignment, spacing: 3) {
            HStack {
                playButton()
                Slider(value: $sliderValue, in: sliderRange)
                    .tint(.gray)
                
                Text("04:00")
                    .foregroundStyle(.gray)
            }
            .padding(10)
            .background(Color.gray.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .padding(5)
            .background(item.backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .applyTail(direction: item.direction)
            timeStampTextView()
        }
        .shadow(color: Color(.systemGray3).opacity(0.1), radius: 5, x: 0, y: 20)
        .frame(maxWidth: .infinity, alignment: item.alignment)
        .padding(.leading, item.direction == .received ? 5 : 50)
        .padding(.trailing, item.direction == .received ? 50 : 5)
    }
    
    // MARK: - Methods
    private func playButton() -> some View {
        Button {
            // Some action
        } label: {
            Image(systemName: "play.fill")
                .padding(10)
                .background(item.direction == .received ? .orange.opacity(0.3) : .gray.opacity(0.3))
                .clipShape(Circle())
                .foregroundStyle(item.direction == .received ? .white : .black)
        }
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
        BubbleAudio(item: .sentPlaceholder)
        BubbleAudio(item: .receivedPlaceholder)
    }
    .frame(maxWidth: .infinity)
    .padding(.horizontal)
    .background(Color.orange.opacity(0.4))
    .onAppear {
        let thumbImage = UIImage(systemName: "circle.fill")
        UISlider.appearance().setThumbImage(thumbImage, for: .normal)
    }
}
