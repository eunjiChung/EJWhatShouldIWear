//
//  EJLibrary.swift
//  EJWhatShouldIWear
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 17/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

// MARK : - API Path
public let sktWeatherAPIPath                           =   "https://api2.sktelecom.com/weather/"
public let owmAPIPath                                  =   "http://api.openweathermap.org/data/2.5/"

// MARK : - App Key
public let tDeveloperKey                               =   "caf5a086-90dc-4651-b189-cb8750c53f18"
public let owmAppKey                                   =   "a773e2be7cd5ee1befcfc2fc349d43ad"
public let googleAdmobAppID                            =   "ca-app-pub-1994779937843028~3906710093"
//public let googleAdmobUnitID                           =   "ca-app-pub-1994779937843028/3973448265"
public let googleAdmobUnitID                           =   "ca-app-pub-3940256099942544/2934735716" // Google's TestID

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

// MARK : - Class EJLibrary
class EJLibrary: NSObject {
    static let sharedInstance = EJLibrary()

}
