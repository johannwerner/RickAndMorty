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
    @UserDefaultsProperty(userDefaultsKey: UserDefaultConstants.favoriteIds, initalValue: [Int]())
    var listOfFavoriteIds

    // MARK: - Life Cycle

}

private struct UserDefaultConstants {
    static let favoriteIds = "FavoriteIds"
}

@propertyWrapper
struct UserDefaultsProperty<X: Codable> {
    private let userDefaultsKey: String
    private let initalValue: X

    init(userDefaultsKey: String, initalValue: X) {
        self.userDefaultsKey = userDefaultsKey
        self.initalValue = initalValue
    }

    var wrappedValue: X {
        get {
            guard let data = UserDefaults.standard.object(forKey: userDefaultsKey) as? Data else {
                if let value = UserDefaults.standard.object(forKey: userDefaultsKey) as? X {
                    return value
                }
                return initalValue
            }
            guard let value = try? JSONDecoder().decode(X.self, from: data) else {
                return initalValue
            }
            return value
        }
        set {
            guard let data = try? JSONEncoder().encode(newValue) else {
                UserDefaults.standard.set(newValue, forKey: userDefaultsKey)
                return
            }
            UserDefaults.standard.set(data, forKey: userDefaultsKey)
        }
    }
}
