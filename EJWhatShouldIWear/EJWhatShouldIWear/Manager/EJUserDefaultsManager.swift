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
    case locationKey        = "location"        // 메인 위치
    case switchId           = "switchState"
    case myLocations        = "mylocations"
}

let myUserDefaults = UserDefaults.standard

final class EJUserDefaultsManager {
    // MARK: - Singleton
    static let shared = EJUserDefaultsManager()
    
    // MARK: - Location Defaults
    var hasDefaultLocations: Bool {
        if let _ = myUserDefaults.string(forKey: UserDefaultKey.locationKey.rawValue) {
            return true
        }
        return false
    }
    
    public func locationAddNew(_ location: String) {
        guard let list = myUserDefaults.array(forKey: UserDefaultKey.myLocations.rawValue) as? [String] else { return }
        var newList = list
        newList.append(location)
        myUserDefaults.set(newList, forKey: UserDefaultKey.myLocations.rawValue)
    }
    
    public func updateLocationList(_ locations: [String]) {
        myUserDefaults.set(locations, forKey: UserDefaultKey.myLocations.rawValue)
    }
    
}
