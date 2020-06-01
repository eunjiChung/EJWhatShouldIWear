//
//  WeatherMain.swift
//  EJWhatShouldIWear
//
//  Created by eunji on 07/08/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Foundation

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

protocol Cloth {
    static var _28: [String] { get }
    static var _23_27: [String] { get }
    static var _20_22: [String] { get }
    static var _17_19: [String] { get }
    static var _12_16: [String] { get }
    static var _9_11: [String] { get }
    static var _5_8: [String] { get }
    static var _4: [String] { get }
}

struct Top: Cloth {
    static let _28 = [SLEEVELESS_SHIRT]
    static let _23_27 = [SHORT_SLEEVED_T_SHIRT, ONE_PIECE]
    static let _20_22 = [BLOUSE, SHIRT]
    static let _17_19 = [SWEAT_SHIRT, CHECKED_SHIRT]
    static let _12_16 = [SWEAT_SHIRT]
    static let _9_11 = [KNITWEAR]
    static let _5_8 = [KNITWEAR]
    static let _4 = [KNITWEAR]
}

struct Bottom: Cloth {
    static let _28 = [HOT_PANTS, SHORT_SKIRT]
    static let _23_27 = [LONG_SKIRT, SHORT_SKIRT]
    static let _20_22 = [SLACKS, LONG_SKIRT, COTTON_PANTS, BLUE_JEANS]
    static let _17_19 = [SLACKS, LONG_SKIRT, COTTON_PANTS, BLUE_JEANS]
    static let _12_16 = [SLACKS, LONG_SKIRT, COTTON_PANTS, BLUE_JEANS]
    static let _9_11 = [SLACKS, BLUE_JEANS]
    static let _5_8 = [COTTON_PANTS]
    static let _4 = [COTTON_PANTS]
}

struct Outer: Cloth {
    static let _28 = [""]
    static let _23_27 = [""]
    static let _20_22 = [CARDIGAN]
    static let _17_19 = [CARDIGAN, BLUE_JEAN_JACKET]
    static let _12_16 = [JACKET, CARDIGAN, BLUE_JEAN_JACKET]
    static let _9_11 = [TRENCH_COAT, JACKET, BLUE_JEAN_JACKET]
    static let _5_8 = [PADDING_VEST, COAT]
    static let _4 = [PADDING]
}

struct Accessory {
    static let winter = [FUR_GLOVES, FUR_HAT, MUFFLER]
}
