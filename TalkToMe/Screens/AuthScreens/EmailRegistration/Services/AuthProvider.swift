import Foundation
import Combine
import FirebaseAuth
import FirebaseDatabase

enum AuthState {
    case pending, loggedIn(UserItem), loggedOut
}

protocol AuthProvider {
    
    // MARK: - Properties
    static var shared: AuthProvider { get }
    var authState: CurrentValueSubject<AuthState, Never> { get }
    func autoLogin() async
    func login(with email: String, and password: String) async throws
    func createAccount(for username: String, with email: String, and password: String) async throws
    func logOut() async throws
}

// Error Cases
enum AuthError: Error {
    case accountCreationFailed(_ description: String)
    case failedToSaveUserInfo(_ description: String)
    case emailLoginFailed(_ description: String)
}

// Errors for auth
extension AuthError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .accountCreationFailed(let description):
            return description
        case .failedToSaveUserInfo(let description):
            return description
        case .emailLoginFailed(let description):
            return description
        }
    }
}

// Class for auth
final class AuthManager: AuthProvider {
    private init() {
        Task { await autoLogin() }
    }
    
    static var shared: AuthProvider = AuthManager()
    
    var authState = CurrentValueSubject<AuthState, Never>(.pending)
    
    func autoLogin() async {
        if Auth.auth().currentUser == nil {
            authState.send(.loggedOut)
        } else {
            fetchCurrentUserInfo()
        }
    }
    
    // Function for login
    func login(with email: String, and password: String) async throws {
        do {
            let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
            fetchCurrentUserInfo()
            print("🔐 Successfully logged in \(authResult.user.email ?? "") !")
        } catch {
            print("🔐 Failed to logged into the account with: \(email) !")
            throw AuthError.emailLoginFailed(error.localizedDescription)
        }
    }
    
    // Function for create account
    func createAccount(for username: String, with email: String, and password: String) async throws {
            do {
                let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
                let uid = authResult.user.uid
                let newUser = UserItem(uid: uid, username: username, email: email)
                try await saveUserInfoDatabase(user: newUser)
                self.authState.send(.loggedIn(newUser))
            } catch {
                print("🔐 Failed to Create an Account: \(error.localizedDescription)")
                throw AuthError.accountCreationFailed(error.localizedDescription)
            }
        }
    
    // Function for logout
    func logOut() async throws {
        do {
            try Auth.auth().signOut()
            authState.send(.loggedOut)
            print("🔐 Successfully logged out !")
        } catch {
            print("🔐 Failed to logout current user: \(error.localizedDescription)")
        }
    }
    
}

// Extension for AuthManager
extension AuthManager {
    private func saveUserInfoDatabase(user: UserItem) async throws {
        do {
            let userDictionary: [String: Any] = [.uid: user.uid, .username: user.username, .email: user.email]
            try await FirebaseConstants.UsersRef.child(user.uid).setValue(userDictionary)
        } catch {
            print("🔐 Failed to save created user info in database: \(error.localizedDescription)")
            throw AuthError.failedToSaveUserInfo(error.localizedDescription)
        }
    }
    
    // Function for fetch current user information
    private func fetchCurrentUserInfo() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        FirebaseConstants.UsersRef.child(currentUid).observe(.value) {[weak self] snapshot in
            
            guard let userDict = snapshot.value as? [String: Any] else { return }
            let loggedInUser = UserItem(dictionary: userDict)
            self?.authState.send(.loggedIn(loggedInUser))
            print("🔐 \(loggedInUser.username) is logged in")
        } withCancel: { error in
            print("Failed to get current user info")
        }
        
    }
}
