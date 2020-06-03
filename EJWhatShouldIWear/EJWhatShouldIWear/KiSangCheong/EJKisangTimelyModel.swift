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
    
    var resultCode: String
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
    
    func generateModels() -> [EJKisangTimeModel]? {
        var tempModels: [EJKisangTimeModel] = []
        guard var date = item.first?.fcstDate, var time = item.first?.fcstTime else { return [] }
        
        var skyCode: Int?
        var rainyCode: Int?
        var temperature: Int?
        for model in item {
            if model.fcstDate != date {
                if let sky = skyCode, let rainy = rainyCode, let temp = temperature {
                    tempModels.append(EJKisangTimeModel(skyCode: sky, fcstDate: date, fcstTime: time, rainyCode: rainy, temperature: temp))
                    skyCode = nil
                    rainyCode = nil
                    temperature = nil
                }
                date = model.fcstDate
            }
            if model.fcstTime != time {
                if let sky = skyCode, let rainy = rainyCode, let temp = temperature {
                    tempModels.append(EJKisangTimeModel(skyCode: sky, fcstDate: date, fcstTime: time, rainyCode: rainy, temperature: temp))
                    skyCode = nil
                    rainyCode = nil
                    temperature = nil
                }
                time = model.fcstTime
            }
            
            if let value = Int(model.fcstValue), model.category == .skyCode {
                skyCode = value
            }
            if let value = Int(model.fcstValue), model.category == .rainFallType {
                rainyCode = value
            }
            if let value = Int(model.fcstValue), model.category == .threeHourTemp {
                temperature = value
            }
        }
        
        return tempModels
    }
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
    var skyCode: Int
    var fcstDate: String
    var fcstTime: String
    var rainyCode: Int
    var temperature: Int
}
