import SwiftUI

struct AuthHeader: View {
    // MARK: - Body
    var body: some View {
        HStack {
            Image(systemName: "text.bubble")
                .font(.system(size: 40, weight: .bold))
                .frame(width: 40, height: 40)
                .foregroundColor(.white)
                .opacity(0.9)
            
            Text("TalkToMe")
                .font(.largeTitle)
                .foregroundStyle(.white)
                .fontWeight(.semibold)
        }
    }
}

// MARK: - Preview
#Preview {
    AuthHeader()
}
