/// Operation status enum for ImageGalleryModule.
enum ImageGalleryModuleStatus {
    case loading
    case error
    case success(ResponseModel)
}

/// View effect enum for ImageGalleryModule.
enum ImageGalleryModuleViewEffect {
    case success
}

/// View action enum for ImageGalleryModule.
enum ImageGalleryModuleViewAction {
    case selectedIndex(Int)
    case loadMore
}

struct ImageGalleryModuleModel {
    var imageGalleryItem: ImageGalleryItem
    ///Keeps track of which item has been selected.
    /// Nil if nothing has been selected
    var selectedIndex: Int?
}

struct ResponseModel: Codable {
    var results: [CharacterModel]
    var info: Info
    var selectedIndex: Int? = nil
    struct Info: Codable {
        var next: String
    }
    
    enum CodingKeys: String, CodingKey {
        case results
        case info
    }
    
    // MARK: - Life Cycle
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let results = try container.decode([CharacterModel].self, forKey: .results)
        let info = try container.decode(Info.self, forKey: .info)

        self.info = info
        self.results = results
        self.selectedIndex = nil
    }
}


struct CharacterModel: Codable, ImageCollectionProtocol {
    var image: String
    var id: Int
    var isFavorite: Bool
    var imageUrlToShow: String {
        image
    }
    
    enum CodingKeys: String, CodingKey {
        case image
        case id
    }
    
    // MARK: - Life Cycle
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let image = try container.decode(String.self, forKey: .image)
        let id = try container.decode(Int.self, forKey: .id)

        self.image = image
        self.id = id
        self.isFavorite = false
    }
}
