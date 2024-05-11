import SwiftUI
import RevenueCatUI

struct HomeView: View {
    @EnvironmentObject var coordinator: HomeFlowCoordinator<HomeFlowRouter>
    @StateObject private var viewModel: HomeViewModel
    @State var showPaywallOnLaunch: Bool = true
    
    init(viewModel: HomeViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
         ScrollView {
             VStack {
                    Text("Welcome to your home screen")
                        .font(.headline)
                        .fontWeight(.semibold)
                Spacer()
            }
            .padding()
            .navigationTitle("Home")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
         }.onAppear {
             coordinator.showATTPermissionsAlert()
             if showPaywallOnLaunch {
                 showPaywallOnLaunch = false
                 Task {
                     if await !PurchasesManager.shared.getSubscriptionStatus() {
                         coordinator.show(.paywall)
                     }
                 }
                 
             }
         }
    }
}

#Preview {
    let viewModel = HomeViewModel()
    return HomeView(viewModel: viewModel)
}
