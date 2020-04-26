//
//  EJ6DaysBaseModel.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/04/17.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Foundation

public struct EJSixdaysWeatherBaseModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case weather
        case common
        case result
    }
    
    var weather: EJSixDaysWeatherModel
    var common: EJDaysCommonModel
    var result: EJDaysResultModel
}


public struct EJThreedaysWeatherBaseModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case weather
        case common
        case result
    }
    
    var weather: EJThreeDaysWeatherModel
    var common: EJDaysCommonModel
    var result: EJDaysResultModel
}


