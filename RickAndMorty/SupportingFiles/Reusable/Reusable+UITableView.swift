import Foundation
import UIKit

public extension UITableView {
    /// Register a UITableViewCell for future reuse.
    /// ```
    /// tableView.registerCellNib(ofType: CellCustom.self)
    /// ```
    /// - Parameters:
    ///   - cellType: Type of the class to register, Nib should be named the same as the class.
    ///   - bundle: Bundle where the file is, default is nil.
    func registerCellNib<T: Reusable>(ofType cellType: T.Type = T.self, bundle: Bundle? = nil) {
        let nib = UINib(nibName: cellType.reuseId, bundle: bundle)
        self.register(nib, forCellReuseIdentifier: cellType.reuseId)
    }
    
    /// Dequeue a UITableViewCell that's available for reuse
    ///
    /// ```
    /// let cell = tableView.dequeueReusableCell(ofType: CellCustom.reuseId, atIndexPath: indexPath)
    /// ```
    /// - Parameters:
    ///   - cellType: Type of the class that was registered for reuse.
    ///   - indexPath: Appropriate indexPath
    /// - Returns: Cell with the expected type
    func dequeueReusableCell<T>(ofType cellType: T.Type = T.self, at indexPath: IndexPath) -> T? where T: UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: cellType.reuseId, for: indexPath) as? T
        return cell
    }
    
    /// Register a UITableViewHeaderFooterView for future reuse.
    ///
    /// ```
    /// tableView.registerHeaderFooterNib(ofType: HeaderTableReusable.self)
    /// ```
    /// - Parameter cellType: Type of the class to register, Nib should be named the same as the class.
    /// - bundle: Bundle where the file is, default is nil.
    func registerHeaderFooterNib<T: Reusable>(ofType cellType: T.Type = T.self, bundle: Bundle? = nil) {
        let nib = UINib(nibName: cellType.reuseId, bundle: bundle)
        self.register(nib, forHeaderFooterViewReuseIdentifier: cellType.reuseId)
    }
    
    /// Dequeue a UITableViewHeaderFooterView that's available for reuse
    ///
    /// ```
    /// tableView.dequeueReusableHeaderFooter(ofType: HeaderTableReusable.self)
    /// ```
    /// - Parameter cellType: Type of the class that was registered for reuse.
    /// - Returns: Header/Footer with the expected type
    func dequeueReusableHeaderFooter<T>(ofType cellType: T.Type = T.self) -> T? where T: UITableViewHeaderFooterView {
        let headerFooter = dequeueReusableHeaderFooterView(withIdentifier: cellType.reuseId) as? T
        return headerFooter
    }
}
