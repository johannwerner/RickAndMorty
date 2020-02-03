/// Operation status enum for Character.
enum CharacterStatus {
    case loading
    case error
    case success(LocationModel)
}

/// View effect enum for Character.
enum CharacterViewEffect {
    case success
    case loading
    case error
}

/// View action enum for Character.
enum CharacterViewAction {
    case favoriteIndex(Int)
}


