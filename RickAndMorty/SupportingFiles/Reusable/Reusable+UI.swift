import Foundation
import MapKit
import UIKit

// MARK: Make UI Elements comform by default

// UIView
// extension UIView: Reusable {}
// It's preferred that each UIView comforms explicitly to Reusable

// View Controller
extension UIViewController: Reusable {}

// Table
extension UITableViewCell: Reusable {}
extension UITableViewHeaderFooterView: Reusable {}

// Collection
// extension UICollectionViewCell: Reusable {} // Subclass of UICollectionReusableView
extension UICollectionReusableView: Reusable {}
