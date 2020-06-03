//
//  EJClothManager.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/04/17.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Foundation

final class EJClothManager {
    
    static let shared = EJClothManager()
    
    // MARK: - Kisang Clothes
    public func setItem(by condition: EJWeatherType) -> String {
        switch condition {
        case .rain, .shower, .both:
            return UMBRELLA
        case .snow:
            return [FUR_GLOVES, FUR_HAT, MUFFLER].randomElement()!
        default:
            return setOuterItem(by: condition)
        }
    }
    
    public func setOuterItem(by condition: EJWeatherType) -> String {
        return ""
    }
    
    // MARK: - Legacy Clothes
    public func setClothByCondition(_ condition:WeatherCondition) -> String {
        switch condition {
        case .tornado, .ash, .dust, .haze:
            return MASK
        case .squall, .thunderstorm, .rain, .drizzle:
            return UMBRELLA
        case .snow:
            return [FUR_GLOVES, FUR_HAT, MUFFLER].randomElement()!
        default:
            return BLUE_JEAN_JACKET
        }
    }
    
    public func setTopCloth(by temp: Int) -> String {
        switch temp {
        case TempRange.temp_28:
            return Top._28.randomElement()!
        case TempRange.temp_23_27:
            return Top._23_27.randomElement()!
        case TempRange.temp_20_22:
            return Top._20_22.randomElement()!
        case TempRange.temp_17_19:
            return Top._17_19.randomElement()!
        case TempRange.temp_12_16:
            return Top._12_16.randomElement()!
        case TempRange.temp_9_11:
            return Top._9_11.randomElement()!
        case TempRange.temp_5_8:
            return Top._5_8.randomElement()!
        case TempRange.temp_4:
            return Top._4.randomElement()!
        default:
            return Top._23_27.randomElement()!
        }
    }
    
    public func getClothList(_ minTemp: Int, _ maxTemp: Int) -> [String] {
        var list = [String]()
        
        switch maxTemp {
        case TempRange.temp_28:
            list += Top._28
            if !TempRange.temp_28.contains(minTemp) { fallthrough }
        case TempRange.temp_23_27:
            list += Top._23_27
            if !TempRange.temp_23_27.contains(minTemp) { fallthrough }
        case TempRange.temp_20_22:
            list += Top._20_22
            if !TempRange.temp_20_22.contains(minTemp) { fallthrough }
        case TempRange.temp_17_19:
            list += Top._17_19
            if !TempRange.temp_17_19.contains(minTemp) { fallthrough }
        case TempRange.temp_12_16:
            list += Top._12_16
            if !TempRange.temp_12_16.contains(minTemp) { fallthrough }
        case TempRange.temp_9_11:
            list += Top._9_11
            if !TempRange.temp_9_11.contains(minTemp) { fallthrough }
        case TempRange.temp_5_8:
            list += Top._5_8
            if !TempRange.temp_5_8.contains(minTemp) { fallthrough }
        case TempRange.temp_4:
            list += Top._4
            if !TempRange.temp_4.contains(minTemp) { fallthrough }
        default:
            list = Top._23_27
        }
        return list
    }
    
    
    public func setBottomCloth(by temp: Int) -> String {
        switch temp {
        case TempRange.temp_28:
            return Bottom._28.randomElement()!
        case TempRange.temp_23_27:
            return Bottom._23_27.randomElement()!
        case TempRange.temp_20_22:
            return Bottom._20_22.randomElement()!
        case TempRange.temp_17_19:
            return Bottom._17_19.randomElement()!
        case TempRange.temp_12_16:
            return Bottom._12_16.randomElement()!
        case TempRange.temp_9_11:
            return Bottom._9_11.randomElement()!
        case TempRange.temp_5_8:
            return Bottom._5_8.randomElement()!
        case TempRange.temp_4:
            return Bottom._4.randomElement()!
        default:
            return Bottom._23_27.randomElement()!
        }
    }
    
    public func setOuterCloth(by temp: Int) -> String {
        switch temp {
        case TempRange.temp_28:
            return Top._28.randomElement()!
        case TempRange.temp_23_27:
            return Top._23_27.randomElement()!
        case TempRange.temp_20_22:
            return Outer._20_22.randomElement()!
        case TempRange.temp_17_19:
            return Outer._17_19.randomElement()!
        case TempRange.temp_12_16:
            return Outer._12_16.randomElement()!
        case TempRange.temp_9_11:
            return Outer._9_11.randomElement()!
        case TempRange.temp_5_8:
            return Outer._5_8.randomElement()!
        case TempRange.temp_4:
            return Outer._4.randomElement()!
        default:
            return Outer._20_22.randomElement()!
        }
    }
}
