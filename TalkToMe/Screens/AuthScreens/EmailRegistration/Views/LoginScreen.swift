import SwiftUI

struct LoginScreen: View {
    // MARK: - Properties
    @StateObject private var authScreenModel = AuthScreenModel()
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                AuthHeader()
                
                AuthTextField(type: .email, text: $authScreenModel.email)
                AuthTextField(type: .password, text: $authScreenModel.password)
                
                forgotPasswordButton()
                
                AuthButton(buttonName: "Log In", buttonAction: {
                    Task {
                        await authScreenModel.handleSignUp()
                    }
                })
                .disabled(authScreenModel.disableLoginButton)
                Spacer()
                
                signUpButton()
                    .padding(.bottom, 30)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(GrayGradient())
            .ignoresSafeArea()
            .alert(isPresented: $authScreenModel.errorState.showError) {
                Alert(
                    title: Text(authScreenModel.errorState.errorMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
    
    // MARK: - Methods
    private func forgotPasswordButton() -> some View {
        Button {
            // Some action
        } label: {
            Text("Forgot Password ?")
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, 32)
                .bold()
                .padding(.vertical)
        }
    }
    
    private func signUpButton() -> some View {
        NavigationLink {
            SignUpScreen(asm: AuthScreenModel())
        } label: {
            HStack {
                Image(systemName: "sparkles")
                
                (
                    Text("Don't have an account ? ")
                    +
                    Text("Create one!")
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
    LoginScreen()
}
