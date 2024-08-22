import SwiftUI

struct LoginScreen: View {
    // MARK: - Properties
    @StateObject private var asm = AuthScreenModel()
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                AuthHeader()
                
                AuthTextField(type: .email, text: $asm.email)
                AuthTextField(type: .password, text: $asm.password)
                
                forgotPasswordButton()
                
                AuthButton(buttonName: "Log In", buttonAction: {
                    // Some Action
                })
                .disabled(asm.disableLoginButton)
                Spacer()
                
                signUpButton()
                    .padding(.bottom, 30)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(GrayGradient())
            .ignoresSafeArea()
        }
    }
    
    // MARK: - Methods
    // Forgot password function
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
    
    // Sign up function
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
