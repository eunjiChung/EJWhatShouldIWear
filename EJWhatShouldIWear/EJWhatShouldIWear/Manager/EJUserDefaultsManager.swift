//
//  EJUserDefaultsManager.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/04/30.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Foundation

// MARK: UserDefaults Keys
struct UserDefaultKey {
    static let switchId           = "switchState"
    
    // 즐겨찾는 위치
    static let myLocations        = "mylocations"
    
    // main location
    static let mainLocation       = "mainLocation"
    static let main               = "main"
    
    // TODO: - 근데 얘를 Userdefault로 꼭 저장해야하나?
    // default location
    static let defaultLocation    = "defaultLocation"
    
    // 첫번째 진입인지
    static let isExistingUser     = "isExistingUser"
    static let countryType        = "countryType"
}

let myUserDefaults = UserDefaults.standard

final class EJUserDefaultsManager {
    // MARK: - Singleton
    static let shared = EJUserDefaultsManager()
    
    public func locationAddNew(_ location: String) {
        if let list = myUserDefaults.array(forKey: UserDefaultKey.myLocations) as? [String] {
            var newList = list
            newList.append(location)
            myUserDefaults.set(newList, forKey: UserDefaultKey.myLocations)
        } else {
            myUserDefaults.set([location], forKey: UserDefaultKey.myLocations)
        }
    }
    
    public func updateLocationList(_ locations: [String]) {
        myUserDefaults.set(locations, forKey: UserDefaultKey.myLocations)
    }
}
