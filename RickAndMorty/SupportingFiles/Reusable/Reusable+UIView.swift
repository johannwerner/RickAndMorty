import Foundation
import UIKit

// UIView
extension UIView {
    /// Instantiates the view for the given UIView type
    /// This means the view class and file should be named the same
    ///
    /// ```
    /// let myView = MyView.instantiateView()
    /// ```
    /// - Parameter type: Class type (storyboard should be named the same)
    /// - Returns: The instantiated view
    static func instantiateView<T: Reusable>(ofType type: T.Type = T.self) -> T where T: UIView {
        guard let view = UINib(nibName: type.reuseId, bundle: nil).instantiate(withOwner: nil, options: nil).first as? T else {
            fatalError()
        }
        return view
    }
}
