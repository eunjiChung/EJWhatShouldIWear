//
//  EJUserDefaultsManager.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/04/30.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Foundation

// MARK: UserDefaults Keys
enum UserDefaultKey: String {
    case locationKey        = "location"
    case switchId           = "switchState"
    case myLocations        = "mylocations"
}

let myUserDefaults = UserDefaults.standard

final class EJUserDefaultsManager {
    // MARK: - Singleton
    static let shared = EJUserDefaultsManager()
    
    // MARK: - Public Methods
    public func updateLocationList(_ new: String) {
        guard let list = myUserDefaults.array(forKey: UserDefaultKey.myLocations.rawValue) as? [String] else { return }
        var newList = list
        newList.append(new)
        myUserDefaults.set(newList, forKey: UserDefaultKey.myLocations.rawValue)
    }
}
