import SwiftUI

@MainActor
final class AuthenticationViewModel: ObservableObject {
    var authManager: AuthManager
    
    init(authManager: AuthManager) {
        self.authManager = authManager
    }
}

struct AuthenticationView: View {
    @StateObject private var viewModel: AuthenticationViewModel
    @Binding private var shouldShowSignIn: Bool
    
    init(viewModel: AuthenticationViewModel, shouldShowSignIn: Binding<Bool>) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self._shouldShowSignIn = shouldShowSignIn
    }
    
    var body: some View {
        VStack {
            NavigationLink {
                let viewModel = SignUpWithEmailViewModel(authManager: viewModel.authManager)
                SignUpWithEmailView(viewModel: viewModel, shouldShowSignIn: $shouldShowSignIn)
            } label: {
                Text("Sign Up with Email")
                    .font(.headline)
                    .foregroundStyle(Color.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }

            NavigationLink {
                let viewModel = SignInWithEmailViewModel(authManager: viewModel.authManager)
                SignInWithEmailView(viewModel: viewModel, shouldShowSignIn: $shouldShowSignIn)
            } label: {
                Text("Sign In with Email")
                    .font(.headline)
                    .foregroundStyle(Color.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            NavigationLink {
                let viewModel = ResetPasswordViewModel(authManager: viewModel.authManager)
                ResetPasswordView(viewModel: viewModel, shouldShowSignIn: $shouldShowSignIn)
            } label: {
                Text("Forgot Password?")
                    .font(.headline)
                    .foregroundStyle(Color.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
        .navigationTitle("Sign In")
    }
}

#Preview {
    let authManager = AuthManager()
    let viewModel = AuthenticationViewModel(authManager: authManager)
    
    return NavigationStack {
        AuthenticationView(viewModel: viewModel, shouldShowSignIn: .constant(true))
    }
}
