import UIKit
import PureLayout

// MARK: - AppViewController
class AppViewController: UIViewController {
    
    // MARK: - Properties
    private(set) final var activityView: ActivityView = ActivityView(activityView: ActivityViewComponent())

}

// MARK: Public
extension AppViewController {
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        view.backgroundColor = ColorTheme.backkgroundColor
    }
}

// MARK: - ActivityView Struct
struct ActivityView {
    
    // MARK: - Properties
    private let activityView: ActivityViewComponent
    
    fileprivate init(activityView: ActivityViewComponent) {
        self.activityView = activityView
    }
}

// MARK: - Public Methods
extension ActivityView {
    func showView() {
        activityView.showView()
    }

    func hideView() {
        activityView.hideView()
    }
}

// MARK: - ActivityViewStyle
private struct ActivityViewStyle {
    static let size = CGSize(width: 80, height: 80)
    static let cornerRadius: CGFloat = 8.0
    static let transparentViewBackgroundDarkColor = ColorTheme.alpha2Dark
    static let backgroundColor = ColorTheme.black
    static let animationDuration: TimeInterval = 0.3
    static let animationStyle: UIView.AnimationOptions = .curveEaseOut
    static let activityIndicatorColor = ColorTheme.white
}

// MARK: - Activity View Component
final private class ActivityViewComponent: UIView {
    // MARK: - Properties
    private let activityIndicator = UIActivityIndicatorView()
    private let activityView = UIView()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpUI()
    }
}

// MARK: - File Private
private extension ActivityViewComponent {
    func showView() {
        let currentWindow = UIApplication.mainWindow
        currentWindow.addSubview(self)
        autoSetDimension(.height, toSize: UIScreen.main.bounds.size.height)
        autoSetDimension(.width, toSize: UIScreen.main.bounds.size.width)
        autoCenterInSuperview()
        backgroundColor = ActivityViewStyle.transparentViewBackgroundDarkColor
        
        

        activityIndicator.startAnimating()
    }
    
    func hideView() {
        UIView.animate(
            withDuration: ActivityViewStyle.animationDuration,
            delay: 0,
            options: ActivityViewStyle.animationStyle,
            animations: { [weak self] in
                self?.backgroundColor = .clear
        }, completion: { [weak self] _ in
                self?.activityIndicator.stopAnimating()
                self?.removeFromSuperview()
        })
    }
}

// MARK: - Private
extension ActivityViewComponent {
    private func setUpUI() {
        addSubview(activityView)
        activityView.autoCenterInSuperview()
        activityView.autoSetDimensions(to: ActivityViewStyle.size)
        activityView.backgroundColor = isDarkMode ? .white: ActivityViewStyle.backgroundColor
        activityView.layer.cornerRadius = ActivityViewStyle.cornerRadius
        
        activityView.addSubview(activityIndicator)
        activityIndicator.autoCenterInSuperview()
        activityIndicator.style = .large
        activityIndicator.color = isDarkMode ? .black: ActivityViewStyle.activityIndicatorColor
        activityIndicator.hidesWhenStopped = true
        activityIndicator.stopAnimating()
    }
}

private extension UIView {
    var isDarkMode: Bool {
        traitCollection.userInterfaceStyle == .dark
    }
}
