
/// Checks if a character has been favorited
/// - Requires:
final class CharacterFavoriteUseCase {
    
    // MARK: Dependencies
    private let interactor: MainImageInteractor
    
    // MARK: - Life cycle
    
    init(interactor: MainImageInteractor) {
        self.interactor = interactor
    }
}

// MARK: - Public functions

extension CharacterFavoriteUseCase {
    
    func favoriteCharacter(model: CharacterModel) -> MainImageStatus  {
        MainImageStatus.character(isFavorite(model: model))
    }
    
    func isFavorite(model: CharacterModel) -> CharacterModel {
        var copyOfModel = model
        var favorites = UserDefaultsManager().listOfFavoriteIds
        let isFavorite = favorites.contains(model.id)
        if isFavorite {
            favorites = favorites.lazy.filter{ $0 != copyOfModel.id }
            copyOfModel.isFavorite = false
        } else {
            favorites.append(model.id)
            copyOfModel.isFavorite = true
        }
        UserDefaultsManager().listOfFavoriteIds = favorites
        
        return copyOfModel
    }
}
