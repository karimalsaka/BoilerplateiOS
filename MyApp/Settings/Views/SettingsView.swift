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
                
                Section(header: Text("Notifications")) {
                    Toggle("Enable Notifications", isOn: $notificationsEnabled)
                        .tint(.designSystem(.primaryControlBackground))
                }
                
                Section(header: Text("Appearance")) {
                    Toggle("Dark Mode", isOn: $darkModeEnabled)
                        .tint(.designSystem(.primaryControlBackground))
                }
                
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
                        .foregroundStyle(Color.designSystem(.primaryControlText))
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.designSystem(.primaryControlBackground))
                        .cornerRadius(10)
                }
                .frame(maxWidth: .infinity)
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
        VStack(alignment: .center) {
            if let user = viewModel.user {
                Text("Welcome \(user.email ?? "")!")
                    .font(.subheadline)
                    .padding(.bottom, 5)
            }

            HStack {
                Text("Subscription")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
                Text(viewModel.isUserSubscribed ? "Active" : "Inactive")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(viewModel.isUserSubscribed ? Color.designSystem(.primaryControlBackground) : Color.designSystem(.disabledControlBackground))
            }

            Button {
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
                    .font(.headline)
                    .foregroundStyle(Color.designSystem(.primaryControlText))
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.designSystem(.primaryControlBackground))
                    .cornerRadius(10)
            }
        }
    }
}

#Preview {
    let viewModel = SettingsViewModel(authManager: AuthManager(), userManager: UserManager())
    return SettingsView(viewModel: viewModel)
}
