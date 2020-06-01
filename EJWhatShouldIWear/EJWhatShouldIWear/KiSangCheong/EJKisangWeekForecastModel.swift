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
        case rnSt3Am, rnSt3Pm, rnSt4Am, rnSt4Pm, rnSt5Am, rnSt5Pm, rnSt6Am, rnSt6Pm, rnSt7Am, rnSt7Pm, rnSt8, rnSt9, rnSt10
        case wf3Am, wf3Pm, wf4Am, wf4Pm, wf5Am, wf5Pm, wf6Am, wf6Pm, wf7Am, wf7Pm, wf8, wf9, wf10
    }

    var regId: String
    var rnSt3Am: Int
    var rnSt3Pm: Int
    var rnSt4Am: Int
    var rnSt4Pm: Int
    var rnSt5Am: Int
    var rnSt5Pm: Int
    var rnSt6Am: Int
    var rnSt6Pm: Int
    var rnSt7Am: Int
    var rnSt7Pm: Int
    var rnSt8: Int
    var rnSt9: Int
    var rnSt10: Int
    
    // 내가 필요한 부분..
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
}
