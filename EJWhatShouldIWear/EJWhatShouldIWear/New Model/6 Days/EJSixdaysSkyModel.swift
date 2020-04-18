//
//  EJSixdaysSkyModel.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/04/17.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Foundation

public struct EJSixdaysSkyModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case amName10day
        case pmName7day
        case amName8day
        case pmCode9day
        case pmName6day
        case pmCode2day
        case amCode10day
        case amCode3day
        case pmName9day
        case pmCode7day
        case pmName10day
        case pmCode8day
        case amName4day
        case pmCode10day
        case pmCode5day
        case amName3day
        case amName5day
        case amCode6day
        case amName2day
        case amName7day
        case pmName2day
        case amCode2day
        case amName9day
        case amName6day
        case pmName3day
        case amCode8day
        case amCode9day
        case amCode5day
        case pmCode3day
        case amCode7day
        case pmName8day
        case pmName4day
        case pmCode4day
        case pmName5day
        case amCode4day
        case pmCode6day
    }

    public var amName10day: String?
    public var pmName7day: String?
    public var amName8day: String?
    public var pmCode9day: String?
    public var pmName6day: String?
    public var pmCode2day: String?
    public var amCode10day: String?
    public var amCode3day: String?
    public var pmName9day: String?
    public var pmCode7day: String?
    public var pmName10day: String?
    public var pmCode8day: String?
    public var amName4day: String?
    public var pmCode10day: String?
    public var pmCode5day: String?
    public var amName3day: String?
    public var amName5day: String?
    public var amCode6day: String?
    public var amName2day: String?
    public var amName7day: String?
    public var pmName2day: String?
    public var amCode2day: String?
    public var amName9day: String?
    public var amName6day: String?
    public var pmName3day: String?
    public var amCode8day: String?
    public var amCode9day: String?
    public var amCode5day: String?
    public var pmCode3day: String?
    public var amCode7day: String?
    public var pmName8day: String?
    public var pmName4day: String?
    public var pmCode4day: String?
    public var pmName5day: String?
    public var amCode4day: String?
    public var pmCode6day: String?
}
