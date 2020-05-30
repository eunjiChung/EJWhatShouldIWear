//
//  EJKisangCodes.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/05/26.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Foundation

public enum EJKisangCategory: String, Decodable {
    case POP    // 강수확률(%)
    case PTY    // 강수형태(코드값)
    case R06    // 6시간 강수량(범주 1mm)
    case REH    // 습도(%)
    case S06    // 6시간 신적설(범주 1cm)
    case SKY    // 하늘상태(코드값)
    case T3H    // 3시간 기온(℃)
    case TMN    // 아침 최저기온(℃)
    case TMX    // 낮 최고기온(℃)
    case UUU    // 풍속(동서성분)(m/s)
    case VVV    // 풍속(남북성분)(m/s)
    case WAV    // 파고(M)
    case VEC    // 풍향(m/s)
    case WSD    // 풍속(1)
}

/// 사용법 : let skyCode = EJSkyCode.value.code
public enum EJSkyCode {
    case sunny
    case cloudy
    case grey
    
    var value: (code: Int, message: String) {
        switch self {
        case .sunny:    return (1, "맑음")
        case .cloudy:   return (3, "구름많음")
        case .grey:     return (4, "흐림")
        }
    }
}

public enum EJPrecipitationCode: String {
    case no
    case rain
    case both
    case snow
    case shower
    
    var value: (code: Int, message: String) {
        switch self {
        case .no:       return (0, "없음")
        case .rain:     return (1, "비")
        case .both:     return (2, "비/눈")
        case .snow:     return (3, "눈")
        case .shower:   return (4, "소나기")
        }
    }
}

public enum EJKisangCode: String {
    case NORMAL_SERVICE                                         = "00"
    case APPLICATION_ERROR                                      = "01"
    case DB_ERROR                                               = "02"
    case NODATA_ERROR                                           = "03"
    case HTTP_ERROR                                             = "04"
    case SERVICETIME_OUT                                        = "05"
    case INVALID_REQUEST_PARAMETER_ERROR                        = "10"
    case NO_MANDATORY_REQUEST_PARAMETERS_ERROR                  = "11"
    case NO_OPENAPI_SERVICE_ERROR                               = "12"
    case SERVICE_ACCESS_DENIED_ERROR                            = "20"
    case TEMPORARILY_DISABLE_THE_SERVICEKEY_ERROR               = "21"
    case LIMITED_NUMBER_OF_SERVICE_REQUESTS_EXCEEDS_ERROR       = "22"
    case SERVICE_KEY_IS_NOT_REGISTERED_ERROR                    = "30"
    case DEADLINE_HAS_EXPIRED_ERROR                             = "31"
    case UNREGISTERED_IP_ERROR                                  = "32"
    case UNSIGNED_CALL_ERROR                                    = "33"
    case UNKNOWN_ERROR                                          = "99"
    
    var code: String {
        switch self {
        case .NORMAL_SERVICE:                                   return "00"
        case .APPLICATION_ERROR:                                return "01"
        case .DB_ERROR:                                         return "02"
        case .NODATA_ERROR:                                     return "03"
        case .HTTP_ERROR:                                       return "04"
        case .SERVICETIME_OUT:                                  return "05"
        case .INVALID_REQUEST_PARAMETER_ERROR:                  return "10"
        case .NO_MANDATORY_REQUEST_PARAMETERS_ERROR:            return "11"
        case .NO_OPENAPI_SERVICE_ERROR:                         return "12"
        case .SERVICE_ACCESS_DENIED_ERROR:                      return "20"
        case .TEMPORARILY_DISABLE_THE_SERVICEKEY_ERROR:         return "21"
        case .LIMITED_NUMBER_OF_SERVICE_REQUESTS_EXCEEDS_ERROR: return "22"
        case .SERVICE_KEY_IS_NOT_REGISTERED_ERROR:              return "30"
        case .DEADLINE_HAS_EXPIRED_ERROR:                       return "31"
        case .UNREGISTERED_IP_ERROR:                            return "32"
        case .UNSIGNED_CALL_ERROR:                              return "33"
        case .UNKNOWN_ERROR:                                    return "99"
        }
    }
}

public enum EJKisangWeekelyForecastAreaCode: String {
    case SeoulIncheonKyungki        = "11B00000"
    case KangwonYoungWest           = "11D10000"
    case KangwonYoungEast           = "11D20000"
    case DaegeonSejongChoongSouth   = "11C20000"
    case ChoongNorth                = "11C10000"
    case GwangjuJeonraSouth         = "11F20000"
    case JeonraNorth                = "11F10000"
    case DaeguKyungsangNorth        = "11H10000"
    case BusanUlsanKyungsangSouth   = "11H20000"
    case Jeju                       = "11G00000"
}
