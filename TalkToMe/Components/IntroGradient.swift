import SwiftUI

struct IntroGradient: View {
    var body: some View {
        LinearGradient(
                    gradient: Gradient(colors: [Color(red: 255/255, green: 108/255, blue: 28/255), Color(red: 255/255, green: 157/255, blue: 56/255)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
        .ignoresSafeArea(.all)
    }
}

#Preview {
    IntroGradient()
}
