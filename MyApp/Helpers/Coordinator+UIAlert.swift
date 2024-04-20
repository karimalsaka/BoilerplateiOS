import UIKit
import SwiftUI

extension Coordinator {
    func showAlert(title: String, message: String, actions: [UIAlertAction], style: UIAlertController.Style = .alert, showOkButton: Bool = false, showCancelButton: Bool = false, leftAlign: Bool = false) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: style)
        
        for action in actions {
            let customAction = action
            if leftAlign {
                customAction.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            }
            alertVC.addAction(customAction)
        }
        
        if showOkButton {
            alertVC.addAction(UIAlertAction(title: "OK", style: .default))
        }
        
        if showCancelButton {
            alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        }

        navigationController.present(alertVC, animated: true)
    }
    
    func showErrorAlert(_ message: String) {
        showAlert(title: "Error", message: message, actions: [], showOkButton: true)
    }
}
