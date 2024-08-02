import SwiftUI

enum SettingsFlowRouter: NavigationRouter, Equatable {
    static func == (lhs: SettingsFlowRouter, rhs: SettingsFlowRouter) -> Bool {
        switch (lhs, rhs) {
        case (.paywall(let lhsOnPurchaseComplete), .paywall(let rhsOnPurchaseComplete)):
            return lhsOnPurchaseComplete == nil && rhsOnPurchaseComplete == nil
        default:
            return true
        }
    }
    
    case settings(authManager: AuthManager, userManager: UserManager)
    case accountSettings
    case paywall(onPurchaseComplete: (() -> Void)? = nil)
        
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
        case .paywall(let onPurchaseComplete):
            PaywallView(onPurchaseComplete: onPurchaseComplete)
        }
    }
}
