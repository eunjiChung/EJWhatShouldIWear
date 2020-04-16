//
//  EJSixdaysTemperatureModel.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/04/17.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Foundation

public struct EJSixdaysTemperatureModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case tmin6day
        case tmin4day
        case tmin7day
        case tmin5day
        case tmax4day
        case tmax8day
        case tmin10day
        case tmax2day
        case tmin3day
        case tmax3day
        case tmax7day
        case tmax9day
        case tmin2day
        case tmin8day
        case tmax10day
        case tmax5day
        case tmin9day
        case tmax6day
    }

    public var tmin6day: String?
    public var tmin4day: String?
    public var tmin7day: String?
    public var tmin5day: String?
    public var tmax4day: String?
    public var tmax8day: String?
    public var tmin10day: String?
    public var tmax2day: String?
    public var tmin3day: String?
    public var tmax3day: String?
    public var tmax7day: String?
    public var tmax9day: String?
    public var tmin2day: String?
    public var tmin8day: String?
    public var tmax10day: String?
    public var tmax5day: String?
    public var tmin9day: String?
    public var tmax6day: String?
}
