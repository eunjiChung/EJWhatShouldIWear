//
//  EJSkyModel.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/04/17.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Foundation

public struct EJSkyModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case name58hour = "name58hour"
        case code46hour = "code46hour"
        case name10hour = "name10hour"
        case name67hour = "name67hour"
        case code64hour = "code64hour"
        case name22hour = "name22hour"
        case code22hour = "code22hour"
        case code16hour = "code16hour"
        case name25hour = "name25hour"
        case code25hour = "code25hour"
        case name13hour = "name13hour"
        case name37hour = "name37hour"
        case code4hour = "code4hour"
        case name7hour = "name7hour"
        case name40hour = "name40hour"
        case name49hour = "name49hour"
        case name19hour = "name19hour"
        case name16hour = "name16hour"
        case code52hour = "code52hour"
        case code34hour = "code34hour"
        case name34hour = "name34hour"
        case name64hour = "name64hour"
        case code43hour = "code43hour"
        case code40hour = "code40hour"
        case name43hour = "name43hour"
        case code37hour = "code37hour"
        case code31hour = "code31hour"
        case code67hour = "code67hour"
        case code61hour = "code61hour"
        case code58hour = "code58hour"
        case code10hour = "code10hour"
        case code28hour = "code28hour"
        case code19hour = "code19hour"
        case name61hour = "name61hour"
        case code13hour = "code13hour"
        case name55hour = "name55hour"
        case name52hour = "name52hour"
        case code49hour = "code49hour"
        case code7hour = "code7hour"
        case name28hour = "name28hour"
        case name4hour = "name4hour"
        case name31hour = "name31hour"
        case code55hour = "code55hour"
        case name46hour = "name46hour"
    }
    
    public var name58hour: String?
    public var code46hour: String?
    public var name10hour: String?
    public var name67hour: String?
    public var code64hour: String?
    public var name22hour: String?
    public var code22hour: String?
    public var code16hour: String?
    public var name25hour: String?
    public var code25hour: String?
    public var name13hour: String?
    public var name37hour: String?
    public var code4hour: String?
    public var name7hour: String?
    public var name40hour: String?
    public var name49hour: String?
    public var name19hour: String?
    public var name16hour: String?
    public var code52hour: String?
    public var code34hour: String?
    public var name34hour: String?
    public var name64hour: String?
    public var code43hour: String?
    public var code40hour: String?
    public var name43hour: String?
    public var code37hour: String?
    public var code31hour: String?
    public var code67hour: String?
    public var code61hour: String?
    public var code58hour: String?
    public var code10hour: String?
    public var code28hour: String?
    public var code19hour: String?
    public var name61hour: String?
    public var code13hour: String?
    public var name55hour: String?
    public var name52hour: String?
    public var code49hour: String?
    public var code7hour: String?
    public var name28hour: String?
    public var name4hour: String?
    public var name31hour: String?
    public var code55hour: String?
    public var name46hour: String?
    
    public func dictionaryRepresentation() -> [String: String] {
        var array: [String: String] = [:]
        
        if let value = name58hour { array[CodingKeys.name58hour.rawValue] = value }
        if let value = code46hour { array[CodingKeys.code46hour.rawValue] = value }
        if let value = name10hour { array[CodingKeys.name10hour.rawValue] = value }
        if let value = name67hour { array[CodingKeys.name67hour.rawValue] = value }
        if let value = code64hour { array[CodingKeys.code64hour.rawValue] = value }
        if let value = name22hour { array[CodingKeys.name22hour.rawValue] = value }
        if let value = code22hour { array[CodingKeys.code22hour.rawValue] = value }
        if let value = code16hour { array[CodingKeys.code16hour.rawValue] = value }
        if let value = name25hour { array[CodingKeys.name25hour.rawValue] = value }
        if let value = code25hour { array[CodingKeys.code25hour.rawValue] = value }
        if let value = name13hour { array[CodingKeys.name13hour.rawValue] = value }
        if let value = name37hour { array[CodingKeys.name37hour.rawValue] = value }
        if let value = code4hour { array[CodingKeys.code4hour.rawValue] = value }
        if let value = name7hour { array[CodingKeys.name7hour.rawValue] = value }
        if let value = name40hour { array[CodingKeys.name40hour.rawValue] = value }
        if let value = name49hour { array[CodingKeys.name49hour.rawValue] = value }
        if let value = name19hour { array[CodingKeys.name19hour.rawValue] = value }
        if let value = name16hour { array[CodingKeys.name16hour.rawValue] = value }
        
        if let value = code52hour { array[CodingKeys.code52hour.rawValue] = value }
        if let value = code34hour { array[CodingKeys.code34hour.rawValue] = value }
        if let value = name34hour { array[CodingKeys.name34hour.rawValue] = value }
        if let value = name64hour { array[CodingKeys.name64hour.rawValue] = value }
        if let value = code43hour { array[CodingKeys.code43hour.rawValue] = value }
        if let value = code40hour { array[CodingKeys.code40hour.rawValue] = value }
        if let value = name43hour { array[CodingKeys.name43hour.rawValue] = value }
        if let value = code37hour { array[CodingKeys.code37hour.rawValue] = value }
        if let value = code31hour { array[CodingKeys.code31hour.rawValue] = value }
        if let value = code67hour { array[CodingKeys.code67hour.rawValue] = value }
        if let value = code61hour { array[CodingKeys.code61hour.rawValue] = value }
        
        if let value = code58hour { array[CodingKeys.code58hour.rawValue] = value }
        if let value = code10hour { array[CodingKeys.code10hour.rawValue] = value }
        if let value = code28hour { array[CodingKeys.code28hour.rawValue] = value }
        if let value = code19hour { array[CodingKeys.code19hour.rawValue] = value }
        if let value = name61hour { array[CodingKeys.name61hour.rawValue] = value }
        if let value = code13hour { array[CodingKeys.code13hour.rawValue] = value }
        if let value = name55hour { array[CodingKeys.name55hour.rawValue] = value }
        if let value = name52hour { array[CodingKeys.name52hour.rawValue] = value }
        if let value = code49hour { array[CodingKeys.code49hour.rawValue] = value }
        if let value = code7hour { array[CodingKeys.code7hour.rawValue] = value }
        if let value = name28hour { array[CodingKeys.name28hour.rawValue] = value }
        
        if let value = name4hour { array[CodingKeys.name4hour.rawValue] = value }
        if let value = name31hour { array[CodingKeys.name31hour.rawValue] = value }
        if let value = code55hour { array[CodingKeys.code55hour.rawValue] = value }
        if let value = name46hour { array[CodingKeys.name46hour.rawValue] = value }
        
        return array
    }
}
