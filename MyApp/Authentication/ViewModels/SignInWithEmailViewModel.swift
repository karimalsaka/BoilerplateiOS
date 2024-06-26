import Foundation

@MainActor
final class SignInWithEmailViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""

    var authManager: AuthManager
    private var userManager: UserManager

    init(authManager: AuthManager, userManager: UserManager) {
        self.authManager = authManager
        self.userManager = userManager
    }

    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            throw AuthError.signInError
        }
        
        try await authManager.signIn(email: email, password: password)
    }
}
