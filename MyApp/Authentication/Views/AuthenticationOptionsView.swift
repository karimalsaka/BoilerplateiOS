import SwiftUI

@MainActor
final class AuthenticationOptionsViewModel: ObservableObject {
    var authManager: AuthManager
    
    init(authManager: AuthManager) {
        self.authManager = authManager
    }
}

struct AuthenticationOptionsView: View {
    @EnvironmentObject var coordinator: AuthenticationFlowCoordinator<AuthenticationFlowRouter>
    @StateObject private var viewModel: AuthenticationOptionsViewModel
    
    init(viewModel: AuthenticationOptionsViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    
                    // replace with image lol
                    Rectangle()
                        .foregroundStyle(Color.cyan)
                        .frame(width: .infinity, height: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(.top, 30)
                        .padding(.bottom, 50)
                     Spacer()

                    Button {
                        coordinator.show(.signUpWithEmail(authManager: viewModel.authManager))
                    } label: {
                        Text("Sign Up with Email")
                            .font(.headline)
                            .foregroundStyle(Color.white)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color.cyan)
                            .cornerRadius(10)
                    }

                    Button {
                        coordinator.show(.signInWithEmail(authManager: viewModel.authManager))
                    } label: {
                        Text("Sign In with Email")
                            .font(.headline)
                            .foregroundStyle(Color.white)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color.cyan)
                            .cornerRadius(10)
                    }
                    
                    Button {
                        coordinator.show(.resetPassword(authManager: viewModel.authManager))
                    } label: {
                        Text("Forgot Password?")
                            .font(.headline)
                            .foregroundStyle(Color.white)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                     
                     Spacer()
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    let authManager = AuthManager()
    let viewModel = AuthenticationOptionsViewModel(authManager: authManager)

    return AuthenticationOptionsView(viewModel: viewModel)
}
