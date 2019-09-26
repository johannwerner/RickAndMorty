import Foundation

struct ImageGalleryItem: Codable {
    
    var images: [Image]
    
    struct Image: Codable, ImageCollectionProtocol {
        var url: String
        var id: Int

        var imageUrlToShow: String {
            url
        }
    }

}
