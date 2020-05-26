//
//  EJKisangBaseModel.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/05/26.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Foundation

public struct EJKisangBaseModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case response
    }
    
    var response: EJKisangResponseModel
}

public struct EJKisangResponseModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case header
        case body
    }
    
    var header: EJKisangHeaderModel
    var body: String
}

public struct EJKisangHeaderModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case resultCode
        case resultMsg
    }
    
    var resultCode: String
    var resultMsg: String
}

