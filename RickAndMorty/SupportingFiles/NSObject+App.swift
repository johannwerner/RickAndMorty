import Foundation

extension NSObject {

    @nonobjc var className: String {
        String(describing: type(of: self))
    }
    
    @nonobjc class var className: String {
        String(describing: self)
    }
}
