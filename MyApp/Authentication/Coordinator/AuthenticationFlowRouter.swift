import SwiftUI

enum AuthenticationFlowRouter: NavigationRouter {
    case authenticationOptionsView(authManager: AuthManager, userManager: UserManager)
    case signInWithEmail(authManager: AuthManager, userManager: UserManager)
    case signUpWithEmail(authManager: AuthManager, userManager: UserManager)
    case resetPassword(authManager: AuthManager)
    
    var transition: NavigationTranisitionStyle {
        .push
    }
    
    @MainActor @ViewBuilder
    func view() -> some View {
        switch self {
        case .authenticationOptionsView(let authManager, let userManager):
            let viewModel = AuthenticationOptionsViewModel(authManager: authManager, userManager: userManager)
            AuthenticationOptionsView(viewModel: viewModel)

        case .signInWithEmail(let authManager, let userManager):
            let viewModel = SignInWithEmailViewModel(
                authManager: authManager,
                userManager: userManager
            )
            SignInWithEmailView(viewModel: viewModel)

        case .signUpWithEmail(let authManager, let userManager):
            let viewModel = SignUpWithEmailViewModel(
                authManager: authManager,
                userManager: userManager
            )
            SignUpWithEmailView(viewModel: viewModel)

        case .resetPassword(let authManager):
            let viewModel = ResetPasswordViewModel(authManager: authManager)
            ResetPasswordView(viewModel: viewModel)
        }
    }
}
