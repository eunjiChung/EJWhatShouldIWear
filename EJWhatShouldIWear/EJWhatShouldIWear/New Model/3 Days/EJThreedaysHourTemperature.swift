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
        case temp37hour = "temp37hour"
        case  temp25hour = "temp25hour"
        case  temp4hour = "temp4hour"
        case  temp7hour = "temp7hour"
        case  temp64hour = "temp64hour"
        case  temp61hour = "temp61hour"
        case  temp10hour = "temp10hour"
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
        case  temp67hour = "temp67hour"
        case  temp31hour = "temp31hour"
        case  temp22hour = "temp22hour"
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
}
