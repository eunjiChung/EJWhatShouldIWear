//
//  WeatherMain.swift
//  EJWhatShouldIWear
//
//  Created by eunji on 07/08/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Foundation

class WeatherMain {
    
    var mainTemp: Int  = 0
    var minTemp: Int = 0
    var maxTemp: Int = 0
    
    var criticCondition: WeatherCondition = .clear
    var weatherDescription: String = ""
    
    var firstCloth: String = ""
    var secondCloth: String = ""
    var thirdCloth: String = ""
}
