import Foundation

@MainActor
final class SignUpWithEmailViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""

    private var authManager: AuthManager

    init(authManager: AuthManager) {
        self.authManager = authManager
    }

    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            return
        }
        try await authManager.createUser(email: email, password: password)
    }
}
