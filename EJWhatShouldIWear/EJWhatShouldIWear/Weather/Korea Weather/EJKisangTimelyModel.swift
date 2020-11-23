//
//  EJKisangTimelyModel.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/05/26.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Foundation

public struct EJKisangTimelyBaseModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case response
    }
    var response: EJKisangTimelyResponseModel
}

public struct EJKisangTimelyResponseModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case header
        case body
    }
    
    var header: EJKisangTimelyHeaderModel
    var body: EJKisangTimelyBodyModel
}

public struct EJKisangTimelyHeaderModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case resultCode
        case resultMsg
    }
    
    var resultCode: EJKisangStatusCode
    var resultMsg: String
}

public struct EJKisangTimelyBodyModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case dataType
        case items
        case pageNo
        case numOfRows
        case totalCount
    }
    
    var dataType: EJDataType
    var items: EJKisangTimelyItemsModel
    var pageNo: Int
    var numOfRows: Int
    var totalCount: Int
}

public struct EJKisangTimelyItemsModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case item
    }
    
    var item: [EJKisangTimelyModel]
}

public struct EJKisangTimelyModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case baseDate
        case baseTime
        case category
        case fcstDate
        case fcstTime
        case fcstValue
        case nx
        case ny
    }
    
    var baseDate: String
    var baseTime: String
    var category: EJKisangWeatherCode
    var fcstDate: String
    var fcstTime: String
    var fcstValue: String
    var nx: Int
    var ny: Int
}

public struct EJKisangTimeModel {
    var fcstDate: String
    var fcstTime: String
    var temperature: Int
    var weatherCode: WeatherCode
}
