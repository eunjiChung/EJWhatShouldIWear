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

// MARK: - Type Alias
typealias SuccessHandler = (Any) -> ()
typealias FailureHandler = (Error) -> ()

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
            WeatherClass.criticCloth = setClothByCondition(weatherType)
        } else {
            WeatherClass.criticCloth = setOuterCloth(by: WeatherClass.mainTemp)
        }
        
        WeatherClass.maxCloth = setTopCloth(by: WeatherClass.maxTemp)
        WeatherClass.minCloth = setBottomCloth(by: WeatherClass.minTemp)
        WeatherClass.weatherDescription = weatherDescription()
        
        return WeatherClass
    }

    public func weatherDescription() -> String {
        var description = LocalizedString(with: "desc_tody") + " "
        
        switch WeatherClass.criticCondition {
        case .clear:
            description += LocalizedString(with: "desc_clear")
        case .cloud:
            description += LocalizedString(with: "desc_cloud")
        case .tornado:
            description += LocalizedString(with: "desc_tornado")
        case .ash:
            description = LocalizedString(with: "desc_ash")
        case .squall:
            description += LocalizedString(with: "desc_squall")
        case .thunderstorm:
            description += LocalizedString(with: "desc_thunderstorm")
        case .dust, .haze:
            description += LocalizedString(with: "desc_dust")
        case .snow:
            description += LocalizedString(with: "desc_snow")
        case .rain:
            description += LocalizedString(with: "desc_rain")
        case .drizzle:
            description += LocalizedString(with: "desc_drizzle")
        case .fog:
            description += LocalizedString(with: "desc_fog")
        }
        description += "\n"
        
        if WeatherClass.maxTemp < 15 {
            description += LocalizedString(with: "desc_add_warm")
        } else if WeatherClass.minTemp > 23 {
            description += LocalizedString(with: "desc_add_cool")
        } else if WeatherClass.maxTemp - WeatherClass.minTemp >= 8 {
            description = description + LocalizedString(with: "desc_add_cross") + "\n"
            
            // 추천 로직은 보류...
//            let cloth = LocalizedString(with: WeatherClass.criticCloth)
//            description = description + LocalizedString(with: "desc_add_cloth") + " \(cloth)"
        }
        
        return description
    }
    
    public func setClothByCondition(_ condition:WeatherCondition) -> String {
        var tag: String
        
        switch condition {
        case .tornado, .ash, .dust, .haze:
            tag = MASK
        case .squall, .thunderstorm, .rain, .drizzle:
            tag = UMBRELLA
        case .snow:
            tag = [FUR_GLOVES, FUR_HAT, MUFFLER].randomElement()!
        default:
            tag = BLUE_JEAN_JACKET
        }
        
        return tag
    }
    
    public func setTopCloth(by temp: Int) -> String {
        var cloth = ""
        
        switch temp {
        case TempRange.temp_28:
            cloth = Top._28.randomElement()!
        case TempRange.temp_23_27:
            cloth = Top._23_27.randomElement()!
        case TempRange.temp_20_22:
            cloth = Top._20_22.randomElement()!
        case TempRange.temp_17_19:
            cloth = Top._17_19.randomElement()!
        case TempRange.temp_12_16:
            cloth = Top._12_16.randomElement()!
        case TempRange.temp_9_11:
            cloth = Top._9_11.randomElement()!
        case TempRange.temp_5_8:
            cloth = Top._5_8.randomElement()!
        case TempRange.temp_4:
            cloth = Top._4.randomElement()!
        default:
            cloth = Top._23_27.randomElement()!
        }
        
        return cloth
    }
    
    
    public func setBottomCloth(by temp: Int) -> String {
        var cloth = ""
        
        switch temp {
        case TempRange.temp_28:
            cloth = Bottom._28.randomElement()!
        case TempRange.temp_23_27:
            cloth = Bottom._23_27.randomElement()!
        case TempRange.temp_20_22:
            cloth = Bottom._20_22.randomElement()!
        case TempRange.temp_17_19:
            cloth = Bottom._17_19.randomElement()!
        case TempRange.temp_12_16:
            cloth = Bottom._12_16.randomElement()!
        case TempRange.temp_9_11:
            cloth = Bottom._9_11.randomElement()!
        case TempRange.temp_5_8:
            cloth = Bottom._5_8.randomElement()!
        case TempRange.temp_4:
            cloth = Bottom._4.randomElement()!
        default:
            cloth = Bottom._23_27.randomElement()!
        }
        
        return cloth
    }
    
    public func setOuterCloth(by temp: Int) -> String {
        var cloth = ""
        
        switch temp {
        case TempRange.temp_28:
            cloth = Top._28.randomElement()!
        case TempRange.temp_23_27:
            cloth = Top._23_27.randomElement()!
        case TempRange.temp_20_22:
            cloth = Outer._20_22.randomElement()!
        case TempRange.temp_17_19:
            cloth = Outer._17_19.randomElement()!
        case TempRange.temp_12_16:
            cloth = Outer._12_16.randomElement()!
        case TempRange.temp_9_11:
            cloth = Outer._9_11.randomElement()!
        case TempRange.temp_5_8:
            cloth = Outer._5_8.randomElement()!
        case TempRange.temp_4:
            cloth = Outer._4.randomElement()!
        default:
            cloth = Outer._20_22.randomElement()!
        }
        
        return cloth
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
                            result += " \(subLocality)"
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
