import SwiftUI

final class SettingsViewModel: ObservableObject {
    var authManager: AuthManager

    init(authManager: AuthManager) {
        self.authManager = authManager
    }
    
    func signOut() throws {
        try authManager.signOut()
    }
}

struct SettingsView: View {
    @EnvironmentObject var coordinator: SettingsFlowCoordinator<SettingsFlowRouter>
    @StateObject private var viewModel: SettingsViewModel

    init(viewModel: SettingsViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            Button {
                Task {
                    do {
                        try viewModel.signOut()
                        coordinator.userSignedOut()
                    } catch {
                        //MARK: show error alert to user
                        print("error")
                    }
                }
            } label: {
                Text("Sign Out")
                    .font(.headline)
                    .foregroundStyle(Color.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)

            }
        }
        .padding()
        .navigationTitle("Home")
    }
}

#Preview {
    let viewModel = SettingsViewModel(authManager: AuthManager())
    return SettingsView(viewModel: viewModel)
}
