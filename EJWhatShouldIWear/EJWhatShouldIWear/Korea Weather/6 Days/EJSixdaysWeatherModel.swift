//
//  EJSixdaysWeatherModel.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/04/17.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Foundation

// MARK: - weather
public struct EJSixDaysWeatherModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case forecast6days
    }
    
    var forecast6days: [EJSixdaysForecastModel]?
}

public struct EJThreeDaysWeatherModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case forecast3days
    }
    
    var forecast3days: [EJThreedaysForecastModel]?
}



// MARK: - common
public struct EJDaysCommonModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case alertYn
        case stormYn
    }

    public var alertYn: String?
    public var stormYn: String?
}

// MARK: - result
public struct EJDaysResultModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case code
        case requestUrl
        case message
    }

    public var code: Int?
    public var requestUrl: String?
    public var message: String?
}
