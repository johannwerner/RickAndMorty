import RxSwift

/// 
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

extension ImageGalleryModuleUseCase {
    
    func getCharacters(url: String) -> Observable<ImageGalleryModuleStatus> {
        interactor.getCharacters(url: url)
            .map { (result: Async<Any>) -> ImageGalleryModuleStatus in
                switch result {
                case .loading:
                    return .loading
                case .success(let data):
                    guard let responseModel = ResponseModel.parse(from: data) else {
                        return .error
                    }
                    return .success(responseModel)
                case .error:
                    return .error
                }
        }
    }
}
