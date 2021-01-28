import UIKit

struct ColorTheme {}

// MARK: - Public Methods

extension ColorTheme {
    
    static var primaryAppColor: UIColor {
        ColorTheme.colorWith(red: 101, green: 179, blue: 239)
    }
    
    static var alpha6: UIColor {
        ColorTheme.blackWithAlpha(alpha: 0.6)
    }
    
    static var alpha2: UIColor {
        ColorTheme.blackWithAlpha(alpha: 0.2)
    }
    
    static var black: UIColor {
        .black
    }
    
    static var white: UIColor {
        .white
    }
    
    static var backgroundColor: UIColor {
        ColorTheme.isDarkMode ? darkBackkgroundColor: .secondarySystemBackground
    }
    
    static var isDarkMode: Bool {
        UIApplication.mainWindow.traitCollection.userInterfaceStyle == .dark
    }
}

// MARK: - Private Methods
private extension ColorTheme {
    
    static var darkBackkgroundColor: UIColor {
        ColorTheme.colorWith(red: 47, green: 47, blue: 47)
    }
    
    static func blackWithAlpha(alpha: CGFloat) -> UIColor {
        ColorTheme.colorWith(
            red:   0,
            green: 0,
            blue:  0,
            alpha: alpha
        )
    }
    
    static func whiteWithAlpha(alpha: CGFloat) -> UIColor {
        ColorTheme.colorWith(
            red:   255,
            green: 255,
            blue:  255,
            alpha: alpha
        )
    }
    /**
       Red/Blue /Green from 0 to 255 to create a color. Do not use divide by /255 because this is being done here.
     */
    static func colorWith(
        red: UInt8,
        green: UInt8,
        blue: UInt8,
        alpha: CGFloat = 1.0
        ) -> UIColor {
        UIColor(
            red: CGFloat(red)/255,
            green: CGFloat(green)/255,
            blue: CGFloat(blue)/255,
            alpha: alpha
        )
    }
}
