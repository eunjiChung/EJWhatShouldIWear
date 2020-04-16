//
//  EJHumidityModel.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/04/17.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Foundation

public struct EJHumidityModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case rh22hour = "rh22hour"
        case rh46hour = "rh46hour"
        case rh55hour = "rh55hour"
        case rh61hour = "rh61hour"
        case rh10hour = "rh10hour"
        case rh28hour = "rh28hour"
        case rh43hour = "rh43hour"
        case rh7hour = "rh7hour"
        case rh19hour = "rh19hour"
        case rh4hour = "rh4hour"
        case rh25hour = "rh25hour"
        case rh67hour = "rh67hour"
        case rh52hour = "rh52hour"
        case rh40hour = "rh40hour"
        case rh37hour = "rh37hour"
        case rh16hour = "rh16hour"
        case rh31hour = "rh31hour"
        case rh49hour = "rh49hour"
        case rh34hour = "rh34hour"
        case rh58hour = "rh58hour"
        case rh64hour = "rh64hour"
        case rh13hour = "rh13hour"
    }
    
    public var rh22hour: String?
    public var rh46hour: String?
    public var rh55hour: String?
    public var rh61hour: String?
    public var rh10hour: String?
    public var rh28hour: String?
    public var rh43hour: String?
    public var rh7hour: String?
    public var rh19hour: String?
    public var rh4hour: String?
    public var rh25hour: String?
    public var rh67hour: String?
    public var rh52hour: String?
    public var rh40hour: String?
    public var rh37hour: String?
    public var rh16hour: String?
    public var rh31hour: String?
    public var rh49hour: String?
    public var rh34hour: String?
    public var rh58hour: String?
    public var rh64hour: String?
    public var rh13hour: String?
}
