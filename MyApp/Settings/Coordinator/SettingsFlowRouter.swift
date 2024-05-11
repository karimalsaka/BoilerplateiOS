import SwiftUI

enum SettingsFlowRouter: NavigationRouter, Equatable {
    case settings(authManager: AuthManager, userManager: UserManager)
    case accountSettings
    case paywall
        
    var transition: NavigationTranisitionStyle {
        switch self {
        case .settings, .accountSettings:
            return .push
        case .paywall:
            return .presentModally
        }
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
        case .paywall:
            PaywallView()
        }
    }
}
