//
//  ImageGalleryItem.swift
//  mobile
//
//  Created by Johann Werner on 19.08.19.
//  Copyright © 2019 Johann Werner. All rights reserved.
//

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
