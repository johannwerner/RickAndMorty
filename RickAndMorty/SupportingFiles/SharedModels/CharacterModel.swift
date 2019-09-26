//
//  CharacterModel.swift
//  RickAndMorty
//
//  Created by Johann Werner on 26.09.19.
//  Copyright © 2019 Johann Werner. All rights reserved.
//

import Foundation

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