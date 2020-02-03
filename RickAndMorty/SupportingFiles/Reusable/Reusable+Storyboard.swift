import Foundation
import UIKit

// Storyboard
extension UIStoryboard {
    /// Instantiates the storyboard for the given UIViewController type
    /// This means the view controller class and storyboard should be named the same
    ///
    /// ```
    /// let storyboard = UIStoryboard.instantiate(ofType: ReusableVC.self)
    /// ```
    /// - Parameters:
    ///   - type: Class type (storyboard should be named the same)
    ///   - bundle: Bundle where the file is, default is nil.
    /// - Returns: The instantiated Storyboard
    static func instantiate<T>(ofType type: T.Type = T.self, bundle: Bundle? = nil) -> UIStoryboard where T: UIViewController {
        let storyboard = UIStoryboard(name: type.reuseId, bundle: bundle)
        return storyboard
    }
    
    /// Instantiates the initial view controller for the given type
    ///
    /// ```
    /// let viewController = UIStoryboard.instantiateInitialViewController(ofType: ReusableVC.self, bundle: nil)
    /// ```
    /// - Parameters:
    ///   - type: Class type (identifier should be named the same)
    ///   - bundle: Bundle where the file is, default is nil.
    /// - Returns: The initial instantiated view controller
    static func instantiateInitialViewController<T>(ofType type: T.Type = T.self, bundle: Bundle? = nil) -> T where T: UIViewController {
        let storyboard = UIStoryboard(name: type.reuseId, bundle: bundle)
        guard let viewController = storyboard.instantiateInitialViewController() as? T else {
            fatalError()
        }
        return viewController
    }
    
    /// Instantiates the view controller with the given identifier
    ///
    /// ```
    /// let viewController = UIStoryboard.instantiateViewController(ofType: ReusableSecondVC.self, bundle: nil)
    /// ```
    /// - Parameter type: Class type (identifier should be named the same)
    /// - Returns: The UIViewController
    func instantiateViewController<T>(ofType type: T.Type = T.self) -> T where T: UIViewController {
        guard let viewController = instantiateViewController(withIdentifier: type.reuseId) as? T else {
            fatalError()
        }
        return viewController
    }
}
