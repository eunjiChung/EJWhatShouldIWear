//
//  EJSixdaysForecastModel.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/04/17.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Foundation

public struct EJSixdaysForecastModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case timeRelease
        case sky
        case temperature
        case location
        case grid
    }
    
    var timeRelease: String
    var sky: EJSixdaysSkyModel
    var temperature: EJSixdaysTemperatureModel
    var location: EJSixdaysLocationModel
    var grid: EJGridModel
}


public struct EJSixdaysLocationModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case name
    }
    
    var name: String
}

public struct EJGridModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
        case city
        case village
        case county
    }
    
    var latitude: String?
    var longitude: String?
    var city: String?
    var village: String?
    var county: String?
}
