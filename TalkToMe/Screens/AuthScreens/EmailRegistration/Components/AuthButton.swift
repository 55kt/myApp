import SwiftUI

struct AuthButton: View {
    // MARK: - Properties
    @State var buttonName: String
    @State var buttonAction: () -> ()
    @Environment(\.isEnabled) private var isEnabled
    
    private var backgroundColor: Color {
        return isEnabled ? .white : .white.opacity(0.3)
    }
    
    private var buttonNameColor: Color {
        return isEnabled ? .gray : .gray
    }
    
    // MARK: - Body
    var body: some View {
        Button {
            buttonAction()
        } label: {
            HStack {
                Text(buttonName)
                    
                Image(systemName: "arrow.right")
            }
            .font(.headline)
            .foregroundStyle(buttonNameColor)
            .padding()
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .shadow(color: .gray.opacity(0.2), radius: 10)
            .padding(.horizontal, 32)
        }
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        IntroGradient()
        AuthButton(buttonName: "Button Name", buttonAction: {})
    }
}
