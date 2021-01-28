import Foundation
import UIKit

extension UICollectionView {
    /// Register a UICollectionViewCell for future reuse.
    ///
    /// ```
    /// collectionView.registerCellNib(ofType: CellCustom.self)
    /// ```
    /// - Parameters:
    ///   - cellType: Type of the class to register, Nib should be named the same as the class.
    ///   - bundle: Bundle where the file is, default is nil.
    func registerCellNib<T: Reusable>(ofType cellType: T.Type = T.self, bundle: Bundle? = nil) {
        let nib = UINib(nibName: cellType.reuseId, bundle: bundle)
        self.register(nib, forCellWithReuseIdentifier: cellType.reuseId)
    }
    
    /// Dequeue a UICollectionViewCell that's available for reuse
    ///
    /// ```
    /// let cell = tableView.dequeueReusableCell(ofType: CellCustom.reuseId, atIndexPath: indexPath)
    /// ```
    /// - Parameters:
    ///   - cellType: Type of the class that was registered for reuse.
    ///   - indexPath: Appropriate indexPath
    /// - Returns: Cell with the expected type
    func dequeueReusableCell<T>(ofType cellType: T.Type = T.self, at indexPath: IndexPath) -> T? where T: UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: cellType.reuseId, for: indexPath) as? T
        return cell
    }
    
    /// Register a UICollectionReusableView for future reuse as **header**.
    ///
    /// ```
    /// collectionView.registerHeaderNib(ofType: HeaderCustom.self)
    /// ```
    /// - Parameters:
    ///   - cellType: Type of the class to register, Nib should be named the same as the class.
    ///   - bundle: Bundle where the file is, default is nil.
    func registerHeaderNib<T: Reusable>(ofType cellType: T.Type = T.self, bundle: Bundle? = nil) {
        let nib = UINib(nibName: cellType.reuseId, bundle: bundle)
        self.register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: cellType.reuseId)
    }
    
    /// Register a UICollectionReusableView for future reuse as **footer**.
    ///
    /// ```
    /// collectionView.registerFooterNib(ofType: FooterCustom.self)
    /// ```
    /// - Parameters:
    ///   - cellType: Type of the class to register, Nib should be named the same as the class.
    ///   - bundle: Bundle where the file is, default is nil.
    func registerFooterNib<T: Reusable>(ofType cellType: T.Type = T.self, bundle: Bundle? = nil) {
        let nib = UINib(nibName: cellType.reuseId, bundle: bundle)
        self.register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: cellType.reuseId)
    }
    
    /// Dequeue a UICollectionReusableView that's available for reuse as **header**
    ///
    /// ```
    /// collectionView.dequeueReusableHeader(ofType: HeaderCollectionReusable.self, at: indexPath)
    /// ```
    /// - Parameters:
    ///   - cellType: Type of the class that was registered for reuse.
    ///   - indexPath: Appropriate indexPath
    /// - Returns: Header with the expected type
    func dequeueReusableHeader<T>(ofType cellType: T.Type = T.self, at indexPath: IndexPath) -> T? where T: UICollectionReusableView {
        let headerFooter = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: cellType.reuseId, for: indexPath) as? T
        return headerFooter
    }
    
    /// Dequeue a UICollectionReusableView that's available for reuse as **footer**
    ///
    /// ```
    /// collectionView.dequeueReusableFooter(ofType: HeaderCollectionReusable.self, at: indexPath)
    /// ```
    /// - Parameters:
    ///   - cellType: Type of the class that was registered for reuse.
    ///   - indexPath: Appropriate indexPath
    /// - Returns: Footer with the expected type
    func dequeueReusableFooter<T>(ofType cellType: T.Type = T.self, at indexPath: IndexPath) -> T? where T: UICollectionReusableView {
        let headerFooter = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: cellType.reuseId, for: indexPath) as? T
        return headerFooter
    }
}
