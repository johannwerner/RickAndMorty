//
//  UserDefaultsManager.swift
//  RickAndMorty
//
//  Created by Johann Werner on 26.09.19.
//  Copyright © 2019 Johann Werner. All rights reserved.
//

import Foundation

import UIKit

class UserDefaultsManager {
    // MARK: - Properties
    

    // MARK: - Life Cycle

}

extension UserDefaultsManager {
    var listOfFavoriteIds: [Int] {
        get {
            let defaults = UserDefaults.standard
            let object = defaults.object(forKey: UserDefaultConstants.favoriteIds)
            guard let characterIds = object as? [Int] else {
                return []
            }
            return characterIds
        }
        set {
            let defaults = UserDefaults.standard
            defaults.set(newValue, forKey: UserDefaultConstants.favoriteIds)
        }
    }
}

private struct UserDefaultConstants {
    static let favoriteIds = "FavoriteIds"
}
