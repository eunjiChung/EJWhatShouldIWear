//
//  String.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/05/01.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Foundation

extension String {
    // TODO: - 전부 이걸로 바꾸기....
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
