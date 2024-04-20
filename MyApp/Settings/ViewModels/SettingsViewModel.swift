import Foundation

final class SettingsViewModel: ObservableObject {
    private let authManager: AuthManager
    private let userManager: UserManager
    @Published var user: DBUser? = nil

    init(authManager: AuthManager, userManager: UserManager) {
        self.authManager = authManager
        self.userManager = userManager
        
        Task {
            try await loadUserInfo()
        }
    }
    
    func signOut() throws {
        try authManager.signOut()
    }
    
    func loadUserInfo() async throws {
        guard let userId = authManager.signedInUserId() else {
            throw AuthError.signInError
        }
        
        self.user = try await userManager.getUser(userId: userId)
    }
}
