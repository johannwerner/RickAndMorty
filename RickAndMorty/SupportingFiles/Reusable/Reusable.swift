import Foundation
import UIKit

/// Allows for UI elements to be reusable easily
public protocol Reusable {
    /// Returns class name
    static var reuseId: String { get }
}

// MARK: - Default implementation

public extension Reusable {
    static var reuseId: String {
        return String(describing: self)
    }
}
