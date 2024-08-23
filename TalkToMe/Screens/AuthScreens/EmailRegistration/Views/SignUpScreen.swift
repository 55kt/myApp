import SwiftUI

struct SignUpScreen: View {
    // MARK: - Properties
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var asm: AuthScreenModel
    
    // MARK: - Body
    var body: some View {
        VStack {
            Spacer()
            
            AuthHeader()
            AuthTextField(type: .email, text: $asm.email)
            
            let userNameInputType = AuthTextField.InputType.custom("Username", "at")
            
            AuthTextField(type: userNameInputType, text: $asm.username)
            
            AuthTextField(type: .password, text: $asm.password)
            
            AuthButton(buttonName: "Create an account") {
                Task { await asm.handleSignUp() }
            }
            .disabled(asm.disableSignUpButton)
            
            Spacer()
            
            loginBackButton()
                .padding(.bottom, 30)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background{
            IntroGradient()
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
    }
    
    private func loginBackButton() -> some View {
        Button {
            dismiss()
        } label: {
            HStack {
                Image(systemName: "sparkles")
                
                (
                    Text("Already created an account ? ")
                    +
                    Text("Log In!")
                )
                
                Image(systemName: "sparkles")
            }
            .foregroundStyle(.white)
            .bold()
        }
    }
}
// MARK: - Preview
#Preview {
    SignUpScreen(asm: AuthScreenModel())
}
