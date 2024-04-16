import Foundation
import FirebaseAuth

struct AuthUserModel {
    let id: String
    let email: String?
    let photoUrl: URL?
    
    init(user: User) {
        self.id = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL
    }
}

final class AuthManager: Equatable {
    static func == (lhs: AuthManager, rhs: AuthManager) -> Bool {
        return true
    }

    @discardableResult
    func createUser(email: String, password: String) async throws -> AuthUserModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthUserModel(user: authDataResult.user)
    }
    
    @discardableResult 
    func signIn(email: String, password: String) async throws -> AuthUserModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthUserModel(user: authDataResult.user)
    }
    
    func signOut() throws {
        do {
            try Auth.auth().signOut()
        } catch {
            throw URLError(.unknown)
        }
    }
    
    func resetPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    func isUserSignedIn() -> Bool {
        return  Auth.auth().currentUser != nil
    }
}
