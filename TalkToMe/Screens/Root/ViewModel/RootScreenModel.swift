import Foundation
import Combine

final class RootScreenModel: ObservableObject {
    @Published private(set) var authState = AuthState.pending
    private var cancallable: AnyCancellable?
    
    init() {
        cancallable = AuthManager.shared.authState.receive(on: DispatchQueue.main)
            .sink {[weak self] latestAuthState in
                self?.authState = latestAuthState
            }
        
        AuthManager.testAccounts.forEach { email in
            registerTestAccount(with: email)
        }
    }
    
    private func registerTestAccount(with email: String) {
        Task {
            let username = email.replacingOccurrences(of: "@example.com", with: "")
            try await AuthManager.shared.createAccount(for: username, with: email, and: "12345678")
        }
    }
}
