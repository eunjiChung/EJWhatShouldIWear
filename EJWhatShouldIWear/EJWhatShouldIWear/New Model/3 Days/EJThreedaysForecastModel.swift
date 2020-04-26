//
//  EJThreedaysForecastModel.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/04/17.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Foundation

public struct EJThreedaysForecastModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case grid
        case timeRelease
        case fcst3hour
        case fcst6hour
        case fcstdaily
    }
    
    var grid: EJGridModel
    var timeRelease: String
    var fcst3hour: EJThreedaysFcst3hourModel
    var fcst6hour: EJThreedaysFcst6hourModel
    var fcstdaily: EJThreedaysFcstDailyModel
}


public struct EJThreedaysFcstDailyModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case temperature
    }
    
    public var temperature: EJThreedaysDailyTemperature
}



public struct EJThreedaysDailyTemperature: Decodable {
    private enum CodingKeys: String, CodingKey {
        case tmax1day
        case tmax3day
        case tmin3day
        case tmin1day
        case tmax2day
        case tmin2day
    }
    
    var tmax1day: String?
    var tmax3day: String?
    var tmin3day: String?
    var tmin1day: String?
    var tmax2day: String?
    var tmin2day: String?
}
