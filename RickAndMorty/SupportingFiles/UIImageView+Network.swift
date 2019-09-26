import Foundation
import Kingfisher

extension UIImageView {
    typealias LoadImageCompletion = (UIImage?, Error?) -> Void
    
    /// Loads image from string url
    ///
    /// - Parameters:
    ///   - urlString: string with the image url
    ///   - priority: priority of download image
    ///   - placeholderImage: placeholder when image could not be loaded
    ///   - completed: (UIImage, Error) completion block
    
    
    func setRemoteImage(with urlString: String,
                        priority: Float = URLSessionTask.defaultPriority,
                        placeholderImage: UIImage? = nil,
                        completed: LoadImageCompletion? = nil) {
        let url = URL(string: urlString)
        setRemoteImage(
            url: url,
            priority: priority,
            placeholderImage: placeholderImage,
            completed: completed
        )
    }
}

private extension UIImageView {
    /// Loads image from url
    ///
    /// - Parameters:
    ///   - url: image url
    ///   - priority: priority of download image
    ///   - placeholderImage: placeholder when image could not be loaded
    ///   - completed: (UIImage, Error) completion block
    func setRemoteImage(url: URL?,
                        priority: Float = URLSessionTask.defaultPriority,
                        placeholderImage: UIImage? = nil,
                        completed: LoadImageCompletion? = nil) {
        let options: KingfisherOptionsInfo = [
            .transition(.fade(0.2)),
            .cacheOriginalImage,
            .downloadPriority(priority)
        ]
        
        kf.setImage(with: url, placeholder: placeholderImage, options: options, progressBlock: nil) { result in
            switch result {
            case .failure:
                completed?(nil, nil)
            case .success(let retrieved):
                completed?(retrieved.image, nil)
            }
        }
    }
}
