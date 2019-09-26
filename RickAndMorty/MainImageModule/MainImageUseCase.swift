import RxSwift

/// Currently does nothing but exists for future use
/// - Requires: `RxSwift`, `Async`
final class MainImageUseCase {
    
    // MARK: Dependencies
    private let interactor: MainImageInteractor
    
    // MARK: - Life cycle
    
    init(interactor: MainImageInteractor) {
        self.interactor = interactor
    }
}

// MARK: - Public functions

extension MainImageUseCase {
    
    func favoriteCharacter(model: inout MainImageModel.ImageModel) -> Observable<MainImageStatus>  {
        
        Observable.just(MainImageStatus.character(model))
    }
    
    func isFavorite(model: inout MainImageModel.ImageModel) -> MainImageModel.ImageModel {
        var favorites = UserDefaultsManager().listOfFavoriteIds
        let isFavorite = favorites.contains(model.id)
        if isFavorite {
            favorites = favorites.filter{ $0 != model.id }
            model.isFavorite = false
        } else {
            favorites.append(model.id)
            model.isFavorite = true
        }
        UserDefaultsManager().listOfFavoriteIds = favorites
        
        return model
    }
}
