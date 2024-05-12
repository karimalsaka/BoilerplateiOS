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
            List {
                subscriptionSection
                    .padding(.bottom, 10)
                    .padding(.horizontal, 10)
                    .listSectionSeparator(.hidden, edges: [.top, .bottom])
                    .listRowBackground(Color.clear)

                Section(header: Text("Notifications")) {
                    Toggle("Enable Notifications", isOn: $notificationsEnabled)
                        .tint(.designSystem(.primaryControlBackground))
                }
                .listRowBackground(Color.clear)

                Section(header: Text("Appearance")) {
                    Toggle("Dark Mode", isOn: $darkModeEnabled)
                        .tint(.designSystem(.primaryControlBackground))
                }
                .listRowBackground(Color.clear)

                Section(header: Text("Account")) {
                    Button(action: {
                        coordinator.show(.accountSettings)
                    }) {
                        HStack {
                            Text("Manage Account")
                            Spacer()
                            Image(systemName: "arrow.right")
                                .foregroundStyle(Color.designSystem(.primaryText))
                        }
                    }
                }
                .listRowBackground(Color.clear)

                Spacer()
                    .listRowBackground(Color.clear)

                PrimaryButton {
                    Task {
                        do {
                            try viewModel.signOut()
                            coordinator.userSignedOut()
                        } catch {
                            coordinator.showErrorAlert("Failed to sign out with error: \n \(error.localizedDescription)")
                        }
                    }
                } label: {
                    Text("Sign Out")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
            }
            .listStyle(PlainListStyle())
            .background(Color.clear)
            .frame(maxWidth: .infinity)
            .navigationTitle("Settings")
        }
        .background(Color.designSystem(.primaryBackground))
        .onAppear {
            Task {
                await viewModel.getSubscriptionStatus()
            }
        }
    }

    var subscriptionSection: some View {
        VStack(alignment: .center) {
            if let user = viewModel.user {
                Text("Welcome \(user.email ?? "")!")
                    .font(.designSystem(.heading3))
                    .padding(.bottom, 5)
            }

            HStack {
                Text("Subscription")
                    .font(.designSystem(.heading1))

                Spacer()

                Text(viewModel.isUserSubscribed ? "Active" : "Inactive")
                    .font(.designSystem(.heading1))
                    .foregroundStyle(viewModel.isUserSubscribed ? Color.designSystem(.primaryControlBackground) : Color.designSystem(.disabledControlBackground))
            }

            PrimaryButton {
                if !viewModel.isUserSubscribed {
                    coordinator.show(.paywall)
                } else {
                    Task {
                        do {
                            try await viewModel.showManageSubscriptions()
                        } catch {
                            coordinator.showErrorAlert(error.localizedDescription)
                        }
                    }
                }
            } label: {
                Text(viewModel.isUserSubscribed ? "Manage Subscription" : "Subscribe!")
            }
        }
    }
}

#Preview {
    let viewModel = SettingsViewModel(authManager: AuthManager(), userManager: UserManager())
    return SettingsView(viewModel: viewModel)
}
