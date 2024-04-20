import Foundation

@MainActor
final class SignUpWithEmailViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""

    private var authManager: AuthManager
    private var userManager: UserManager

    init(authManager: AuthManager, userManager: UserManager) {
        self.authManager = authManager
        self.userManager = userManager
    }

    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            throw AuthError.signUpError
        }
        let authDataResult = try await authManager.createUser(email: email, password: password)
        try await userManager.createNewUser(auth: authDataResult)
    }
}
