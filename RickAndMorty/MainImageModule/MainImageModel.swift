/// Operation status enum for MainImage.
enum MainImageStatus {
    case character(CharacterModel)
}

/// View effect enum for MainImage.
enum MainImageViewEffect {
    case character(CharacterModel)
}

/// View action enum for MainImage.
enum MainImageViewAction {
    case favoriteIndex(Int)
}

struct MainImageModel {

    var selectedIndex: Int
    var models: [ImageModel]

    struct ImageModel: ImageCollectionProtocol {
        
        var url: String
        var id: Int
        var isFavorite: Bool
        
        var imageUrlToShow: String {
            url
        }
    }
    
    var selectedModel: MainImageModel.ImageModel? {
        models[safe: selectedIndex]
    }
}
