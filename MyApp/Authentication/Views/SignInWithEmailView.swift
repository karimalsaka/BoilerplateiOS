import SwiftUI

struct SignInWithEmailView: View {
    @EnvironmentObject var coordinator: AuthenticationFlowCoordinator<AuthenticationFlowRouter>
    @StateObject private var viewModel: SignInWithEmailViewModel

    init(viewModel: SignInWithEmailViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Email", text: $viewModel.email)
                .padding()
                .background(Color.designSystem(.secondaryBackground).opacity(0.2))
                .cornerRadius(10)
            
            SecureField("Password", text: $viewModel.password)
                .padding()
                .background(Color.designSystem(.secondaryBackground).opacity(0.2))
                .cornerRadius(10)
            
            Button {
                Task {
                    do {
                        try await viewModel.signIn()
                        coordinator.userSignedIn()
                    } catch {
                        coordinator.showErrorAlert("Failed to sign in with error: \n \(error.localizedDescription)")
                    }
                }
                
            } label: {
                Text("Sign In")
                    .font(.headline)
                    .foregroundStyle(Color.designSystem(.primaryControlText))
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.designSystem(.primaryControlBackground))
                    .cornerRadius(5)
            }
            .padding(.bottom, 20)
            
            Text("Forgot password?")
                .padding(.bottom, 5)
            
            Button {
                coordinator.show(.resetPassword(authManager: viewModel.authManager))
            } label: {
                Text("Reset my password")
                    .font(.headline)
                    .tint(.blue)
                    .foregroundStyle(Color.designSystem(.secondaryControlText))
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.designSystem(.secondaryControlText), lineWidth: 1)
                )
            }
        }
        .padding()
        .navigationTitle("Sign in with email")
        
    }
}

#Preview {
    let authManger = AuthManager()
    let userManager = UserManager()

    let viewModel = SignInWithEmailViewModel(
        authManager: authManger,
        userManager: userManager
    )
    return SignInWithEmailView(viewModel: viewModel)
}
