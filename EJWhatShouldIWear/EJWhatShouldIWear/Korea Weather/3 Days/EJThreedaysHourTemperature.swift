//
//  EJThreedaysHourTemperature.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/04/17.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Foundation

public struct EJThreedaysHourTemperature: Decodable {
    private enum CodingKeys: String, CodingKey {
        case  temp4hour = "temp4hour"
        case  temp7hour = "temp7hour"
        case  temp10hour = "temp10hour"
        case temp37hour = "temp37hour"
        case  temp25hour = "temp25hour"
        case  temp61hour = "temp61hour"
        case  temp28hour = "temp28hour"
        case  temp58hour = "temp58hour"
        case  temp19hour = "temp19hour"
        case  temp34hour = "temp34hour"
        case temp13hour = "temp13hour"
        case  temp46hour = "temp46hour"
        case  temp55hour = "temp55hour"
        case  temp40hour = "temp40hour"
        case  temp16hour = "temp16hour"
        case  temp43hour = "temp43hour"
        case  temp52hour = "temp52hour"
        case  temp49hour = "temp49hour"
        case  temp31hour = "temp31hour"
        case  temp22hour = "temp22hour"
        case  temp64hour = "temp64hour"
        case  temp67hour = "temp67hour"
    }
    
    public var temp37hour: String?
    public var temp25hour: String?
    public var temp4hour: String?
    public var temp7hour: String?
    public var temp64hour: String?
    public var temp61hour: String?
    public var temp10hour: String?
    public var temp28hour: String?
    public var temp58hour: String?
    public var temp19hour: String?
    public var temp34hour: String?
    public var temp13hour: String?
    public var temp46hour: String?
    public var temp55hour: String?
    public var temp40hour: String?
    public var temp16hour: String?
    public var temp43hour: String?
    public var temp52hour: String?
    public var temp49hour: String?
    public var temp67hour: String?
    public var temp31hour: String?
    public var temp22hour: String?
    
    public func dictionaryRepresentation() -> [String: String] {
        var array: [String: String] = [:]
        
        if let value = temp37hour { array[CodingKeys.temp37hour.rawValue] = value }
        if let value = temp25hour { array[CodingKeys.temp25hour.rawValue] = value }
        if let value = temp4hour { array[CodingKeys.temp4hour.rawValue] = value }
        if let value = temp7hour { array[CodingKeys.temp7hour.rawValue] = value }
        if let value = temp64hour { array[CodingKeys.temp64hour.rawValue] = value }
        if let value = temp61hour { array[CodingKeys.temp61hour.rawValue] = value }
        if let value = temp10hour { array[CodingKeys.temp10hour.rawValue] = value }
        if let value = temp28hour { array[CodingKeys.temp28hour.rawValue] = value }
        if let value = temp58hour { array[CodingKeys.temp58hour.rawValue] = value }
        if let value = temp19hour { array[CodingKeys.temp19hour.rawValue] = value }
        if let value = temp34hour { array[CodingKeys.temp34hour.rawValue] = value }
        if let value = temp13hour { array[CodingKeys.temp13hour.rawValue] = value }
        if let value = temp46hour { array[CodingKeys.temp46hour.rawValue] = value }
        if let value = temp55hour { array[CodingKeys.temp55hour.rawValue] = value }
        if let value = temp40hour { array[CodingKeys.temp40hour.rawValue] = value }
        if let value = temp16hour { array[CodingKeys.temp16hour.rawValue] = value }
        if let value = temp43hour { array[CodingKeys.temp43hour.rawValue] = value }
        if let value = temp52hour { array[CodingKeys.temp52hour.rawValue] = value }
        if let value = temp49hour { array[CodingKeys.temp49hour.rawValue] = value }
        if let value = temp67hour { array[CodingKeys.temp67hour.rawValue] = value }
        if let value = temp31hour { array[CodingKeys.temp31hour.rawValue] = value }
        if let value = temp22hour { array[CodingKeys.temp22hour.rawValue] = value }
        
        return array
    }
}
