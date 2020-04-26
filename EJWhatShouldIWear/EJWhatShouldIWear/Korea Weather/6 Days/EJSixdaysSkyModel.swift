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
    
    public func dictionaryRepresentation() -> [String: String] {
        var array: [String: String] = [:]
        
        if let value = amName10day { array[CodingKeys.amName10day.rawValue] = value }
        if let value = pmName7day { array[CodingKeys.pmName7day.rawValue] = value }
        if let value = pmCode9day { array[CodingKeys.pmCode9day.rawValue] = value }
        if let value = pmName6day { array[CodingKeys.pmName6day.rawValue] = value }
        if let value = pmCode2day { array[CodingKeys.pmCode2day.rawValue] = value }
        if let value = amCode10day { array[CodingKeys.amCode10day.rawValue] = value }
        if let value = amCode3day { array[CodingKeys.amCode3day.rawValue] = value }
        if let value = pmName9day { array[CodingKeys.pmName9day.rawValue] = value }
        if let value = pmCode7day { array[CodingKeys.pmCode7day.rawValue] = value }
        if let value = pmName10day { array[CodingKeys.pmName10day.rawValue] = value }
        if let value = pmCode8day { array[CodingKeys.pmCode8day.rawValue] = value }
        if let value = amName4day { array[CodingKeys.amName4day.rawValue] = value }
        if let value = pmCode10day { array[CodingKeys.pmCode10day.rawValue] = value }
        if let value = pmCode5day { array[CodingKeys.pmCode5day.rawValue] = value }
        if let value = amName3day { array[CodingKeys.amName3day.rawValue] = value }
        if let value = amName5day { array[CodingKeys.amName5day.rawValue] = value }
        if let value = amCode6day { array[CodingKeys.amCode6day.rawValue] = value }
        if let value = amName2day { array[CodingKeys.amName2day.rawValue] = value }
        if let value = amName7day { array[CodingKeys.amName7day.rawValue] = value }
        if let value = pmName2day { array[CodingKeys.pmName2day.rawValue] = value }
        if let value = amCode2day { array[CodingKeys.amCode2day.rawValue] = value }
        if let value = amName9day { array[CodingKeys.amName9day.rawValue] = value }
        if let value = amName6day { array[CodingKeys.amName6day.rawValue] = value }
        if let value = pmName3day { array[CodingKeys.pmName3day.rawValue] = value }
        if let value = amCode8day { array[CodingKeys.amCode8day.rawValue] = value }
        if let value = amCode9day { array[CodingKeys.amCode9day.rawValue] = value }
        if let value = amCode5day { array[CodingKeys.amCode5day.rawValue] = value }
        if let value = pmCode3day { array[CodingKeys.pmCode3day.rawValue] = value }
        if let value = amCode7day { array[CodingKeys.amCode7day.rawValue] = value }
        if let value = pmName8day { array[CodingKeys.pmName8day.rawValue] = value }
        if let value = pmName4day { array[CodingKeys.pmName4day.rawValue] = value }
        if let value = pmCode4day { array[CodingKeys.pmCode4day.rawValue] = value }
        if let value = pmName5day { array[CodingKeys.pmName5day.rawValue] = value }
        if let value = amCode4day { array[CodingKeys.amCode4day.rawValue] = value }
        if let value = pmCode6day { array[CodingKeys.pmCode6day.rawValue] = value }
        
        return array
    }
}
