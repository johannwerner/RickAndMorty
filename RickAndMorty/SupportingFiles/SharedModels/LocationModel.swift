//
//  LocationModel.swift
//  RickAndMorty
//
//  Created by Johann Werner on 02.02.20.
//  Copyright © 2020 Johann Werner. All rights reserved.
//

import Foundation


struct LocationModel: Codable {
    var name: String
    var dimension: String
    var residents: [String]
    
    enum CodingKeys: String, CodingKey {
         case name
         case dimension
         case residents
     }
     
     // MARK: - Life Cycle
     init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let name = try container.decode(String.self, forKey: .name)
        let dimension = try container.decode(String.self, forKey: .dimension)
        let residents = try container.decode([String].self, forKey: .residents)
        self.name = name
        self.dimension = dimension
        self.residents = residents
     }
}
