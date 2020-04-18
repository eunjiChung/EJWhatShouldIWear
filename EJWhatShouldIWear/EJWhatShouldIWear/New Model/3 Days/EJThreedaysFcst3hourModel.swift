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
        case humidity = "humidity"
        case sky = "sky"
        case temperature = "temperature"
        case wind = "wind"
        case precipitation = "precipitation"
    }
    
    public var humidity: EJHumidityModel?
    public var sky: SKThreeSky?
    public var temperature: SKThreeFcstTemperature?
    public var wind: SKThreeWind?
    public var precipitation: SKThreePrecipitation?
    
    public init(from decoder: Decoder) throws { }
}
