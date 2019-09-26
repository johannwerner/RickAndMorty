import Foundation
import UIKit

extension UIApplication {
    static var mainWindow: UIWindow {
        keyWindowNullable ?? UIWindow()
    }
    
    static weak var someWindow: UIWindow?
}

private extension UIApplication {
    static var keyWindowNullable: UIWindow? {
         UIApplication.shared.connectedScenes
        .filter({$0.activationState == .foregroundActive})
        .compactMap({$0 as? UIWindowScene})
        .first?.windows
        .filter({$0.isKeyWindow})
        .first
    }
}
