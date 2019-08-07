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
        
        let averageTemp = totalTemp / Float(list.count)
        WeatherClass.mainTemp = getValidTemperature(by: averageTemp)
        WeatherClass.criticCondition = weatherType
        print("Critic Weather:", weatherType)
        WeatherClass.minTemp = getValidTemperature(by: minTemp)
        print("Min Temp:", WeatherClass.minTemp)
        WeatherClass.maxTemp = getValidTemperature(by: maxTemp)
        print("Max Temp:", WeatherClass.maxTemp)
        
        // 3. 날씨 중에서 크리티컬한 날씨 정보 살펴보기
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
        var description = "오늘은 "
        
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
        case .squall, .thunderstorm, .snow, .rain, .drizzle:
            tag = "big_umbrella_icon"
        case .fog:
            tag = "big_cardigan_icon"
        default:
            tag = "big_blue_jean_jacket_icon"
        }
        
        return tag
    }
    
    public func setClothByTemp(_ temp:Int) -> String {
        var images = [String]()
        var firstTag, secondTag, thirdTag: String
        
        // 미국 화씨를 계산 안 했다...
        switch temp {
        case 28...:
            firstTag = "big_sleeveless_shirt_icon"
            secondTag = "big_short_sleeved_t_shirt_icon"
            thirdTag = "big_hot_pants_icon"
        case 23...27:
            firstTag = "big_one_piece_icon"
            secondTag = "big_short_sleeved_t_shirt_icon"
            thirdTag = "big_cotton_pants_icon"
        case 20...22:
            firstTag = "big_shirt_icon"
            secondTag = "big_blouse_icon"
            thirdTag = "big_blue_jeans_icon"
        case 17...19:
            firstTag = "big_blue_jean_jacket_icon"
            secondTag = "big_cardigan_icon"
            thirdTag = "big_blue_jeans_icon"
        case 12...16:
            firstTag = "big_sweatshirt_icon"
            secondTag = "big_checked_shirt_icon"
            thirdTag = "big_cotton_pants_icon"
        case 9...11:
            firstTag = "big_trench_coat_icon"
            secondTag = "big_jacket_icon"
            thirdTag = "big_slacks_icon"
        case 5...8:
            firstTag = "big_coat_icon"
            secondTag = "big_knitwear_icon"
            thirdTag = "big_long_skirt_icon"
        case ...4:
            firstTag = "big_muffler_icon"
            secondTag = "big_padding_icon"
            thirdTag = "big_fur_gloves_icon"
        default:
            firstTag = "big_blouse_icon"
            secondTag = "big_cardigan_icon"
            thirdTag = "big_one_piece_icon"
        }
        
        images = [firstTag, secondTag, thirdTag]
        return images.randomElement()!
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
