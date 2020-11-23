//
//  EJKoreaRegionModel.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/05/30.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Foundation

public struct EJKoreaRegionModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case code
    }
    var code: [[String: [EJKoreaIdModel]]]
}

public struct EJKoreaIdModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case district
        case code
    }
    
    var district: String
    var code: String
}

