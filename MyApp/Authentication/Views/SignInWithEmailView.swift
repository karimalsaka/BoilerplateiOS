import SwiftUI

struct SignInWithEmailView: View {
    @EnvironmentObject var coordinator: AuthenticationFlowCoordinator<AuthenticationFlowRouter>
    @StateObject private var viewModel: SignInWithEmailViewModel

    init(viewModel: SignInWithEmailViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    var body: some View {
        VStack {
            TextField("Email", text: $viewModel.email)
                .padding()
                .background(Color.gray.opacity(0.3))
                .cornerRadius(10)
            
            SecureField("Password", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.3))
                .cornerRadius(10)
            
            Button {
                Task {
                    do {
                        try await viewModel.signIn()
                        coordinator.userSignedIn()
                    } catch {
                        //MARK: show error alert to user
                        print("failed to sign in with error \(error)")
                    }
                }
                
            } label: {
                Text("Sign In")
                    .font(.headline)
                    .foregroundStyle(Color.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.cyan)
                    .cornerRadius(10)
            }
        }
        .padding()
        .navigationTitle("Sign in with email")
        
    }
}

#Preview {
    let authManger = AuthManager()
    let viewModel = SignInWithEmailViewModel(authManager: authManger)
    return SignInWithEmailView(viewModel: viewModel)
}
