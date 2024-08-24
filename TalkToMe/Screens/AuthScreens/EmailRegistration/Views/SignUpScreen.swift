import SwiftUI

struct SignUpScreen: View {
    // MARK: - Properties
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var authScreenModel: AuthScreenModel
    
    // MARK: - Body
    var body: some View {
        VStack {
            Spacer()
            
            AuthHeader()
            AuthTextField(type: .email, text: $authScreenModel.email)
                        
            AuthTextField(type: .custom("Username", "at"), text: $authScreenModel.username)
            
            AuthTextField(type: .password, text: $authScreenModel.password)
            
            AuthButton(buttonName: "Create an account") {
                Task { await authScreenModel.handleSignUp() }
            }
            .disabled(authScreenModel.disableSignUpButton)
            
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
    SignUpScreen(authScreenModel: AuthScreenModel())
}
