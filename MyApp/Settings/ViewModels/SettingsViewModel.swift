import Foundation
import RevenueCat

final class SettingsViewModel: ObservableObject {
    private let authManager: AuthManager
    private let userManager: UserManager
    @Published var user: DBUser? = nil
    @Published var isUserSubscribed: Bool = false

    init(authManager: AuthManager, userManager: UserManager) {
        self.authManager = authManager
        self.userManager = userManager
        
        Task {
            try await loadUserInfo()
            await getSubscriptionStatus()
        }
    }
    
    func showManageSubscriptions() async throws {
        try await PurchasesManager.shared.showManageSubscriptions()
    }
    
    func signOut() throws {
        try authManager.signOut()
    }
    
    func loadUserInfo() async throws {
        guard let userId = authManager.signedInUserId() else {
            throw AuthError.signInError
        }
        
        let user = try await userManager.getUser(userId: userId)
        await MainActor.run {
            self.user = user
        }
    }
    
    func getSubscriptionStatus() async {
        let isUserSubscribed = await PurchasesManager.shared.getSubscriptionStatus()
        
        await MainActor.run {
            self.isUserSubscribed = isUserSubscribed
        }
        return
    }
}
