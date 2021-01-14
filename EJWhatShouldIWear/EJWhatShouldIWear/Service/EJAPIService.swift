//
//  EJAPIService.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/04/19.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Foundation
import Moya

struct ResponseData {
    var data: Any?
    var urlResponse: HTTPURLResponse?
}

struct EJURLString {
    /******************************************************************************
        WSIW Host URL
     ******************************************************************************/
    static let baseURL = "http://ljhserver.synology.me:3020"
    static let foreignBaseURL = "http://api.openweathermap.org/data/2.5"
}
