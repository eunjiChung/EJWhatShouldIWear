//
//  EJThreedaysFcst6hourModel.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/04/17.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Foundation

public struct EJThreedaysFcst6hourModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case snow42hour = "snow42hour"
        case snow6hour = "snow6hour"
        case rain42hour = "rain42hour"
        case snow60hour = "snow60hour"
        case snow30hour = "snow30hour"
        case rain60hour = "rain60hour"
        case snow18hour = "snow18hour"
        case rain18hour = "rain18hour"
        case rain24hour = "rain24hour"
        case rain36hour = "rain36hour"
        case rain66hour = "rain66hour"
        case snow36hour = "snow36hour"
        case snow48hour = "snow48hour"
        case rain6hour = "rain6hour"
        case snow12hour = "snow12hour"
        case rain30hour = "rain30hour"
        case rain54hour = "rain54hour"
        case snow24hour = "snow24hour"
        case rain48hour = "rain48hour"
        case snow54hour = "snow54hour"
        case rain12hour = "rain12hour"
        case snow66hour = "snow66hour"
    }
    
    public var snow42hour: String?
    public var snow6hour: String?
    public var rain42hour: String?
    public var snow60hour: String?
    public var snow30hour: String?
    public var rain60hour: String?
    public var snow18hour: String?
    public var rain18hour: String?
    public var rain24hour: String?
    public var rain36hour: String?
    public var rain66hour: String?
    public var snow36hour: String?
    public var snow48hour: String?
    public var rain6hour: String?
    public var snow12hour: String?
    public var rain30hour: String?
    public var rain54hour: String?
    public var snow24hour: String?
    public var rain48hour: String?
    public var snow54hour: String?
    public var rain12hour: String?
    public var snow66hour: String?
}
