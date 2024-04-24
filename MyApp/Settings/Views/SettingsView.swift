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
        VStack(spacing: 20) {
            Group {
                if let user = viewModel.user {
                    Text("Welcome \(user.email ?? "")!")
                        .font(.subheadline)
                }

                subscriptionSection
                    .padding(.bottom, 10)
            }
            .padding(.horizontal, 20)

            List {
                Section(header: Text("Notifications")) {
                    Toggle("Enable Notifications", isOn: $notificationsEnabled)
                        .tint(.cyan)
                }
                
                Section(header: Text("Appearance")) {
                    Toggle("Dark Mode", isOn: $darkModeEnabled)
                        .tint(.cyan)
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
        }.onAppear {
            Task {
                await viewModel.getSubscriptionStatus()
            }
        }
    }

    var subscriptionSection: some View {
        VStack {
            HStack {
                Text("Subscription")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
                Text(viewModel.isUserSubscribed ? "Active" : "Inactive")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(viewModel.isUserSubscribed ? Color.cyan : Color.gray)
            }

            Button {
                Task {
                    do {
                        try await viewModel.showManageSubscriptions()
                    } catch {
                        coordinator.showErrorAlert(error.localizedDescription)
                    }
                }
            } label: {
                Text(viewModel.isUserSubscribed ? "Manage Subscription" : "Subscribe!")
                    .font(.headline)
                    .foregroundStyle(Color.white)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(Color.cyan)
                    .cornerRadius(20)
            }
        }
    }
}

#Preview {
    let viewModel = SettingsViewModel(authManager: AuthManager(), userManager: UserManager())
    return SettingsView(viewModel: viewModel)
}
