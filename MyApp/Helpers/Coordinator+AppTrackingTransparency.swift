import UIKit
import SwiftUI
import AdSupport
import AppTrackingTransparency

extension Coordinator {
    @MainActor
    func showATTPermissionsAlert() {
        ATTrackingManager.requestTrackingAuthorization { status in
            switch status {
            case .authorized:
                let _ = ASIdentifierManager.shared().advertisingIdentifier
            case .denied, .notDetermined, .restricted:
                break
            @unknown default:
                break
            }
        }
    }
}
