//
//  EJLibrary.swift
//  EJWhatShouldIWear
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 17/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

// MARK : - T Developer Key
let tDeveloperKey                               =   ""

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
