//
//  EJKisangTimelyModel.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/05/26.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Foundation

public struct EJKisangTimelyModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case baseDate
        case baseTime
        case category
        case fcstDate
        case fcstTime
        case fcstValue
        case nx
        case ny
    }
    
    var baseDate: String
    var baseTime: String
    var category: EJKisangCategory
    var fcstDate: String
    var fcstTime: String
    var fcstValue: String
    var nx: Int
    var ny: Int
}
