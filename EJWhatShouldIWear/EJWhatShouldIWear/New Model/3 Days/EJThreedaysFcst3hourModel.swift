//
//  EJThreedaysFcst3hourModel.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/04/17.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Foundation

public struct EJThreedaysFcst3hourModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case wind = "wind"
        case precipitation = "precipitation"
        case sky = "sky"
        case temperature = "temperature"
        case humidity = "humidity"
    }
    
    public var wind: EJThreedaysWindModel?
    public var precipitation: EJPrecipitationModel?
    public var sky: EJSkyModel?
    public var temperature: EJThreedaysHourTemperature?
    public var humidity: EJHumidityModel?
    
    public init(from decoder: Decoder) throws { }
}
