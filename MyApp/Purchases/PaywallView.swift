import SwiftUI
import RevenueCatUI

struct PaywallView: View {
    private var onPurchaseComplete: (() -> Void)?
    
    init(onPurchaseComplete: (() -> Void)? = nil) {
        self.onPurchaseComplete = onPurchaseComplete
    }
    
    var body: some View {
        RevenueCatUI.PaywallView(displayCloseButton: true)
            .tint(.designSystem(.primaryText))
            .onPurchaseCompleted { _ in
                onPurchaseComplete?()
            }
            .onRestoreCompleted { _ in
                onPurchaseComplete?()
            }
    }
}

#Preview {
    PaywallView()
}
