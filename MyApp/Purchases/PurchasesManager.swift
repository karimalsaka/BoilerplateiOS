import Foundation
import RevenueCat

enum PurchasesError: Error {
    case userCancelledPurchase
    case unknownPurchasesError
}

final class PurchasesManager: NSObject {
    static let shared = PurchasesManager()
    let purchases = Purchases.shared

    var isUserSubscribed: Bool = false

    private override init() {}

    func loginUser(uid: String) {
        Purchases.shared.logIn(uid) { (customerInfo, created, error) in
            self.isUserSubscribed = customerInfo?.entitlements["premium"]?.isActive == true
        }
    }
    
    func refreshSubscriptionStatus() async {
        let customerInfo = try? await Purchases.shared.customerInfo()
        self.isUserSubscribed = customerInfo?.entitlements["premium"]?.isActive == true
    }
    
    func showManageSubscriptions() async throws {
        try await purchases.showManageSubscriptions()
    }
}
