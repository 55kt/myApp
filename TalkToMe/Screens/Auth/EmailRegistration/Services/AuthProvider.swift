import Foundation
import Combine
import FirebaseAuth
import FirebaseDatabase

enum AuthState {
    case pending, loggedIn(UserItem), loggedOut
}

protocol AuthProvider {
    static var shared: AuthProvider { get }
    var authState: CurrentValueSubject<AuthState, Never> { get }
    func autoLogin() async
    func login(with email: String, and password: String) async throws
    func createAccount(for username: String, with email: String, and password: String) async throws
    func logOut() async throws
}

enum AuthError: Error {
    case accountCreationFailed(_ description: String)
    case failedToSaveUserInfo(_ description: String)
    case emailLoginFailed(_ description: String)
}

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

final class AuthManager: AuthProvider {
    
    private init() {
        Task { await autoLogin() }
    }
    
    static let shared: AuthProvider = AuthManager()
    
    var authState = CurrentValueSubject<AuthState, Never>(.pending)
    
    func autoLogin() async {
        if Auth.auth().currentUser == nil {
            authState.send(.loggedOut)
        } else {
            fetchCurrentUserInfo()
        }
    }
    
    func login(with email: String, and password: String) async throws {
        do {
            let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
            fetchCurrentUserInfo()
            print("🔐 Successfully Signed In \(authResult.user.email ?? "") ")
        } catch {
            print("🔐 Failed to Sign Into the Account with: \(email)")
            throw AuthError.emailLoginFailed(error.localizedDescription)
        }
    }
    
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
    
    func logOut() async throws {
        do {
            try Auth.auth().signOut()
            authState.send(.loggedOut)
            print("🔐 Successfully logged out!")
        } catch {
            print("🔐 Failed to logOut current User: \(error.localizedDescription)")
        }
    }
}

extension AuthManager {
    private func saveUserInfoDatabase(user: UserItem) async throws {
        do {
            let userDictionary: [String: Any] = [.uid : user.uid, .username : user.username, .email : user.email]
            try await FirebaseConstants.UserRef.child(user.uid).setValue(userDictionary)
        } catch {
            print("🔐 Failed to Save Created user Info to Database: \(error.localizedDescription)")
            throw AuthError.failedToSaveUserInfo(error.localizedDescription)
        }
    }
    
    private func fetchCurrentUserInfo() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        FirebaseConstants.UserRef.child(currentUid).observeSingleEvent(of: .value) {[weak self] snapshot in
            
            guard let userDict = snapshot.value as? [String: Any] else { return }
            let loggedInUser = UserItem(dictionary: userDict)
            self?.authState.send(.loggedIn(loggedInUser))
            print("🔐 \(loggedInUser.username) is logged in")
            print("🔐 \(loggedInUser.username)'s fcmToken is \(String(describing: loggedInUser.fcmToken))")
        } withCancel: { error in
            print("Failed to get current user info")
        }
    }
}

// MARK: - Test Users Email Direction
extension AuthManager {
    static let testAccounts: [String] = [
        "johndoe@example.com",
        "janesmith@example.com",
        "michaelbrown@example.com",
        "lisajohnson@example.com",
        "chrisevans@example.com",
        "emilyclark@example.com",
        "davidmiller@example.com",
        "sarahwilson@example.com",
        "danieljones@example.com",
        "lauramoore@example.com",
        "stevetaylor@example.com",
        "kellyanderson@example.com",
        "brandondavis@example.com",
        "nicolemartin@example.com",
        "jasonharris@example.com",
        "rachelwalker@example.com",
        "kevinhall@example.com",
        "angelarobinson@example.com",
        "joshuayoung@example.com",
        "kimberlyking@example.com",
        "ryanwright@example.com",
        "amandagreen@example.com",
        "patricklewis@example.com",
        "meganlee@example.com",
        "andrewthomas@example.com",
        "samanthascott@example.com",
        "jameswhite@example.com",
        "ashleyadams@example.com",
        "robertthompson@example.com",
        "oliviabaker@example.com",
        "alexmitchell@example.com",
        "victoriaperez@example.com",
        "brianroberts@example.com",
        "rebeccacarter@example.com",
        "anthonyphillips@example.com",
        "melissahernandez@example.com",
        "nathansanchez@example.com",
        "elizabethclark@example.com",
        "jacobmorris@example.com",
        "annarogers@example.com",
        "zacharycook@example.com",
        "miamorgan@example.com",
        "ethanreed@example.com",
        "jessicabailey@example.com",
        "austinbell@example.com",
        "chloecooper@example.com",
        "matthewrichards@example.com",
        "madisonhoward@example.com",
        "aaronjames@example.com",
        "haileywright@example.com"
    ]
}
