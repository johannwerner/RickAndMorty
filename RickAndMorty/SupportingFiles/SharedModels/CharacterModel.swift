//
//  CharacterModel.swift
//  RickAndMorty
//
//  Created by Johann Werner on 26.09.19.
//  Copyright © 2019 Johann Werner. All rights reserved.
//

import Foundation

struct CharacterModel: Codable, ImageCollectionProtocol {
    var image: URL
    var id: Int
    var isFavorite: Bool
    var name: String
    var species: String
    var origin: Location
    var gender: String
    var status: String
    var location: Location
    var episode: [URL]
    
    var imageUrlToShow: URL {
        image
    }
    
    enum CodingKeys: String, CodingKey {
        case image
        case id
        case name
        case species
        case origin
        case gender
        case status
        case location
        case episode
    }
    
    // MARK: - Life Cycle
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let image = try container.decode(URL.self, forKey: .image)
        let id = try container.decode(Int.self, forKey: .id)
        let name = try container.decode(String.self, forKey: .name)
        let species = try container.decode(String.self, forKey: .species)
        let origin = try container.decode(Location.self, forKey: .origin)
        let gender = try container.decode(String.self, forKey: .gender)
        let status = try container.decode(String.self, forKey: .status)
        let lastKnownLocation = try container.decode(Location.self, forKey: .location)
        let episode = try container.decode([URL].self, forKey: .episode)
        
        self.image = image
        self.id = id
        self.name = name
        self.isFavorite = false
        self.species = species
        self.origin = origin
        self.gender = gender
        self.status = status
        self.location = lastKnownLocation
        self.episode = episode
        
    }
    
    struct Location: Codable {
        var name: String
        var url: String
    }
}
