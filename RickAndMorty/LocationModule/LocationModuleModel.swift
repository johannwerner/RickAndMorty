/// Operation status enum for LocationModule.
enum LocationModuleStatus {
    case loading
    case error
    case success([CharacterModel])
}

enum LocationModuleCharacterStatus {
    case loading
    case error
    case success([CharacterModel])
}

/// View effect enum for LocationModule.
enum LocationModuleViewEffect {
    case success
    case loading
    case error
}

/// View action enum for LocationModule.
enum LocationModuleViewAction {
    
}
