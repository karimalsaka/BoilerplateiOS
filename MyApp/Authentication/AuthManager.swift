import Foundation
import AuthenticationServices
import FirebaseAuth
import CryptoKit

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

final class AuthManager: NSObject {
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
    
    @discardableResult
    func signInWithApple(tokens: SignInWithAppleResult) async throws -> AuthUserModel {
        let credential = OAuthProvider.credential(withProviderID: "apple.com" , idToken: tokens.token, rawNonce: tokens.nonce)
        return try await signIn(credential: credential)
    }
    
    func signIn(credential: AuthCredential) async throws -> AuthUserModel {
        let authDataResult = try await Auth.auth().signIn(with: credential)
        let model = AuthUserModel(user: authDataResult.user)
        return model
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

struct SignInWithAppleResult {
    let token: String
    let nonce: String
}

extension AuthManager: ASAuthorizationControllerDelegate {
}
