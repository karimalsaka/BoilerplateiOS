import Foundation
import RevenueCat

enum PurchasesError: Error {
    case userCancelledPurchase
    case unknownPurchasesError
}

final class PurchasesManager: NSObject {
    static let shared = PurchasesManager()
//    let purchases = Purchases.shared
    
    private override init() {}

    func loginUser(uid: String) async throws {
//        let (_, _) = try await Purchases.shared.logIn(uid)
    }

    @discardableResult
    func getSubscriptionStatus() async -> Bool {
//        let customerInfo = try? await Purchases.shared.customerInfo()
//        let isUserSubscribed = customerInfo?.entitlements["premium"]?.isActive == true
//        return isUserSubscribed
        return false
    }

    func showManageSubscriptions() async throws {
//        try await purchases.showManageSubscriptions()
    }
}
