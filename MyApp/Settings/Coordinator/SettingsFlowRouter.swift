import SwiftUI

enum SettingsFlowRouter: NavigationRouter, Equatable {
    case signOut(authManager: AuthManager)
    
    var title: String {
        switch self {
        case .signOut:
            return "Home"
        }
    }
    
//    var imageName: String {
//        switch self {
//        case .home:
//            return "ic_search_white"
//        }
//    }

    var transition: NavigationTranisitionStyle {
        .push
    }
    
    @MainActor @ViewBuilder
    func view() -> some View {
        switch self {
        case .signOut(let authManager):
            let viewModel = SettingsViewModel(authManager: authManager)
            SettingsView(viewModel: viewModel)
        }
    }
}
