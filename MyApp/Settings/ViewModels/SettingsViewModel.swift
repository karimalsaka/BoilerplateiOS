import Foundation

final class SettingsViewModel: ObservableObject {
    var authManager: AuthManager

    init(authManager: AuthManager) {
        self.authManager = authManager
    }
    
    func signOut() throws {
        try authManager.signOut()
    }
}
