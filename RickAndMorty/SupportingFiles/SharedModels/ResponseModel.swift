//
//  SharedModels.swift
//  RickAndMorty
//
//  Created by Johann Werner on 26.09.19.
//  Copyright © 2019 Johann Werner. All rights reserved.
//

import Foundation

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
    
    init(results: [CharacterModel], info: Info) {
        self.info = info
        self.results = results
    }
}
