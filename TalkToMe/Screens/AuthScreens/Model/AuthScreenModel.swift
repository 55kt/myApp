import Foundation

@MainActor
final class AuthScreenModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var isLoading = false
    @Published var email = ""
    @Published var password = ""
    @Published var username = ""
    @Published var errorState: (showError: Bool, errorMessage: String) = (false, "ErrorState error Message !")
    
    // MARK: - Computed Properties
    var disableLoginButton: Bool {
        return email.isEmpty || password.isEmpty || isLoading
    }
    
    var disableSignUpButton: Bool {
        return email.isEmpty || password.isEmpty || username.isEmpty || isLoading
    }
    
    // Function for auth user
    func handleSignUp() async {
        isLoading = true
        do {
            try await AuthManager.shared.createAccount(for: username, with: email, and: password)
        } catch {
            self.errorState.errorMessage = "Failed to create account \(error.localizedDescription)"
            self.errorState.showError = true
            self.isLoading = false
        }
    }
}
