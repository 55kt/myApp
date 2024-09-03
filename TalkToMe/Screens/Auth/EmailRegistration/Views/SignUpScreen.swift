import SwiftUI

struct SignUpScreen: View {
    
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var authScreenModel: AuthScreenModel
    
    var body: some View {
        VStack {
            Spacer()
            AuthHeaderView()
            AuthTextField(type: .email, text: $authScreenModel.email)
            
            let usernameType = AuthTextField.InputType.custom("Username", "at")
            
            AuthTextField(type: usernameType, text: $authScreenModel.username)
            
            AuthTextField(type: .password, text: $authScreenModel.password)
            
            AuthButton(title: "Create an Account") {
                Task { await authScreenModel.handleSignUp() }
            }
            .disabled(authScreenModel.disableSignUpButton)
            
            Spacer()
            
            backButton()
                .padding(.bottom, 30)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            LinearGradient(colors: [.green, .green.opacity(0.8), .teal], startPoint: .top, endPoint: .bottom)
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden()
    }
    
    private func backButton() -> some View {
        Button {
            dismiss()
        } label: {
            HStack {
                Image(systemName: "sparkles")
                
                (
                    Text("Already created an account ? ")
                    +
                    Text("Log in").bold()
                
                )
                Image(systemName: "sparkles")
            }
            .foregroundStyle(.white)
        }
    }
}

#Preview {
    SignUpScreen(authScreenModel: AuthScreenModel())
}

