//
//  EJKisangBaseModel.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/05/26.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Foundation

public enum EJDataType: String, Decodable {
    case JSON
    case XML
}

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
    var body: EJKisangBodyModel
}

public struct EJKisangHeaderModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case resultCode
        case resultMsg
    }
    
    var resultCode: String
    var resultMsg: String
}

public struct EJKisangBodyModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case dataType
        case items
        case pageNo
        case numOfRows
        case totalCount
    }
    
    var dataType: EJDataType
    var items: EJKisangItemsModel
    var pageNo: Int
    var numOfRows: Int
    var totalCount: Int
}
