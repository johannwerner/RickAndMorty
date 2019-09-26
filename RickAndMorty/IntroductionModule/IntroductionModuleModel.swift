/// Operation status enum for  IntroductionModule.
enum IntroductionModuleStatus {
    case loading
    case error
    case success(ResponseModel)
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
