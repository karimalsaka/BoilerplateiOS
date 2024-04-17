import SwiftUI

enum SettingsFlowRouter: NavigationRouter, Equatable {
    case settings(authManager: AuthManager)
    case accountSettings
        
    var transition: NavigationTranisitionStyle {
        .push
    }
    
    @MainActor @ViewBuilder
    func view() -> some View {
        switch self {
        case .settings(let authManager):
            let viewModel = SettingsViewModel(authManager: authManager)
            SettingsView(viewModel: viewModel)
        case .accountSettings:
            let viewModel = ManageAccountViewModel()
            ManageAccountView(viewModel: viewModel)
        }
    }
}
