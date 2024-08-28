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
            try await FirebaseConstants.UserRef.child(user.uid).setValue(userDictionary)
        } catch {
            print("🔐 Failed to save created user info in database: \(error.localizedDescription)")
            throw AuthError.failedToSaveUserInfo(error.localizedDescription)
        }
    }
    
    // Function for fetch current user information
    private func fetchCurrentUserInfo() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        FirebaseConstants.UserRef.child(currentUid).observe(.value) {[weak self] snapshot in
            
            guard let userDict = snapshot.value as? [String: Any] else { return }
            let loggedInUser = UserItem(dictionary: userDict)
            self?.authState.send(.loggedIn(loggedInUser))
            print("🔐 \(loggedInUser.username) is logged in")
        } withCancel: { error in
            print("Failed to get current user info")
        }
        
    }
}

extension AuthManager {
    static let testAccounts: [String] = [
        "john.doe@example.com",
        "jane.smith@example.com",
        "michael.brown@example.com",
        "lisa.johnson@example.com",
        "chris.evans@example.com",
        "emily.clark@example.com",
        "david.miller@example.com",
        "sarah.wilson@example.com",
        "daniel.jones@example.com",
        "laura.moore@example.com",
        "steve.taylor@example.com",
        "kelly.anderson@example.com",
        "brandon.davis@example.com",
        "nicole.martin@example.com",
        "jason.harris@example.com",
        "rachel.walker@example.com",
        "kevin.hall@example.com",
        "angela.robinson@example.com",
        "joshua.young@example.com",
        "kimberly.king@example.com",
        "ryan.wright@example.com",
        "amanda.green@example.com",
        "patrick.lewis@example.com",
        "megan.lee@example.com",
        "andrew.thomas@example.com",
        "samantha.scott@example.com",
        "james.white@example.com",
        "ashley.adams@example.com",
        "robert.thompson@example.com",
        "olivia.baker@example.com",
        "alex.mitchell@example.com",
        "victoria.perez@example.com",
        "brian.roberts@example.com",
        "rebecca.carter@example.com",
        "anthony.phillips@example.com",
        "melissa.hernandez@example.com",
        "nathan.sanchez@example.com",
        "elizabeth.clark@example.com",
        "jacob.morris@example.com",
        "anna.rogers@example.com",
        "zachary.cook@example.com",
        "mia.morgan@example.com",
        "ethan.reed@example.com",
        "jessica.bailey@example.com",
        "austin.bell@example.com",
        "chloe.cooper@example.com",
        "matthew.richards@example.com",
        "madison.howard@example.com",
        "aaron.james@example.com",
        "hailey.wright@example.com"
    ]
}
