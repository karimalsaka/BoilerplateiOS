import SwiftUI

enum HomeFlowRouter: NavigationRouter, Equatable {
    case home
    case paywall
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .paywall:
            return "Paywall"

        }
    }

    var transition: NavigationTranisitionStyle {
        switch self {
        case .home:
            return .push
        case .paywall:
            return .presentModally
        }
    }
    
    @MainActor @ViewBuilder
    func view() -> some View {
        switch self {
        case .home:
            let viewModel = HomeViewModel()
            HomeView(viewModel: viewModel)
        case .paywall:
            PaywallView()
        }
    }
}
