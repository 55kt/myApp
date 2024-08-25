import SwiftUI

struct FinalScreenView: View {
    @State private var textScale: CGFloat = 1.0
    @State private var textOpacity: Double = 1.0
    @State private var showMainView = false

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                IntroGradient()
                
                if showMainView {
                    //
                } else {
                    VStack(spacing: 0) {
                        Text("Done")
                            .font(.system(size: geometry.size.width * 0.3)) // Size for the first text
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                        
                        Text("Good Chatting")
                            .font(.system(size: geometry.size.width * 0.05)) // Size for the second text
                            .foregroundStyle(.white)
                            .padding(.top, -20) // Offset for the second text
                    }
                    .scaleEffect(textScale)
                    .opacity(textOpacity)
                    .onAppear {
                        withAnimation(.easeOut(duration: 4.0)) { // Animation for the text
                            textScale = 0.9
                            textOpacity = 0.0
                        }

                        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) { // Delay for 4 seconds
                            showMainView = true
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center) // Garanty that the text is centered
                    .padding()
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height) // Garanty that the screen is full
        }
    }
}

#Preview {
    FinalScreenView()
}
