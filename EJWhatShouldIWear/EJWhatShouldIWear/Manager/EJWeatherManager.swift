//
//  EJWeatherManager.swift
//  EJWhatShouldIWear
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 22/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit
import FirebaseCrashlytics

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

    var desc: String {
        switch self {
        case .clear:                            return "sunny".localized
        case .rain, .haze, .drizzle, .squall:   return "rainy".localized
        case .cloud, .fog:                      return "cloudy".localized
        case .snow:                             return "snowy".localized
        default:                                return ""
        }
    }
}

final class EJWeatherManager {
    
    // MARK: - Properties
    var country: String = ""
    static var weather = EJWeatherMainModel()
    
    // MARK: - Publi Methods
    static func generateWeatherCondition(by list: [EJFiveDaysList]) -> EJWeatherMainModel {
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
        
        weather.criticCondition = weatherType
        
        let averageTemp = totalTemp / Float(list.count)
        weather.mainTemp = getValidTemperature(by: averageTemp)
        weather.minTemp = getValidTemperature(by: minTemp)
        weather.maxTemp = getValidTemperature(by: maxTemp)
        
        if weatherType != .clear && weatherType != .cloud {
            weather.criticCloth = EJClothManager.shared.setClothByCondition(weatherType)
        } else {
            weather.criticCloth = EJClothManager.shared.setCloth(by: weather.mainTemp, category: Outer())
        }
        
        weather.maxCloth = EJClothManager.shared.setCloth(by: weather.maxTemp, category: Top())
        weather.minCloth = EJClothManager.shared.setCloth(by: weather.minTemp, category: Bottom())
        weather.weatherDescription = weatherDescription(weather.criticCondition)
        
        return weather
    }
    
    static func generateBackgroundView(by model: EJFiveDaysWeatherModel) -> UIImage {
        guard let city = model.city, let timezone = city.timezone, let list = model.list else { return UIImage(named: "background")! }
        
        let date = Date()
        let dateString = date.generateDate()
        let timeZoneDate = dateString.toDate(timezone)
        let time = timeZoneDate.currentHourInt()
        
        if time >= 20 || time < 6 {
            return UIImage(named: "night")!
        } else if time >= 18 {
            return UIImage(named: "sunset")!
        } else if time >= 6 {
            var name = ""
            let weather = self.generateWeatherCondition(by: list)
            let condition = weather.criticCondition
            
            switch condition {
            case .clear:
                name = "clear"
            case .cloud:
                name = "cloudy"
            case .drizzle, .rain, .squall:
                name = "rainy"
            case .tornado, .thunderstorm:
                name = "rainy"
            case .ash:
                name = "ash"
            case .snow:
                name = "snow"
            case .haze, .fog, .dust:
                name = "dust"
            }
            
            return UIImage(named: name)!
        }
        
        return UIImage(named: "background")!
    }
    
    static func weatherDescription(_ condition: WeatherCondition) -> String {
        var description = "desc_tody".localized + " "
        
        switch condition {
        case .clear:
            description += "desc_clear".localized
        case .cloud:
            description += "desc_cloud".localized
        case .tornado:
            description += "desc_tornado".localized
        case .ash:
            description = "desc_ash".localized
        case .squall:
            description += "desc_squall".localized
        case .thunderstorm:
            description += "desc_thunderstorm".localized
        case .dust, .haze:
            description += "desc_dust".localized
        case .snow:
            description += "desc_snow".localized
        case .rain:
            description += "desc_rain".localized
        case .drizzle:
            description += "desc_drizzle".localized
        case .fog:
            description += "desc_fog".localized
        }
        description += "\n"
        
        if weather.maxTemp < 15 {
            EJLogger.d("Description : 따뜻하게 입으세요 \(weather.maxTemp)도")
            description += "desc_add_warm".localized
        } else if weather.minTemp > 23 {
            EJLogger.d("Description : 더위 조심하세요")
            description += "desc_add_cool".localized
        } else if weather.maxTemp - weather.minTemp >= 8 {
            EJLogger.d("Description : 일교차가 큰 날이에요")
            description = description + "desc_add_cross".localized + "\n"
            
            // TODO: 몇 도씨 미만이고, 일교차가 크면 겉옷을 챙기도록 추천!
            let cloth = weather.criticCloth.localized
            description = description + " \(cloth) " + "desc_add_cloth".localized
        }
        
        return description
    }
    
    // TODO: - 지명 지역화
    static var unit: String { return "temp".localized }
    
    static func getValidTemperature(by temperature:Float) -> Int {
        var temp = Int(temperature)
        
        if !Library.systemLanguage.contains("en") {
            temp = Int(temperature) - 273
        }
        
        return temp
    }
    
    static func compareWeatherCode(_ currentCode:String, _ originalCode: Int) -> Int {
        var resultCode = originalCode
        let codeNumber = currentCode.components(separatedBy: ["S", "K", "Y", "_", "S"]).joined()
        let currentCodeNum = Int(codeNumber)!
        
        if resultCode < currentCodeNum {
            resultCode = currentCodeNum
        }
        
        return resultCode
    }
    
    static func compareKRWeatherCode(_ currentCode: String, _ originalCode: Int) -> Int {
        var resultCode = originalCode
        let codeNumber = currentCode.components(separatedBy: ["S", "K", "Y", "_", "W"]).joined()
        let currentCodeNum = Int(codeNumber)!
        
        if resultCode < currentCodeNum {
            resultCode = currentCodeNum
        }
        
        return resultCode
    }
    
    static func generateKRWeatherCondition(of code: Int) -> WeatherCondition {
        var type: WeatherCondition
        
        switch code {
        case 1:
            type = .clear
        case 2, 3, 7:
            type = .cloud
        case 4, 8:
            type = .rain
        case 5, 6, 9, 10:
            type = .snow
        case 11, 12, 13, 14:
            type = .thunderstorm
        default:
            type = .clear
        }
        
        return type
    }
    
    // MARK: - Private Method
    static func weatherTemp(of originMaxTemp: Float, _ originMinTemp: Float, _ item: EJFiveDaysList) -> [String:Float] {
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
    
    // desc : 위험한 날씨(호우, 황사, 태풍, 폭염 등) 경보가 있을 경우 그 정보를 리턴한다
    static func criticalWeather(_ originType: WeatherCondition, _ item: EJFiveDaysList) -> WeatherCondition {
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
    
    static func weatherCondition(of id: Int) -> WeatherCondition {
        
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
    
    static func atmosphereCondition(of id: Int) -> WeatherCondition {
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


// MARK: - Kisangchung Methods
var titleColor: UIColor = .white

extension EJWeatherManager {
    static func koreaBackgroundImage(by models: [EJKisangTimeModel]?) -> UIImage {
        guard let models = models else { return UIImage() }
        let currentHour = Calendar.current.component(.hour, from: Date())
        switch currentHour {
        case 20..., ..<6:
            titleColor = .white
            return UIImage(named: "night")!
        case 18...20:
            titleColor = #colorLiteral(red: 0.167342931, green: 0.1078223065, blue: 0.04166871309, alpha: 0.9996261597)
            return UIImage(named: "sunset")!
        case 6...18:
            guard var value = models.first?.weatherCode.value, let baseDate = models.first?.fcstDate else { return UIImage() }
            for model in models where baseDate == model.fcstDate {
                if value.type.rawValue < model.weatherCode.value.type.rawValue {
                    value = model.weatherCode.value
                }
            }
            titleColor = value.fontColor
            return value.image
        default:
            return UIImage(named: "background")!
        }
    }
    
    static func generateTodayTimelyWeather(_ models: [EJKisangTimelyModel]?) -> [EJKisangTimelyModel] {
        guard let models = models else { return [] }
        
        var todayModels: [EJKisangTimelyModel] = []
        var fcstTime = models.first?.fcstTime ?? ""
        
        var index = 1
        for model in models {
            if model.fcstTime == fcstTime {
                todayModels.append(model)
            } else {
                fcstTime = model.fcstTime
                
                if index == 8 { break }
                index += 1
            }
        }
        
        return todayModels
    }
    
    static func properSeasonValue(_ date: String, _ min: Int, _ max: Int) -> Int {
        guard let month = EJMonth(rawValue: date.extractMonth()) else { return 0 }
        switch month {
        case .dec, .jan, .feb:       return min
        case .march, .april, .may:   return max
        case .june, .july, .aug:     return max
        case .sep, .oct, .nov:       return min
        }
    }
    
    static func priority(of weathers: [EJKisangTimeModel]?) -> EJWeatherType {
        guard let items = weathers else { return .no }
        guard let baseDate = items.first?.fcstDate else { return .no }
        
        var originType: EJWeatherType = .no
        for model in items where baseDate == model.fcstDate {
            if originType.rawValue < model.weatherCode.value.type.rawValue {
                originType = model.weatherCode.value.type
            }
        }
        return originType
    }
    
    static func todayTempInfo(with items: [EJKisangTimeModel]?) -> (date: String, minTemp: Int, maxTemp: Int) {
        guard let items = items else { return ("", 0, 0) }
        guard let baseDate = items.first?.fcstDate else { return ("", 0, 0) }
        
        var minTemp = 100
        var maxTemp = -100
        for model in items where baseDate == model.fcstDate {
            if model.fcstTime != "0000", model.fcstTime != "0300" {
                minTemp = min(minTemp, model.temperature)
                maxTemp = max(maxTemp, model.temperature)
            }
        }
        
        return (baseDate, minTemp, maxTemp)
    }

    static func generateAverageTemp(_ models: [EJKisangTimeModel]?) -> EJWeatherLevel {
        guard let models = models else { return ._12_16 }
        let date = models.first?.fcstDate

        var totalTemp = 0
        var count = 0
        for model in models where model.fcstDate == date {
            totalTemp += model.temperature
            count += 1
        }
        let temp = totalTemp / count
        return temp.level
    }
}
