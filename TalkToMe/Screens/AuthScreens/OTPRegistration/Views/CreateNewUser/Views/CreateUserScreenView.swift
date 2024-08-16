import SwiftUI

struct CreateUserScreenView: View {
    // MARK: - Properties
    @State private var textFieldContent: String = ""
    @State private var isKeyboardVisible: Bool = false
    @State private var usernameExists: Bool? = nil
    @State private var showMessage: Bool = false
    @FocusState private var isFocus: Bool
    @State private var buttonText: String = "Create New User"
    @State private var croppedImage: UIImage?
    @State private var showFinalScreen: Bool = false
    @State private var errorMessage: String?

    // MARK: - Body
    var body: some View {
        ZStack {
            // Background elements
            IntroGradient()
            
            if !isKeyboardVisible {
                // Nav text area
                NavigationTextArea()
                UserAvatar(croppedImage: $croppedImage)
            } else {
                TappedFieldTextChange()
            }
            
            VStack {
                if showMessage, let errorMessage = errorMessage {
                    Text(errorMessage)
                        .font(.title)
                        .foregroundColor(.white)
                        .bold()
                        .transition(.opacity)
                        .padding(.bottom, 10)
                }
            }
            .padding(.bottom, 10)

            // Username TextField
            UsernameField(textPlaceholder: $textFieldContent, boolPlaceholder: $isKeyboardVisible)
                .focused($isFocus)
                .onTapGesture {
                    withAnimation {
                        isFocus = true
                    }
                }
            
            // Submit Button
            SubmitButton(
                textPlaceholder: $textFieldContent,
                boolPlaceholder: $isKeyboardVisible,
                usernameExists: $usernameExists,
                showMessage: $showMessage,
                isFocus: $isFocus,
                buttonText: $buttonText,
                showFinalScreen: $showFinalScreen, // Добавляем привязку для перехода
                errorMessage: $errorMessage // Добавляем привязку для сообщения об ошибке
            )
            .padding(.top, 20)
        }
        .navigationBarBackButtonHidden(true)
        .fullScreenCover(isPresented: $showFinalScreen) {
            FinalScreenView() // Переход на финальный экран
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        CreateUserScreenView()
    }
}
