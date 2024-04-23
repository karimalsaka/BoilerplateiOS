import SwiftUI
import RevenueCatUI

struct HomeView: View {
    @EnvironmentObject var coordinator: HomeFlowCoordinator<HomeFlowRouter>
    @StateObject private var viewModel: HomeViewModel

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
         }
         .presentPaywallIfNeeded(
            requiredEntitlementIdentifier: "premium",
            purchaseFailure: { error in
                print("purchase failed with error \(error.localizedDescription)")
                
            }        
         )
    }
}

#Preview {
    let viewModel = HomeViewModel()
    return HomeView(viewModel: viewModel)
}
