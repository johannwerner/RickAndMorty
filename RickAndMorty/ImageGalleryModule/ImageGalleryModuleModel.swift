/// Operation status enum for ImageGalleryModule.
enum ImageGalleryModuleStatus {
    case error
    case loading
    case success
}

/// View effect enum for ImageGalleryModule.
enum ImageGalleryModuleViewEffect {
    case showImages
}

/// View action enum for ImageGalleryModule.
enum ImageGalleryModuleViewAction {
    case showImages
    case selectedIndex(Int)
}

struct ImageGalleryModuleModel {
    var imageGalleryItem: ImageGalleryItem
    ///Keeps track of which item has been selected.
    /// Nil if nothing has been selected
    var selectedIndex: Int?
}
