//
//  Cloth.swift
//  EJWhatShouldIWear
//
//  Created by eunji on 08/08/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Foundation

enum EJClothCategory: String, Decodable {
    case TOP
    case BOTTOM
    case OUTER
    case ACCESSORY
}

enum EJWeatherLevel: Int, Decodable {
    case _4 = 0
    case _5_8
    case _9_11
    case _12_16
    case _17_19
    case _20_22
    case _23_27
    case _28
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
