import Foundation

protocol ImageCollectionProtocol {
    var imageUrlToShow: URL { get }
    var accessibilityName: String? { get }
}
