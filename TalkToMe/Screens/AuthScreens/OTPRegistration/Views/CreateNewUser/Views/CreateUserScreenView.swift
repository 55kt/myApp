import SwiftUI

struct CreateUserScreenView: View {
    // MARK: - Properties
    @State private var textFieldContent: String = ""
    @State private var isKeyboardVisible: Bool = false
    @State private var usernameExists: Bool? = nil
    @State private var showMessage: Bool = false
    @FocusState private var isFocus: Bool
    @State private var buttonText: String = "Create New User"
    
    // MARK: - Body
    var body: some View {
        ZStack {
            // Background elements
            IntroGradient()
            
            if !isKeyboardVisible {
                // Nav text area
                NavigationTextArea()
                UserAvatar()
            } else {
                TappedFieldTextChange()
            }
            
            VStack {
                if showMessage {
                    if usernameExists == true {
                        Text("Username already exists")
                            .font(.title)
                            .foregroundColor(.yellow)
                            .bold()
                            .transition(.opacity)
                            .padding(.bottom, 10)
                    }
                }
            }

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
                buttonText: $buttonText
            )
            .padding(.top, 20)
        }
        .navigationBarBackButtonHidden(true)
    }
}

// MARK: - Preview
#Preview {
    CreateUserScreenView()
}
