import RxSwift

/// <#Brief description of the purpose of the use case#>
/// - Requires: `RxSwift`, `Async`
class ImageGalleryFavoriteUseCase {
    
    // MARK: Dependencies
    private let interactor: ImageGalleryModuleInteractor
    
    // MARK: - Life cycle
    
    init(interactor: ImageGalleryModuleInteractor) {
        self.interactor = interactor
    }
}

// MARK: - Public functions

extension ImageGalleryFavoriteUseCase {
    
    func getFavoriteCharacters() -> Observable<ImageGalleryModuleCharacterStatus> {
        interactor.favoriteCharacters(ids: ids)
            .map { (result: Async<Any>) -> ImageGalleryModuleCharacterStatus in
                switch result {
                case .loading:
                    return .loading
                case .success(let data):
                    guard let array = data as? Array<Dictionary<String, Any>> else {
                        return .error
                    }
                    let modelArray = array.compactMap { dictionary -> CharacterModel? in
                        CharacterModel.parse(from: dictionary)
                    }
                    return .success(modelArray)
                case .error:
                    return .error
                }
        }
    }
}

private extension ImageGalleryFavoriteUseCase {
    var ids: [Int] {
        UserDefaultsManager().listOfFavoriteIds
    }
}
