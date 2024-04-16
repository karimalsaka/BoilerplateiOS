import SwiftUI

final class HomeViewModel: ObservableObject {
    
}

struct HomeView: View {
    @EnvironmentObject var coordinator: HomeFlowCoordinator<HomeFlowRouter>
    @StateObject private var viewModel: HomeViewModel

    init(viewModel: HomeViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Home")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("This is home")
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }
            .padding()
            .navigationTitle("Home")
            .frame(maxWidth: .infinity)

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    let viewModel = HomeViewModel()
    return HomeView(viewModel: viewModel)
}
