//
//  EJKoreaLocalModel.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/04/30.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Foundation

public struct EJKoreaLocalModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case korea
    }
    var korea: [EJKoreaCityModel]
}

public struct EJKoreaCityModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case cityName = "city_name"
        case districts
    }
    
    var cityName: String
    var districts: [EJDistrictCityModel]
}

public struct EJDistrictCityModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case districtName = "district_name"
        case neighborhoods
    }
    
    var districtName: String
    var neighborhoods: [String]
}
