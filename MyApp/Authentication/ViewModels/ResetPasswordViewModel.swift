import Foundation

@MainActor
final class ResetPasswordViewModel: ObservableObject {
    @Published var email = ""
    
    private var authManager: AuthManager

    init(authManager: AuthManager) {
        self.authManager = authManager
    }

    func resetPassword() async throws {
        guard !email.isEmpty else {
            throw AuthError.resetPasswordError
        }
        
        try await authManager.resetPassword(email: email)
    }
}

