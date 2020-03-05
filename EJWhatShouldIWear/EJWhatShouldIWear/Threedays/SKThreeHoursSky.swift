//
//  SKThreeHoursSky.swift
//  EJWhatShouldIWear
//
//  Created by CHUNGEUNJI on 02/02/2020.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Foundation

final class SKThreeHoursSky: Decodable {

    enum Keys: String {
      case name58hour
      case code46hour
      case name10hour
      case name67hour
      case code64hour
      case name22hour
      case code22hour
      case code16hour
      case name25hour
      case code25hour
      case name13hour
      case name37hour
      case code4hour
      case name7hour
      case name40hour
      case name49hour
      case name19hour
      case name16hour
      case code52hour
      case code34hour
      case name34hour
      case name64hour
      case code43hour
      case code40hour
      case name43hour
      case code37hour
      case code31hour
      case code67hour
      case code61hour
      case code58hour
      case code10hour
      case code28hour
      case code19hour
      case name61hour
      case code13hour
      case name55hour
      case name52hour
      case code49hour
      case code7hour
      case name28hour
      case name4hour
      case name31hour
      case code55hour
      case name46hour
    }
    
    let name58hour: String
    let code46hour: String
    let name10hour: String
    let name67hour: String
    let code64hour: String
    let name22hour: String
    let code22hour: String
    let code16hour: String
    let name25hour: String
    let code25hour: String
    let name13hour: String
    let name37hour: String
    let code4hour: String
    let name7hour: String
    let name40hour: String
    let name49hour: String
    let name19hour: String
    let name16hour: String
    let code52hour: String
    let code34hour: String
    let name34hour: String
    let name64hour: String
    let code43hour: String
    let code40hour: String
    let name43hour: String
    let code37hour: String
    let code31hour: String
    let code67hour: String
    let code61hour: String
    let code58hour: String
    let code10hour: String
    let code28hour: String
    let code19hour: String
    let name61hour: String
    let code13hour: String
    let name55hour: String
    let name52hour: String
    let code49hour: String
    let code7hour: String
    let name28hour: String
    let name4hour: String
    let name31hour: String
    let code55hour: String
    let name46hour: String
    
    public func dictionaryRepresentation() -> [String: String] {
        var dictionary: [String: String] = [:]
        dictionary[Keys.code46hour.rawValue] = code46hour
        dictionary[Keys.code64hour.rawValue] = code64hour
        dictionary[Keys.code22hour.rawValue] = code22hour
        dictionary[Keys.code16hour.rawValue] = code16hour
        dictionary[Keys.code25hour.rawValue] = code25hour
        dictionary[Keys.code4hour.rawValue] = code4hour
        dictionary[Keys.code52hour.rawValue] = code52hour
        dictionary[Keys.code34hour.rawValue] = code34hour
        dictionary[Keys.code43hour.rawValue] = code43hour
        dictionary[Keys.code40hour.rawValue] = code40hour
        dictionary[Keys.code37hour.rawValue] = code37hour
        dictionary[Keys.code31hour.rawValue] = code31hour
        dictionary[Keys.code67hour.rawValue] = code67hour
        dictionary[Keys.code61hour.rawValue] = code61hour
        dictionary[Keys.code58hour.rawValue] = code58hour
        dictionary[Keys.code10hour.rawValue] = code10hour
        dictionary[Keys.code28hour.rawValue] = code28hour
        dictionary[Keys.code19hour.rawValue] = code19hour
        dictionary[Keys.code13hour.rawValue] = code13hour
        dictionary[Keys.code49hour.rawValue] = code49hour
        dictionary[Keys.code7hour.rawValue] = code7hour
        dictionary[Keys.code55hour.rawValue] = code55hour
        return dictionary
    }
}
