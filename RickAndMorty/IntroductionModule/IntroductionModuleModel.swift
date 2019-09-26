/// Operation status enum for  IntroductionModule.
enum IntroductionModuleStatus {
    case loading
    case error
    case success(IntroductionResponseModel)
}

/// View effect enum for  IntroductionModule.
enum IntroductionModuleViewEffect {
    case success
    case loading
    case error
}

/// View action enum for  IntroductionModule.
enum IntroductionModuleViewAction {
    case primaryButtonPressed
}

struct IntroductionConstants {
    static let titleLabelText = "Johann Werner"
    static let rickAndMortyApi = "https://rickandmortyapi.com/api/character/"
}

struct IntroductionResponseModel: Codable {
    var results: [IntroductionResponseModel.CharacterModel]
    var info: Info
    struct Info: Codable {
        var next: String
    }
    
    struct CharacterModel: Codable, ImageCollectionProtocol {
        var image: String
        var id: Int
        
        var imageUrlToShow: String {
            image
        }
    }
}
