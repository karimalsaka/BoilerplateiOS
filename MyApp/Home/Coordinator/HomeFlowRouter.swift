import SwiftUI

enum HomeFlowRouter: NavigationRouter, Equatable {
    case home
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        }
    }
    
//    var imageName: String {
//        switch self {
//        case .home:
//            return "ic_search_white"
//        }
//    }

    var transition: NavigationTranisitionStyle {
        switch self {
        case .home:
            return .push
        }
    }
    
    @MainActor @ViewBuilder
    func view() -> some View {
        switch self {
        case .home:
            let viewModel = HomeViewModel()
            HomeView(viewModel: viewModel)
        }
    }
}
