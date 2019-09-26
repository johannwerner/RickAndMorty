import RxSwift

/// <#Brief description of the purpose of the use case#>
/// - Requires: `RxSwift`, `Async`
class ImageGalleryModuleUseCase {
    
    // MARK: Dependencies
    private let interactor: ImageGalleryModuleInteractor
    
    // MARK: - Life cycle
    
    init(interactor: ImageGalleryModuleInteractor) {
        self.interactor = interactor
    }
}

// MARK: - Public functions

extension ImageGalleryModuleUseCase {}
