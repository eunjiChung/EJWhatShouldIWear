//
//  EJWeatherAPI.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/12/21.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Foundation
import Moya

enum EJWeatherAPI {
    case today(nx: Int, ny: Int)    // 격자
    case weekly(regionId: String)      // 지역 코드
}

extension EJWeatherAPI: TargetType {

    var baseURL: URL { return URL(string: EJURLString.baseURL)! }

    var path: String {
        switch self {
        case .today(_, _):                          return "/today"
        case .weekly(_):                            return "/week"
        }
    }

    var method: Moya.Method {
        switch self {
        case .today, .weekly:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .today(let nx, let ny):
            let param: [String: Any] = ["nx": nx,
                                        "ny": ny]
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        case .weekly(let regionId):
            let param: [String: Any] = ["regId": regionId]
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        }
    }

    var sampleData: Data {
        return Data()
    }

    var headers: [String: String]? {
        let param = [
            "Content-Type": "application/json",
            "token":        kisangAppKey
//            "Authorization": "ai_company"
        ]
        return param
    }
}
