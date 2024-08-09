import SwiftUI

struct CreateUserScreenView: View {
    // MARK: - Properties
    @State private var textFieldContent: String = ""
    @State private var isKeyboardVisible: Bool = false
    @FocusState var isFocus: Bool
    
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
                TappedFieldText()
            }

            // Username TextField
            UsernameField(textPlaceholder: $textFieldContent, boolPlaceholder: $isKeyboardVisible)
                .focused($isFocus)
            
            // Submit Button
            SubmitButton(textPlaceholder: $textFieldContent, boolPlaceholder: $isKeyboardVisible)
        }
        .navigationBarBackButtonHidden(true)
        .onTapGesture {
            isFocus = false
        }
    }
}

// MARK: - Preview
#Preview {
    CreateUserScreenView()
}
