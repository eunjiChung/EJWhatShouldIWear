//
//  WeatherProtocol.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/07/08.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Foundation

protocol EJWeatherBasic {
    var temp: Int { get set }
    var minTemp: Int { get set }
    var maxTemp: Int { get set }
    var condition: String { get set }
}


