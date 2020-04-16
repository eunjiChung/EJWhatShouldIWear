//
//  EJ6DaysBaseModel.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/04/17.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Foundation

public struct EJWeatherBaseModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case weather
        case common
        case result
    }
    
    var weather: EJDaysWeatherModel
    var common: EJDaysCommonModel
    var result: EJDaysResultModel
}

