import SwiftUI

enum SettingsFlowRouter: NavigationRouter, Equatable {
    case settings(authManager: AuthManager, userManager: UserManager)
    case accountSettings
        
    var transition: NavigationTranisitionStyle {
        .push
    }
    
    @MainActor @ViewBuilder
    func view() -> some View {
        switch self {
        case .settings(let authManager, let userManager):
            let viewModel = SettingsViewModel(authManager: authManager, userManager: userManager)
            SettingsView(viewModel: viewModel)
        case .accountSettings:
            let viewModel = ManageAccountViewModel()
            ManageAccountView(viewModel: viewModel)
        }
    }
}
