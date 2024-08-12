import SwiftUI

struct NavigationTextArea: View {
    var body: some View {
        VStack {
            Text("Congrads!\nYour phone number has verified successfully..")
                .font(.largeTitle)
                .bold()
                .foregroundStyle(.white)
                .padding(-9)
            
            
            Text("Now, create your own unique nickname, add your photo, or choose an avatar.")
                .font(.headline)
                .foregroundStyle(.white)
                .padding(2)
                .padding(.bottom)
            Spacer()
        }
        .padding()
        .multilineTextAlignment(.center)
        .shadow(radius: 10)
        .transition(.opacity)
    }
}

#Preview {
    NavigationTextArea()
}
