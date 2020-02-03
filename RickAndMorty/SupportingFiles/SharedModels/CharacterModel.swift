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
    var name: String
    var species: String
    var origin: Origin
    var gender: String
    var imageUrlToShow: String {
        image
    }
    
    enum CodingKeys: String, CodingKey {
        case image
        case id
        case name
        case species
        case origin
        case gender
    }
    
    // MARK: - Life Cycle
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let image = try container.decode(String.self, forKey: .image)
        let id = try container.decode(Int.self, forKey: .id)
        let name = try container.decode(String.self, forKey: .name)
        let species = try container.decode(String.self, forKey: .species)
        let origin = try container.decode(Origin.self, forKey: .origin)
        let gender = try container.decode(String.self, forKey: .gender)
        
        self.image = image
        self.id = id
        self.name = name
        self.isFavorite = false
        self.species = species
        self.origin = origin
        self.gender = gender
    }
    
    struct Origin: Codable {
        var name: String
        var url: String
    }
}
