import SwiftUI

struct TappedFieldTextChange: View {
    var body: some View {
        ZStack {
            IntroGradient()
            VStack {
                Text("Come up with your unique nickname.")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.white)
                    .padding(-9)
                                
                Text("Be careful if you want to change your nickname in the future; this operation will only be available for a fee.")
                    .font(.headline)
                    .foregroundStyle(.yellow.opacity(0.9))
                    .padding(2)
                    .padding(.top, 13)
                Spacer()
            }
            .padding()
            .multilineTextAlignment(.center)
            .shadow(radius: 10 )
            .transition(.opacity)
        }
    }
}

#Preview {
    TappedFieldTextChange()
}
