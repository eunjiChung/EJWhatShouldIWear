//
//  EJKisangWeekForecastModel.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/05/26.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Foundation

public struct EJKisangForecastBaseModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case response
    }
    var response: EJKisangForecastResponseModel
}

public struct EJKisangForecastResponseModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case header
        case body
    }
    var header: EJKisangForecastHeaderModel
    var body: EJKisangForecastBodyModel
}

public struct EJKisangForecastHeaderModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case resultCode
        case resultMsg
    }
    var resultCode: String
    var resultMsg: String
}

public struct EJKisangForecastBodyModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case dataType
        case items
        case pageNo
        case numOfRows
        case totalCount
    }
    var dataType: EJDataType
    var items: EJKisangForecastItemsModel
    var pageNo: Int
    var numOfRows: Int
    var totalCount: Int
}

public struct EJKisangForecastItemsModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case item
    }
    var item: [EJKisangWeekForecastModel]
}

public struct EJKisangWeekForecastModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case regId
        case wf3Am, wf3Pm, wf4Am, wf4Pm, wf5Am, wf5Pm, wf6Am, wf6Pm, wf7Am, wf7Pm, wf8, wf9, wf10
        case wh3AAm, wh3APm, wh3BAm, wh3BPm, wh4AAm, wh4APm, wh4BAm, wh4BPm, wh5AAm, wh5APm, wh5BAm, wh5BPm, wh6AAm, wh6APm, wh6BAm, wh6BPm, wh7AAm, wh7APm, wh7BAm, wh7BPm, wh8A, wh8B, wh9A, wh9B, wh10A, wh10B
    }
    
    // 내가 필요한 부분..
    var regId: String
    var wf3Am: String
    var wf3Pm: String
    var wf4Am: String
    var wf4Pm: String
    var wf5Am: String
    var wf5Pm: String
    var wf6Am: String
    var wf6Pm: String
    var wf7Am: String
    var wf7Pm: String
    var wf8: String
    var wf9: String
    var wf10: String
    
    var wh3AAm: Double
    var wh3APm: Double
    var wh3BAm: Double
    var wh3BPm: Double
    var wh4AAm: Double
    var wh4APm: Double
    var wh4BAm: Double
    var wh4BPm: Double
    var wh5AAm: Double
    var wh5APm: Double
    var wh5BAm: Double
    var wh5BPm: Double
    var wh6AAm: Double
    var wh6APm: Double
    var wh6BAm: Double
    var wh6BPm: Double
    var wh7AAm: Double
    var wh7APm: Double
    var wh7BAm: Double
    var wh7BPm: Double
    var wh8A: Double
    var wh8B: Double
    var wh9A: Double
    var wh9B: Double
    var wh10A: Double
    var wh10B: Double
}
