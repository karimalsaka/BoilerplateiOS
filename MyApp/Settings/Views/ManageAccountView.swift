import SwiftUI

struct ManageAccountView: View {
    @EnvironmentObject var coordinator: SettingsFlowCoordinator<SettingsFlowRouter>
    @StateObject private var viewModel: ManageAccountViewModel
  
    init(viewModel: ManageAccountViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
        }
        .navigationTitle("Account settings")
    }
}

#Preview {
    let viewModel = ManageAccountViewModel()
    return ManageAccountView(viewModel: viewModel)
}
