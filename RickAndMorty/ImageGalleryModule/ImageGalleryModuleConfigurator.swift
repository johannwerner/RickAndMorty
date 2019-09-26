import RxCocoa
import RxSwift

class ImageGalleryModuleConfigurator {
    
    // MARK: Dependencies
    
    let imageGalleryModuleInteractor: ImageGalleryModuleInteractor
    init(imageGalleryModuleInteractor: ImageGalleryModuleInteractor) {
        self.imageGalleryModuleInteractor = imageGalleryModuleInteractor
    }
}
