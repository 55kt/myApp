import SwiftUI

struct GrayGradient: View {
    var body: some View {
        LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 207/255, green: 209/255, blue: 211/255),
                        Color(red: 169/255, green: 173/255, blue: 179/255),
                        Color(red: 139/255, green: 142/255, blue: 149/255)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
        .ignoresSafeArea()
    }
}

#Preview {
    GrayGradient()
}
