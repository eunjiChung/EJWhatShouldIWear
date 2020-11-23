//
//  WeatherMain.swift
//  EJWhatShouldIWear
//
//  Created by eunji on 07/08/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Foundation

protocol EJWeatherBasic {
    var temp: Int { get set }
    var minTemp: Int { get set }
    var maxTemp: Int { get set }
    var condition: String { get set }
}

class EJWeatherMainModel {
    var mainTemp: Int  = 0
    var minTemp: Int = 0
    var maxTemp: Int = 0
    
    var criticCondition: WeatherCondition = .clear
    var weatherDescription: String = ""
    
    var criticCloth: String = ""
    var maxCloth: String = ""
    var minCloth: String = ""
}

struct TempRange {
    static let temp_28 = 28...
    static let temp_23_27 = 23...27
    static let temp_20_22 = 20...22
    static let temp_17_19 = 17...19
    static let temp_12_16 = 12...16
    static let temp_9_11 = 9...11
    static let temp_5_8 = 5...8
    static let temp_4 = ...4
}
