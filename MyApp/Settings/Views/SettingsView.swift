import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var coordinator: SettingsFlowCoordinator<SettingsFlowRouter>
    @StateObject private var viewModel: SettingsViewModel
  
    @State private var notificationsEnabled = true
    @State private var darkModeEnabled = false

    init(viewModel: SettingsViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack {
            if let user = viewModel.user {
                Text("Welcome \(user.email ?? "")!")
                    .font(.subheadline)
            }
            
            List {
                Section(header: Text("Notifications")) {
                    Toggle("Enable Notifications", isOn: $notificationsEnabled)
                        .tint(.cyan)
                }
                
                Section(header: Text("Appearance")) {
                    Toggle("Dark Mode", isOn: $darkModeEnabled)
                        .tint(.cyan)
                }
                
                Section(header: Text("Subscription")) {
                    Button(action: {
                        Task {
                            do {
                                try await viewModel.showManageSubscriptions()
                            } catch {
                                coordinator.showErrorAlert(error.localizedDescription)
                            }
                        }
                    }) {
                        HStack {
                            Text("Manage Subscription")
                            Spacer()
                        }
                    }
                }

                
                Section(header: Text("Account")) {
                    Button(action: {
                        coordinator.show(.accountSettings)
                    }) {
                        HStack {
                            Text("Manage Account")
                            Spacer()
                            Image(systemName: "arrow.right")
                                .foregroundStyle(Color.gray)
                        }
                    }
                }
                
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
                        .background(Color.cyan)
                        .cornerRadius(10)
                }
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .padding()
                .listRowSeparator(.hidden)

            }
            .listStyle(PlainListStyle())
            .frame(maxWidth: .infinity)
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    let viewModel = SettingsViewModel(authManager: AuthManager(), userManager: UserManager())
    return SettingsView(viewModel: viewModel)
}
