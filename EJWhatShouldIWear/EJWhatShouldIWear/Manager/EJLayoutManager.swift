//
//  EJLayoutManager.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/04/19.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

// MARK: - Screen Size
public let EJ_SCREEN_WIDTH: CGFloat             =   UIScreen.main.bounds.width
public let EJ_SCREEN_HEIGHT: CGFloat            =   UIScreen.main.bounds.height
public let EJ_SCREEN_HEIGHT_812 : CGFloat       =   812.0
public let EJ_SCREEN_WIDTH_414: CGFloat         =   414.0
public let EJ_SCREEN_WIDTH_375: CGFloat         =   375.0
public let EJ_SCREEN_7_PLUS: CGFloat            =   736.0
public let EJ_SCREEN_7: CGFloat                 =   667.0

// MARK: - Auto Layout
func EJSize(_ standardSize: CGFloat) -> CGFloat {
    // iPhoneX 기준으로 잡음
    return round(standardSize * (EJ_SCREEN_WIDTH / EJ_SCREEN_WIDTH_375))
}

func EJSizeHeight(_ size: CGFloat) -> CGFloat {
    return round(size * (EJ_SCREEN_HEIGHT / EJ_SCREEN_HEIGHT_812))
}

final class EJLayoutManager {
    
    // MARK: - Shared
    static let shared = EJLayoutManager()
    
    // MARK: - Public Methods
    // TODO: - 완성시키기
//    func isiPhoneXSize() -> Bool {
//        if EJ_SCREEN_WIDTH == ejsc
//        return true
//    }
}
