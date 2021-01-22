import Foundation

extension String {
    ///tableName is FreeNow,
    ///missing string will be displayed when no value exists.
    func localizedString(_ comment: String = "") -> String {
        NSLocalizedString(
            self,
            tableName: "Rick",
            value: "missing string: \(self)",
            comment: comment
        )
    }
    
    var underline: NSAttributedString {
        AttributedStringManager.convertStringToAttributedString("<u>\(self)</u>")
    }
    
    var attributedText: NSAttributedString {
        AttributedStringManager.convertStringToAttributedString(self)
    }
}
