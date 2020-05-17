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
    case switchId           = "switchState"
    
    // 즐겨찾는 위치
    case myLocations        = "mylocations"
    
    // main location
    case mainLocation       = "mainLocation"
    case main               = "main"
    
    // TODO: - 근데 얘를 Userdefault로 꼭 저장해야하나?
    // default location
    case defaultLocation    = "defaultLocation"
}

let myUserDefaults = UserDefaults.standard

final class EJUserDefaultsManager {
    // MARK: - Singleton
    static let shared = EJUserDefaultsManager()
    
    public func locationAddNew(_ location: String) {
        if let list = myUserDefaults.array(forKey: UserDefaultKey.myLocations.rawValue) as? [String] {
            var newList = list
            newList.append(location)
            myUserDefaults.set(newList, forKey: UserDefaultKey.myLocations.rawValue)
        } else {
            myUserDefaults.set([location], forKey: UserDefaultKey.myLocations.rawValue)
        }
    }
    
    public func updateLocationList(_ locations: [String]) {
        myUserDefaults.set(locations, forKey: UserDefaultKey.myLocations.rawValue)
    }
    
}
