//
//  EJUserInfo.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/11/11.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Foundation

enum EJGender {
    case woman
    case man
}

final class EJUserInfo {

    // MARK: - Singleton
    let shared = EJUserInfo()

    // MARK: - Property
    var gender: EJGender = .woman
}
