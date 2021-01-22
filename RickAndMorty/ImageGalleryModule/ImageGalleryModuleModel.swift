/// Operation status enum for ImageGalleryModule.
enum ImageGalleryModuleStatus {
    case loading
    case error
    case success(CharacterResponse)
}

enum ImageGalleryModuleCharacterStatus {
    case loading
    case error
    case success([CharacterModel])
}

/// View effect enum for ImageGalleryModule.
enum ImageGalleryModuleViewEffect {
    case success
    case loading
    case error
}

/// View action enum for ImageGalleryModule.
enum ImageGalleryModuleViewAction {
    case selectedIndex(Int)
    case loadMore
    case showFavorites
}


struct FavoriteConstants {
    static let rickAndMortyApi = "https://rickandmortyapi.com/api/character/"
}
