//
//  EJKisangCodes.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/05/26.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

enum EJKisangWeatherCode: String, Decodable {
    case rainFallPercent            = "POP" // 강수확률(%)
    case rainFallType               = "PTY" // 강수형태(코드값)
    case sixHourRainFall            = "R06" // 6시간 강수량(범주 1mm)
    case humidityPercentage         = "REH" // 습도(%)
    case sixHourSnowFall            = "S06" // 6시간 신적설(범주 1cm)
    case skyCode                    = "SKY" // 하늘상태(코드값)
    case threeHourTemp              = "T3H" // 3시간 기온(℃)
    case morningMinTemp             = "TMN" // 아침 최저기온(℃)
    case noonMaxTemp                = "TMX" // 낮 최고기온(℃)
    case windSpeedEastWest          = "UUU" // 풍속(동서성분)(m/s)
    case windSpeedSouthNorth        = "VVV" // 풍속(남북성분)(m/s)
    case waveHeight                 = "WAV" // 파고(M)
    case windDirection              = "VEC" // 풍향(m/s)
    case windSpeed                  = "WSD" // 풍속(1)
}

public enum EJWeatherCondition {
    case sky
    case rainy
}

public enum EJWeatherType: Int {
    case no = 0
    case sunny
    case cloudy
    case soCloudy
    case rain
    case shower
    case both
    case snow
}

typealias WeatherValue = (type: EJWeatherType,
                          condition: EJWeatherCondition,
                          message: String,
                          descript: String,
                          image: UIImage,
                          fontColor: UIColor)

protocol WeatherCode {
    var value: WeatherValue { get }
}

public enum EJSkyCode: Int, WeatherCode {
    case sunny = 1
    case cloudy = 3
    case grey = 4
    
    var value: WeatherValue {
        switch self {
        case .sunny:    return (.sunny, .sky, "맑음", "맑아요", UIImage(named: "clear")!, .darkText)
        case .cloudy:   return (.cloudy, .sky, "구름많음", "구름조금", UIImage(named: "cloudy")!, .darkText)
        case .grey:     return (.soCloudy, .sky, "흐림", "흐려요", UIImage(named: "cloud")!, .darkText)
        }
    }
}

public enum EJPrecipitationCode: Int, WeatherCode {
    case no = 0
    case rain = 1
    case both = 2
    case snow = 3
    case shower = 4
    
    var value: WeatherValue {
        switch self {
        case .no:       return (.no, .rainy, "없음", "", UIImage(named: "clear")!, .darkText)
        case .rain:     return (.rain, .rainy, "비", "비와요", UIImage(named: "rainy")!, .white)
        case .both:     return (.both, .rainy, "비/눈", "비와요", UIImage(named: "rainy")!, .white)
        case .snow:     return (.snow, .rainy, "눈", "눈와요", UIImage(named: "snow")!, .darkText)
        case .shower:   return (.shower, .rainy, "소나기", "비와요", UIImage(named: "rainy")!, .white)
        }
    }
}

public enum EJKisangStatusCode: String, Decodable {
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

    var message: String {
        switch self {
        case .DB_ERROR:
            return "데이터베이스에서 오류가 발생했습니다."
        case .NODATA_ERROR:
            return "날씨 데이터가 존재하지 않습니다."
        case .HTTP_ERROR:
            return "네트워크 통신 에러"
        case .SERVICETIME_OUT:
            return "시간이 초과되었습니다."
        case .INVALID_REQUEST_PARAMETER_ERROR, .NO_MANDATORY_REQUEST_PARAMETERS_ERROR, .SERVICE_KEY_IS_NOT_REGISTERED_ERROR, .DEADLINE_HAS_EXPIRED_ERROR:
            return "잘못된 요청입니다."
        case .NO_OPENAPI_SERVICE_ERROR, .UNREGISTERED_IP_ERROR,.UNSIGNED_CALL_ERROR:
            return "서버에 에러가 생겼습니다."
        case .SERVICE_ACCESS_DENIED_ERROR:
            return "서비스에 접근할 수 없습니다."
        case .TEMPORARILY_DISABLE_THE_SERVICEKEY_ERROR:
            return "일시적으로 사용할 수 없습니다."
        case .LIMITED_NUMBER_OF_SERVICE_REQUESTS_EXCEEDS_ERROR:
            return "현재 사용자가 너무 많습니다. 나중에 다시 시도해주세요!"
        case .APPLICATION_ERROR, .UNKNOWN_ERROR:
            return "알 수 없는 오류가 발생했습니다."
        case .NORMAL_SERVICE:
            return ""
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
