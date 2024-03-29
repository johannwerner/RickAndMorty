import UIKit
import PureLayout

final class MainImageCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    private let imageView = UIImageView()
    private let label = UILabel()
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initUI()
    }
}

// MARK: - Public
extension MainImageCollectionViewCell {
    func fill(with model: ImageCollectionProtocol) {
        imageView.setRemoteImage(url: model.imageUrlToShow)
        imageView.accessibilityLabel = model.accessibilityName
        imageView.isAccessibilityElement = true
    }
}

// MARK: - Private
private extension MainImageCollectionViewCell {
    func initUI() {
        contentView.addSubview(imageView)
        imageView.autoPinEdgesToSuperviewEdges()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
    }
}

