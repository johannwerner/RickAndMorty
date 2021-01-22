/// Operation status enum for Episode.
enum EpisodeStatus {
    case loading
    case error
    case success(EpisodeModel)
}

/// View effect enum for Episode.
enum EpisodeViewEffect {
    case success
    case loading
    case error
}

/// View action enum for Episode.
enum EpisodeViewAction {
    case favoriteIndex(Int)
}

struct EpisodeModel: Codable {
    var name: String
}

