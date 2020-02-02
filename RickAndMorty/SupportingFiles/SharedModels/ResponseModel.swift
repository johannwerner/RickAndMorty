//
//  SharedModels.swift
//  RickAndMorty
//
//  Created by Johann Werner on 26.09.19.
//  Copyright © 2019 Johann Werner. All rights reserved.
//

import Foundation

struct ResponseModel: Codable {
    
    // MARK: - Properties
    var results: [CharacterModel]
    var info: Info
    var selectedIndex: Int?
    var type: ViewType? = ViewType.all
    
    
    struct Info: Codable {
        var next: String
    }
    
    enum ViewType: String, Codable {
        case all
        case residents
    }
}
