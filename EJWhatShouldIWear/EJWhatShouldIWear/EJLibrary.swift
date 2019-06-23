//
//  EJLibrary.swift
//  EJWhatShouldIWear
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 17/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

// MARK : - API Path
public let owmAPIPath                                  =   "http://api.openweathermap.org/data/2.5/"

// MARK : - App Key
public let owmAppKey                                   =   "a773e2be7cd5ee1befcfc2fc349d43ad"
public let googleAdmobAppID                            =   "ca-app-pub-1994779937843028~3906710093"
public let googleAdmobUnitID                           =   "ca-app-pub-1994779937843028/3973448265"
//public let googleAdmobUnitID                           =   "ca-app-pub-3940256099942544/2934735716" // Google's TestID

// MARK : - Screen Size
public let EJ_SCREEN_WIDTH: CGFloat             =   UIScreen.main.bounds.width
public let EJ_SCREEN_HEIGHT: CGFloat            =   UIScreen.main.bounds.height
public let EJ_SCREEN_WIDTH_414: CGFloat         =   414.0

// MARK : - Shared Instance
let Library = EJLibrary.sharedInstance

// MARK : - Auto Layout
func EJSize(_ standardSize: CGFloat) -> CGFloat {
    return round(standardSize * (EJ_SCREEN_WIDTH / EJ_SCREEN_WIDTH_414))
}

// MARK : - Localizable
fileprivate let EJLocalizableResourceName = "Localizable"
fileprivate let EJLocalizableTypeName = "strings"

func languageCode() -> String {
    guard let lc = Locale.preferredLanguages.first else {
        return "en"
    }
    
    return lc
}

func STNLanguageCode() -> String {
    var primaryCode = languageCode()
    if primaryCode.contains("zh-Hant") { // 중국어 번체일때
        primaryCode = "en-US"
    }
    
    // ex. zh-hans => zh, hans
    let seperatedComponents = primaryCode.components(separatedBy: "-")
    if let languageCode = seperatedComponents.first {
        if languageCode == "ko" || languageCode == "ja" || languageCode == "zh" {
            return languageCode
        }
    }
    
    return "en"
}

func STNLocalizedString(withKey: String) -> String {
    
    var languageCode = STNLanguageCode()
    
    if languageCode == "en" {
        languageCode = "Base"
    }
    
    if languageCode == "zh" {
        languageCode = "zh-Hans"
    }
    
    if let resourcePath = Bundle.main.path(forResource: STNLocalizableResourceName, ofType: STNLocalizableTypeName, inDirectory: nil, forLocalization: languageCode) {
        if let resourceData = try? Data.init(contentsOf: URL.init(fileURLWithPath: resourcePath)) {
            if let resouceObject = try? PropertyListSerialization.propertyList(from: resourceData, format: nil) as? [String: Any] {
                if let localizedString = resouceObject![withKey] as? String {
                    return localizedString
                }
            }
        }
    }
    
    return "Localizable Error"
}

// MARK : - Class EJLibrary
class EJLibrary: NSObject {
    static let sharedInstance = EJLibrary()
}
