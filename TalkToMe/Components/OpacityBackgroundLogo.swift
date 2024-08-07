import SwiftUI

struct OpacityBackgroundLogo: View {
    var body: some View {
        Image(systemName: "text.bubble")
                    .font(.system(size: 200, weight: .bold))
                    .frame(width: 390, height: 250)
                    .foregroundColor(.white)
                    .background(Color.clear)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                    .opacity(0.1)
    }
}

#Preview {
    OpacityBackgroundLogo()
}
