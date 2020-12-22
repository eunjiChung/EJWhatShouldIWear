//
//  EJForeignWeatherAPI.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/12/21.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Foundation
import Moya

enum EJForeignWeatherAPI {
    case fiveDaysWeather
}

extension EJForeignWeatherAPI: TargetType {

    var baseURL: URL { return URL(string: EJURLString.foreignBaseURL)! }

    var path: String {
        switch self {
        case .fiveDaysWeather:          return "/forecast"
        }
    }

    var method: Moya.Method {
        switch self {
        case .fiveDaysWeather:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .fiveDaysWeather:
            let param: [String: Any] = ["lat": EJLocationManager.shared.latitude,
                                        "lon": EJLocationManager.shared.longitude,
                                        "apiKey": owmAppKey]
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        }
    }

    var sampleData: Data {
        return Data()
    }

    var headers: [String: String]? {
        let param = [
            "Content-Type": "application/json"
//            "Authorization": "ai_company"
        ]
        return param
    }
}

