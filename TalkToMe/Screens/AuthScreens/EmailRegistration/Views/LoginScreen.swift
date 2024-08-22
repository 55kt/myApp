import SwiftUI

struct LoginScreen: View {
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                AuthHeader()
                
                AuthTextField(type: .email, text: .constant(""))
                AuthTextField(type: .password, text: .constant(""))
                
                forgotPasswordButton()
                
                AuthButton(buttonName: "Log In", buttonAction: {
                    // Some Action
                })
                Spacer()
                
                signUpButton()
                    .padding(.bottom)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(IntroGradient())
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
            Text("Sign up view placeholder")
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
