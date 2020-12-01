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
}

// MARK: - Weather control Delegate
protocol EJWeatherControlDelegate {
    func didRequestWeatherInfo(_ index: Int)
}

final class EJWeatherManager: NSObject {
    
    static let shared = EJWeatherManager()
    
    // MARK: - Properties
    var country: String = ""
    let WeatherClass = EJWeatherMainModel()
    var delegate: EJWeatherControlDelegate?
    
    // MARK: - Publi Methods
    public func generateWeatherCondition(by list: [EJFiveDaysList]) -> EJWeatherMainModel {
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
            WeatherClass.criticCloth = EJClothManager.shared.setClothByCondition(weatherType)
        } else {
            WeatherClass.criticCloth = EJClothManager.shared.setOuterCloth(by: WeatherClass.mainTemp)
        }
        
        WeatherClass.maxCloth = EJClothManager.shared.setTopCloth(by: WeatherClass.maxTemp)
        WeatherClass.minCloth = EJClothManager.shared.setBottomCloth(by: WeatherClass.minTemp)
        WeatherClass.weatherDescription = weatherDescription(WeatherClass.criticCondition)
        
        return WeatherClass
    }
    
    public func generateBackgroundView(by model: EJFiveDaysWeatherModel) -> UIImage {
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
    
    public func weatherDescription(_ condition: WeatherCondition) -> String {
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
        
        if WeatherClass.maxTemp < 15 {
            EJLogger.d("Description : 따뜻하게 입으세요 \(WeatherClass.maxTemp)도")
            description += "desc_add_warm".localized
        } else if WeatherClass.minTemp > 23 {
            EJLogger.d("Description : 더위 조심하세요")
            description += "desc_add_cool".localized
        } else if WeatherClass.maxTemp - WeatherClass.minTemp >= 8 {
            EJLogger.d("Description : 일교차가 큰 날이에요")
            description = description + "desc_add_cross".localized + "\n"
            
            // TODO: 몇 도씨 미만이고, 일교차가 크면 겉옷을 챙기도록 추천!
            let cloth = WeatherClass.criticCloth.localized
            description = description + " \(cloth) " + "desc_add_cloth".localized
        }
        
        return description
    }
    
    // TODO: - 지명 지역화
    public func getValidUnit() -> String {
        if self.country == "South Korea" { return "℃" }
        return "temp".localized
    }
    
    public func getValidTemperature(by temperature:Float) -> Int {
        var temp = Int(temperature)
        
        if !Library.systemLanguage.contains("en") {
            temp = Int(temperature) - 273
        }
        
        return temp
    }
    
    public func compareWeatherCode(_ currentCode:String, _ originalCode: Int) -> Int {
        var resultCode = originalCode
        let codeNumber = currentCode.components(separatedBy: ["S", "K", "Y", "_", "S"]).joined()
        let currentCodeNum = Int(codeNumber)!
        
        if resultCode < currentCodeNum {
            resultCode = currentCodeNum
        }
        
        return resultCode
    }
    
    public func compareKRWeatherCode(_ currentCode: String, _ originalCode: Int) -> Int {
        var resultCode = originalCode
        let codeNumber = currentCode.components(separatedBy: ["S", "K", "Y", "_", "W"]).joined()
        let currentCodeNum = Int(codeNumber)!
        
        if resultCode < currentCodeNum {
            resultCode = currentCodeNum
        }
        
        return resultCode
    }
    
    public func generateKRWeatherCondition(of code: Int) -> WeatherCondition {
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
    
    // desc : 위험한 날씨(호우, 황사, 태풍, 폭염 등) 경보가 있을 경우 그 정보를 리턴한다
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


// MARK: - Kisangchung Methods
var titleColor: UIColor = .white

extension EJWeatherManager {
    public func koreaBackgroundImage(by models: [EJKisangTimeModel]?) -> UIImage {
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
            guard var value = models.first?.weatherCode.value else { return UIImage() }
            models.forEach { model in
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
    
    func generateTodayTimelyWeather(_ models: [EJKisangTimelyModel]?) -> [EJKisangTimelyModel] {
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
    
    public func properSeasonValue(_ date: String, _ min: Int, _ max: Int) -> Int {
        guard let month = EJMonth(rawValue: date.extractMonth()) else { return 0 }
        switch month {
        case .dec, .jan, .feb:       return min
        case .march, .april, .may:   return max
        case .june, .july, .aug:     return max
        case .sep, .oct, .nov:       return min
        }
    }
    
    public func priority(of weathers: [EJKisangTimeModel]?) -> EJWeatherType {
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
    
    public func todayTempInfo(with items: [EJKisangTimeModel]?) -> (date: String, minTemp: Int, maxTemp: Int) {
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
}
