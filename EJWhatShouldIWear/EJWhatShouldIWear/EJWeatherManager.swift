//
//  EJWeatherManager.swift
//  EJWhatShouldIWear
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 22/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreLocation

// MARK: - Weather Condition
enum WeatherCondition: Int {
    case tornado = 0
    case squall = 1
    case ash = 2
    case thunderstorm = 3
    case snow = 4
    case rain = 5
    case drizzle = 6
    case dust = 7
    case haze = 8
    case fog = 9
    case cloud = 10
    case clear = 11
}

// MARK: - Type Alias
typealias SuccessHandler = (Any) -> ()
typealias FailureHandler = (Error) -> ()

// MARK: - Shared Instance
let WeatherManager = EJWeatherManager.sharedInstance

class EJWeatherManager: NSObject {
    
    static let sharedInstance = EJWeatherManager()
    var latitude: Double = 0    //37.51151
    var longitude: Double = 0   //127.0967
    
    let httpClient = EJHTTPClient.init()
    let WeatherClass = WeatherMain()
        
    // MARK: - HTTP Request
    func CurrentWeatherInfo(success: @escaping SuccessHandler,
                            failure: @escaping FailureHandler) {
        print("Locality : \(latitude), \(longitude)")
        
        httpClient.weatherRequest(lat:latitude,
                                  lon:longitude,
                                  to: "weather",
                                  success: success,
                                  failure: failure)
    }
    
    func FiveDaysWeatherInfo(success: @escaping SuccessHandler,
                             failure: @escaping FailureHandler) {
        print("Locality : \(latitude), \(longitude)")
        
        httpClient.weatherRequest(lat: latitude,
                                  lon: longitude,
                                  to: "forecast",
                                  success: success,
                                  failure: failure)
        
    }
    
    // MARK: - Public Method
    public func generateWeatherCondition(by list: [EJFiveDaysList]) -> WeatherMain {
        
        var maxTemp:Float = -1000
        var minTemp:Float = 1000
        var totalTemp:Float = 0
        var weatherType: WeatherCondition = .clear
        
        for item in list {
            weatherType = criticalWeather(weatherType, item)
            let tempDictionary = weatherTemp(of: maxTemp, minTemp, item)
            minTemp = tempDictionary["min"]!
            maxTemp = tempDictionary["max"]!
            totalTemp += tempDictionary["total"]!
        }
        
        WeatherClass.criticCondition = weatherType
        
        let averageTemp = totalTemp / Float(list.count)
        WeatherClass.mainTemp = getValidTemperature(by: averageTemp)
        WeatherClass.minTemp = getValidTemperature(by: minTemp)
        WeatherClass.maxTemp = getValidTemperature(by: maxTemp)
        
        if weatherType != .clear && weatherType != .cloud {
            WeatherClass.firstCloth = setClothByCondition(weatherType)
        } else {
            WeatherClass.firstCloth = setClothByTemp(WeatherClass.mainTemp)
        }
        
        WeatherClass.secondCloth = setClothByTemp(WeatherClass.maxTemp)
        WeatherClass.thirdCloth = setClothByTemp(WeatherClass.minTemp)
        WeatherClass.weatherDescription = weatherDescription()
        
        return WeatherClass
    }

    public func weatherDescription() -> String {
        var description = "오늘 "
        
        switch WeatherClass.criticCondition {
        case .clear:
            description += "날씨가 맑아요!"
        case .cloud:
            description += "날이 흐려요.."
        case .tornado:
            description += "토네이도! 위험!"
        case .ash:
            description = "화산재 조심하세요!"
        case .squall:
            description += "스콜 조심하세요!"
        case .thunderstorm:
            description += "천둥번개에 유의하세요!"
        case .dust, .haze:
            description += "공기가 안좋아요"
        case .snow:
            description += "눈이 와요"
        case .rain:
            description += "비가 와요"
        case .drizzle:
            description += "가벼운 비가 와요"
        case .fog:
            description += "안개가 꼈어요"
        }
        description += "\n"
        
        if WeatherClass.maxTemp < 15 {
            description += "따뜻하게 입으세요!"
        } else if WeatherClass.minTemp > 23 {
            description += "더위 조심하세요!"
        } else if WeatherClass.maxTemp - WeatherClass.minTemp >= 8 {
            description += "일교차가 커요.\n"
            let cloth = LocalizedString(with: WeatherClass.secondCloth)
            description += "꼭 \(cloth)를 챙기세요"
        }
        
        return description
    }
    
    public func setClothByCondition(_ condition:WeatherCondition) -> String {
        var tag: String
        
        switch condition {
        case .tornado, .ash, .dust, .haze:
            tag = "big_mask_icon"
        case .squall, .thunderstorm, .rain, .drizzle:
            tag = "big_umbrella_icon"
        case .snow:
            tag = ["big_fur_gloves_icon", "big_fur_hat_icon", "big_muffler_icon"].randomElement()!
        default:
            tag = "big_blue_jean_jacket_icon"
        }
        
        return tag
    }
    
    public func setClothByTemp() -> [String:String] {
        var images = [String: String]()
        var top, bottom, third, outer: String
        
        
        // 미국 화씨를 계산 안 했다...
        switch temp {
        case 28...:
            top = "big_sleeveless_shirt_icon"
            bottom = "big_hot_pants_icon"
            third = "big_short_sleeved_t_shirt_icon"
            outer = ""
        case 23...27:
            top = "big_short_sleeved_t_shirt_icon"
            bottom = "big_cotton_pants_icon"
            third = "big_one_piece_icon"
            outer = ""
        case 20...22:
            top = "big_shirt_icon"
            bottom = "big_blue_jeans_icon"
            third = "big_blouse_icon"
            outer = ""
        case 17...19:
            top = "big_blouse_icon"
            bottom = "big_blue_jeans_icon"
            third = "big_blue_jean_jacket_icon"
            outer = "big_cardigan_icon"
        case 12...16:
            top = "big_sweatshirt_icon"
            bottom = "big_cotton_pants_icon"
            third = ""
            outer = "big_checked_shirt_icon"
        case 9...11:
            top = "big_jacket_icon"
            bottom = "big_slacks_icon"
            third = ""
            outer = "big_trench_coat_icon"
        case 5...8:
            top = "big_knitwear_icon"
            bottom = "big_long_skirt_icon"
            third = ""
            outer = "big_coat_icon"
        case ...4:
            top = "big_sweatshirt_icon"
            bottom = "big_cotton_pants_icon"
            third = "big_padding_vest_icon"
            outer = "big_padding_icon"
        default:
            top = "big_blouse_icon"
            bottom = "big_cardigan_icon"
            third = ""
            outer = "big_one_piece_icon"
        }
        
        images = ["top":top, "bottom":bottom, "third":third, "outer":outer]
        return images
    }
    
    public func getValidTemperature(by temperature:Float) -> Int {
        var temp = Int(temperature)
        
        if !Library.systemLanguage.contains("en") {
            temp = Int(temperature) - 273
        }
        
        return temp
    }
    
    
    // MARK: Locality
    public func getLocationInfo(of current: CLLocation,
                                 success: @escaping (String) -> (),
                                 failure: @escaping (Error) -> ())
    {
        let geoCoder = CLGeocoder()
        
        geoCoder.reverseGeocodeLocation(current) { (placemark, error) in
            if let error = error {
                failure(error)
            } else {
                var result = ""
                
                if let placemark = placemark, let first = placemark.first
                {
                    if let firstLocality = first.locality
                    {
                        result += "\(firstLocality)"
                        
                        if let subLocality = first.subLocality
                        {
                            result += "\(subLocality)"
                        }
                    }
                    success(result)
                }
                else
                {
                    success(result)
                }
            }
        }
    }
    
    // MARK: - Private Method
    private func weatherTemp(of originMaxTemp: Float, _ originMinTemp: Float, _ item: EJFiveDaysList) -> [String:Float] {
        var maxTemp: Float = originMaxTemp
        var minTemp: Float = originMinTemp
        var totalTemp: Float = 0.0
        
        if let main = item.main, let itemMaxTemp = main.tempMax, let itemMinTemp = main.tempMin, let temp = main.temp {
            maxTemp = max(itemMaxTemp, maxTemp)
            minTemp = min(itemMinTemp, minTemp)
            totalTemp = temp
        }
        
        return ["min": minTemp, "max": maxTemp, "total": totalTemp]
    }
    
    private func criticalWeather(_ originType: WeatherCondition, _ item: EJFiveDaysList) -> WeatherCondition {
        var resultType:WeatherCondition = originType
        
        if let weather = item.weather, let id = weather.first?.id
        {
            let currentItemType:WeatherCondition = weatherCondition(of: id)
            
            if currentItemType.rawValue < originType.rawValue {
                resultType = currentItemType
            }
        }
        
        return resultType
    }
    
    private func weatherCondition(of id: Int) -> WeatherCondition {
        
        let result = id / 100
        var type: WeatherCondition
        
        switch result {
        case 2:
            type = .thunderstorm
        case 3:
            type = .drizzle
        case 5:
            type = .rain
        case 6:
            type = .snow
        case 7:
            type = atmosphereCondition(of: id)
        case 8:
            if id == 800 {
                type = .clear
            } else {
                type = .cloud
            }
        default:
            type = .clear
        }
        
        return type
    }
    
    private func atmosphereCondition(of id: Int) -> WeatherCondition {
        switch id {
        case 701, 741:
            return .fog
        case 711, 721:
            return .haze
        case 731, 751, 761:
            return .dust
        case 762:
            return .ash
        case 771:
            return .squall
        case 781:
            return .tornado
        default:
            return .fog
        }
    }
    
}
