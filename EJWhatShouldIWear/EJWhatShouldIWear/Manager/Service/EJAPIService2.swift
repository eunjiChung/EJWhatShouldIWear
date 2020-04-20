//
//  EJAPIService2.swift
//  EJWhatShouldIWear
//
//  Created by eunji chung on 2020/04/20.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Foundation

enum EJAPIService2 {
    // MARK: - 회원 & 버전정보.
    case getApplicationData
    case checkVersion
    
    // MARK: - 로그인
    // 이메일 로그인
//    case emailLogin(email: String, password: String, isDormant: Int)
//    case connectSNSWithEmail(snsAccountData: KMSNSAccountData, password: String, isDormant: Int)
//    case emailSignUp(email: String, password: String, mileageCode: String?, isAdsMessage: String, isUnconnected: String)
//    case snsSignUp(snsAccountData: KMSNSAccountData, mileageCode: String?, isAdsMessage: String, isUnconnected: String)
}


extension EJAPIService2: TargetType {
    
    var baseURL: URL { return URL(string: "")! }
    
    var path: String {
        switch self {
        default:
            return ""
            // 회원정보
//            case .getApplicationData:                   return "/api/v4/getApplicationData"
//
//            // 앱 버전 체크
//            case .checkVersion:                         return "/api/v4/checkVersion"
//
//            // 이메일 로그인
//            case .emailLogin:                            return "/api/v4/auth/login"
//            case .connectSNSWithEmail(let snsAccountData, _, _):    return "/api/v4/auth/login/connect-sns/\(snsAccountData.serviceName.rawValue)"
//            case .emailSignUp:                              return "/api/v5/signup"
//            case .snsSignUp(let snsAccountData, _, _, _): return "/api/v5/signup/sns/\(snsAccountData.serviceName.rawValue)"
        }
    }
    
    var method: Method {
        switch self {
        default:
            return .get
//            case .homeHeader, .homeMainThemes, .homeCategoryMainThemes,
//                 .subCategories, .getGigListHeader, .getGigListFooter,
//                 .getPortfolios, .getGigListWithCategory, .getRecommendedKeywords:
//                 return .get
                
        }
    }
    
    var task: Task {
        switch self {
        default:
            return .requestPlain
//        case .homeHeader, .subCategories, .addBookmark:
//            return .requestPlain
//        case .getApplicationData:
//            var param: [String: Any] = [String: Any]()
//            param[KMJsonKey.device] = "ios"
//
//            let userDefaults: UserDefaults = UserDefaults.standard
//            if let api_token = userDefaults.string(forKey: UserDefaultKey.apiToken) {
//                param[KMJsonKey.token] = api_token
//            }
//            param[KMJsonKey.usedVersionInCategories] = userDefaults.string(forKey: UserDefaultKey.dataVersion) ?? ""
//            param[KMJsonKey.app_key] = userDefaults.value(forKey: UserDefaultKey.deviceToken) as? String ?? ""
//            param[KMJsonKey.device_uuid] = userDefaults.value(forKey: UserDefaultKey.UUID) as? String ?? ""
//
//            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return nil
//        let userAgent: String = KMUserDefaultsManager.shared.userAgent ?? ""
//        var param = ["User-Agent": userAgent]
//
//        if let api_token = UserDefaults.standard.string(forKey: UserDefaultKey.apiToken) {
//            param[KMJsonKey.token] = api_token
//        }
//
//        return param
    }
    
    var sampleData: Data {
        
        switch self {
//        case .specialGigs(_):
//            guard let url = Bundle.main.url(forResource: "SpecialGigsSampleData", withExtension: "json"), let data = try? Data(contentsOf: url) else { return Data() }
//
//            return data
//
//        case .myOrders(_, _, _, _ , _, _, _):
//            guard let url = Bundle.main.url(forResource: "MySellingSampleData", withExtension: "json"), let data = try? Data(contentsOf: url) else { return Data() }
//
//            return data
//
//        case .getNewGigDetail(_):
//            guard let url = Bundle.main.url(forResource: "NewGigDetailSampleData", withExtension: "json"), let data = try? Data(contentsOf: url) else { return Data() }
//
//            return data
        default:
            return Data()
        }
    }
}
