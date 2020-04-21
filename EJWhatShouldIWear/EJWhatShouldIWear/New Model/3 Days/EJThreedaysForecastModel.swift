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
    
    public var grid: EJGridModel?
    public var timeRelease: String?
    public var fcst3hour: EJThreedaysFcst3hourModel?
    public var fcst6hour: EJThreedaysFcst6hourModel?
    public var fcstdaily: EJThreedaysFcstDailyModel?
    
    public init(from decoder: Decoder) throws { }
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
    
    public var tmax1day: String?
    public var tmax3day: String?
    public var tmin3day: String?
    public var tmin1day: String?
    public var tmax2day: String?
    public var tmin2day: String?
}
