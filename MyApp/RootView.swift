import SwiftUI


final class RootViewModel: ObservableObject {
    let authManager = AuthManager()
    
    var userSignedIn: Bool {
        authManager.isUserSignedIn()
    }
}

struct RootView: View {
    @StateObject private var viewModel: RootViewModel
    @State private var shouldShowSignIn: Bool
    
    init(viewModel: RootViewModel = RootViewModel()) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self._shouldShowSignIn = .init(initialValue: !viewModel.userSignedIn)
    }
    
    var body: some View {
        NavigationStack {
            showHomeView()
        }
        .fullScreenCover(isPresented: $shouldShowSignIn) {
            NavigationStack {
                showAuthenticationFlow()
            }
        }
    }
    
    func showAuthenticationFlow() -> some View {
        let authenticationViewModel = AuthenticationViewModel(authManager: viewModel.authManager)
        return AuthenticationView(viewModel: authenticationViewModel, shouldShowSignIn: $shouldShowSignIn)
    }
    
    func showHomeView() -> some View {
        let homeViewModel = HomeViewModel(authManager: viewModel.authManager)
        return HomeView(viewModel: homeViewModel, shouldShowSignIn: $shouldShowSignIn)
    }
}

#Preview {
    RootView()
}
