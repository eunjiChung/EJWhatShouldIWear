//
//  EJErrorModel.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/04/19.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Foundation

public struct EJErrorBaseModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case error
    }
    
    var error: EJErrorContentModel
}

public struct EJErrorContentModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case category
        case code
        case message
    }
    
    var id: String
    var category: String
    var code: String
    var message: String
}
