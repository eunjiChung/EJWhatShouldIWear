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
    
    public func setClothByCondition(_ condition:WeatherCondition) -> String {
        var tag: String
        
        switch condition {
        case .tornado, .ash, .dust, .haze:
            tag = MASK
        case .squall, .thunderstorm, .rain, .drizzle:
            tag = UMBRELLA
        case .snow:
            tag = [FUR_GLOVES, FUR_HAT, MUFFLER].randomElement()!
        default:
            tag = BLUE_JEAN_JACKET
        }
        
        return tag
    }
    
    public func setTopCloth(by temp: Int) -> String {
        var cloth = ""
        
        switch temp {
        case TempRange.temp_28:
            cloth = Top._28.randomElement()!
        case TempRange.temp_23_27:
            cloth = Top._23_27.randomElement()!
        case TempRange.temp_20_22:
            cloth = Top._20_22.randomElement()!
        case TempRange.temp_17_19:
            cloth = Top._17_19.randomElement()!
        case TempRange.temp_12_16:
            cloth = Top._12_16.randomElement()!
        case TempRange.temp_9_11:
            cloth = Top._9_11.randomElement()!
        case TempRange.temp_5_8:
            cloth = Top._5_8.randomElement()!
        case TempRange.temp_4:
            cloth = Top._4.randomElement()!
        default:
            cloth = Top._23_27.randomElement()!
        }
        
        return cloth
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
        var cloth = ""
        
        switch temp {
        case TempRange.temp_28:
            cloth = Bottom._28.randomElement()!
        case TempRange.temp_23_27:
            cloth = Bottom._23_27.randomElement()!
        case TempRange.temp_20_22:
            cloth = Bottom._20_22.randomElement()!
        case TempRange.temp_17_19:
            cloth = Bottom._17_19.randomElement()!
        case TempRange.temp_12_16:
            cloth = Bottom._12_16.randomElement()!
        case TempRange.temp_9_11:
            cloth = Bottom._9_11.randomElement()!
        case TempRange.temp_5_8:
            cloth = Bottom._5_8.randomElement()!
        case TempRange.temp_4:
            cloth = Bottom._4.randomElement()!
        default:
            cloth = Bottom._23_27.randomElement()!
        }
        
        return cloth
    }
    
    public func setOuterCloth(by temp: Int) -> String {
        var cloth = ""
        
        switch temp {
        case TempRange.temp_28:
            cloth = Top._28.randomElement()!
        case TempRange.temp_23_27:
            cloth = Top._23_27.randomElement()!
        case TempRange.temp_20_22:
            cloth = Outer._20_22.randomElement()!
        case TempRange.temp_17_19:
            cloth = Outer._17_19.randomElement()!
        case TempRange.temp_12_16:
            cloth = Outer._12_16.randomElement()!
        case TempRange.temp_9_11:
            cloth = Outer._9_11.randomElement()!
        case TempRange.temp_5_8:
            cloth = Outer._5_8.randomElement()!
        case TempRange.temp_4:
            cloth = Outer._4.randomElement()!
        default:
            cloth = Outer._20_22.randomElement()!
        }
        
        return cloth
    }
}
