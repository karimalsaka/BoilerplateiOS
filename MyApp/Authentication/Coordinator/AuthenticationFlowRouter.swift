import SwiftUI

enum AuthenticationFlowRouter: NavigationRouter {
    case authenticationOptionsView(authManager: AuthManager)
    case signInWithServices(authManager: AuthManager)
    case signInWithEmail(authManager: AuthManager)
    case signUpWithEmail(authManager: AuthManager)
    case resetPassword(authManager: AuthManager)
    
    var transition: NavigationTranisitionStyle {
        .push
    }
    
    @MainActor @ViewBuilder
    func view() -> some View {
        switch self {
        case .authenticationOptionsView(let authManager):
            let viewModel = AuthenticationOptionsViewModel(authManager: authManager)
            AuthenticationOptionsView(viewModel: viewModel)
        case .signInWithServices(let _):
            EmptyView()
        case .signInWithEmail(let authManager):
            SignInWithEmailView(viewModel: SignInWithEmailViewModel(authManager: authManager))
        case .signUpWithEmail(let authManager):
            SignUpWithEmailView(viewModel: SignUpWithEmailViewModel(authManager: authManager))
        case .resetPassword(authManager: let authManager):
            let viewModel = ResetPasswordViewModel(authManager: authManager)
            ResetPasswordView(viewModel: viewModel)
        }
    }
}
