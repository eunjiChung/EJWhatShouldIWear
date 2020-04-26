//
//  EJWeatherManager.swift
//  EJWhatShouldIWear
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 22/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import SwiftyJSON
import CoreLocation
import Crashlytics

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

class EJWeatherManager: NSObject {
    
    static let shared = EJWeatherManager()
    
    // MARK: - Properties
    var country: String = ""
    let httpClient = EJHTTPClient.init()
    let WeatherClass = WeatherMain()
    var delegate: EJWeatherControlDelegate?
    
    // MARK: - Publi Methods
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
            let night = ["night1", "night2"]
            let pic = night.randomElement()!
            return UIImage(named: pic)!
        } else if time >= 18 {
            let sunsets = ["sunset1", "sunset2", "sunset3", "sunset4"]
            let pic = sunsets.randomElement()!
            return UIImage(named: pic)!
        } else if time >= 6 {
            var name = ""
            let weather = self.generateWeatherCondition(by: list)
            let condition = weather.criticCondition
            
            switch condition {
            case .clear:
                name = "clear"
            case .cloud:
                name = "cloud"
            case .drizzle, .rain, .squall:
                name = "rainy"
            case .tornado, .thunderstorm:
                name = "storm"
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
    
    public func generateKoreaBackgroundView(by model: SKThreeThreedays?) -> UIImage {
        let date = Date()
        // TODO: 현재 한국시간 기준...TimeZone 설정해야함
        let time = (Int(date.todayHourString())! + 9) % 24
        
        if time >= 20 || time < 6{
            let night = ["night1", "night2"]
            let pic = night.randomElement()!
            return UIImage(named: pic)!
        } else if time >= 18 {
            let sunsets = ["sunset1", "sunset2", "sunset3", "sunset4"]
            let pic = sunsets.randomElement()!
            return UIImage(named: pic)!
        } else if time >= 6 {
            if let model = model, let threeWeather = model.weather, let fcst3days = threeWeather.forecast3days {
                if let fcst = fcst3days.first, let fcst3hour = fcst.fcst3hour {
                    if let sky = fcst3hour.sky, let timeRelease = fcst.timeRelease {
                        var time = 4
                        let currentHour = timeRelease.onlyKRTime()
                        let list = sky.dictionaryRepresentation()
                        var originalCode = 0
                        var count = 0
                        
                        repeat {
                            let code = list["code\(time)hour"] as! String
                            originalCode = compareWeatherCode(code, originalCode)
                            
                            time += 3
                            count += 1
                        } while currentHour + time < 24
                        
                        let weatherCondition = generateKRWeatherCondition(of: originalCode)
                        var name = "background"
                        
                        switch weatherCondition {
                        case .clear:
                            name = "clear"
                        case .cloud:
                            name = "cloud"
                        case .drizzle, .rain, .squall:
                            name = "rainy"
                        case .tornado, .thunderstorm:
                            name = "storm"
                        case .ash:
                            name = "ash"
                        case .snow:
                            name = "snow"
                        case .haze, .fog, .dust:
                            name = "dust"
                        }
                        
                        return UIImage(named: name)!
                    }
                }
            }
        }
        
        return UIImage(named: "background")!
    }
    
    public func generateKRBackgroundView(by model: [EJThreedaysForecastModel]) -> UIImage {
        let time = (Int(Date().todayHourString())! + 9) % 24
        
        if time >= 20 || time < 6 {
            let night = ["night1", "night2"]
            let pic = night.randomElement()!
            return UIImage(named: pic)!
        } else if time >= 18 {
            let sunsets = ["sunset1", "sunset2", "sunset3", "sunset4"]
            let pic = sunsets.randomElement()!
            return UIImage(named: pic)!
        } else if time >= 6 {
            if let fcst = model.first {
                let fcst3hour = fcst.fcst3hour
                let sky = fcst3hour.sky
                let timeRelease = fcst.timeRelease
                var time = 4
                let currentHour = timeRelease.onlyKRTime()
                //  TODO: - 새로운 모델에 맞게 정리!!
                let list = sky.dictionaryRepresentation()
                var originalCode = 0
                var count = 0
                
                repeat {
                    // TODO: - Forced casting 주의!
                    let code = list["code\(time)hour"]!
                    originalCode = compareWeatherCode(code, originalCode)
                    
                    time += 3
                    count += 1
                } while currentHour + time < 24
                
                let weatherCondition = generateKRWeatherCondition(of: originalCode)
                var name = "background"
                
                switch weatherCondition {
                case .clear:
                    name = "clear"
                case .cloud:
                    name = "cloud"
                case .drizzle, .rain, .squall:
                    name = "rainy"
                case .tornado, .thunderstorm:
                    name = "storm"
                case .ash:
                    name = "ash"
                case .snow:
                    name = "snow"
                case .haze, .fog, .dust:
                    name = "dust"
                }
                return UIImage(named: name)!
            }
        }
        return UIImage(named: "background")!
    }
    
    public func generateNewWeatherConditionKR(_ list: EJThreedaysFcst3hourModel, _ timeRelease: String) -> WeatherMain {
        let sky = list.sky
        let temp = list.temperature
        
        var totalTemp:Float = 0
        var time = 4
        let currentHour = timeRelease.onlyKRTime()
        let skyList = sky.dictionaryRepresentation()
        let tempList = temp.dictionaryRepresentation()
        var originalCode = 0
        var count = 0

        var minTemp = 100
        var maxTemp = -100

        repeat {
            // 1-1. sky를 돌면서 critic weather가 있나 보기
            let code = skyList["code\(time)hour"] as! String
            originalCode = compareWeatherCode(code, originalCode)

            // 1-2. temperature를 돌면서 오늘에 해당하는 기온 합치기
            let fcstTempString = tempList["temp\(time)hour"] as! String
            let fcstTemp = Float(fcstTempString)!
            totalTemp += fcstTemp

            // 1-3. temperature를 돌면서 오늘의 최저, 최고기온 발견하기
            if Int(fcstTemp) < minTemp {
                minTemp = Int(fcstTemp)
            }
            if Int(fcstTemp) > maxTemp {
                maxTemp = Int(fcstTemp)
            }

            // 1-2-1. 오늘 8시 이후에는 다음날 날씨 표시하기
            // TODO: 이거 문제될 것 같은데...공지해야될듯
            time += 3
            count += 1
        } while currentHour + time < 24

        // 2. WeatherClass의 Critic Weather 설정
        WeatherClass.criticCondition = generateKRWeatherCondition(of: originalCode)

        // 3. Average Temp 설정
        let averageTemp = totalTemp / Float(count)
        WeatherClass.mainTemp = getValidKRTemperature(by: averageTemp)
        WeatherClass.maxTemp = Int(maxTemp)
        WeatherClass.minTemp = Int(minTemp)

        // 4. Weather가 clear나 cloud일때와 아닐때 구분
        if WeatherClass.criticCondition != .clear && WeatherClass.criticCondition != .cloud {
            WeatherClass.criticCloth = EJClothManager.shared.setClothByCondition(WeatherClass.criticCondition)
        } else {
            WeatherClass.criticCloth = EJClothManager.shared.setOuterCloth(by: WeatherClass.mainTemp)
        }

        // 5. MaxCloth, MinCloth 설정
        WeatherClass.maxCloth = EJClothManager.shared.setTopCloth(by: WeatherClass.minTemp)
        WeatherClass.minCloth = EJClothManager.shared.setBottomCloth(by: WeatherClass.maxTemp)

        // 6. WeatherDescription 설정
        WeatherClass.weatherDescription = weatherDescription(WeatherClass.criticCondition)
        
        return WeatherClass
    }
    
    // 한국의 날씨 정보 받아오기
    // TODO: - 특보 유무, 태풍 유무 받아오기...
    public func generateWeatherConditionKR(_ list: SKThreeFcst3hour, _ timeRelease: String) -> WeatherMain {
        guard let sky = list.sky, let temp = list.temperature else { return WeatherClass }
        
        var totalTemp:Float = 0
        var time = 4
        let currentHour = timeRelease.onlyKRTime()
        let skyList = sky.dictionaryRepresentation()
        let tempList = temp.dictionaryRepresentation()
        var originalCode = 0
        var count = 0
        
        var minTemp = 100
        var maxTemp = -100
        
        repeat {
            // 1-1. sky를 돌면서 critic weather가 있나 보기
            let code = skyList["code\(time)hour"] as! String
            originalCode = compareWeatherCode(code, originalCode)
            
            // 1-2. temperature를 돌면서 오늘에 해당하는 기온 합치기
            let fcstTempString = tempList["temp\(time)hour"] as! String
            let fcstTemp = Float(fcstTempString)!
            totalTemp += fcstTemp
            
            // 1-3. temperature를 돌면서 오늘의 최저, 최고기온 발견하기
            if Int(fcstTemp) < minTemp {
                minTemp = Int(fcstTemp)
            }
            if Int(fcstTemp) > maxTemp {
                maxTemp = Int(fcstTemp)
            }
            
            // 1-2-1. 오늘 8시 이후에는 다음날 날씨 표시하기
            // TODO: 이거 문제될 것 같은데...공지해야될듯
            time += 3
            count += 1
        } while currentHour + time < 24
        
        // 2. WeatherClass의 Critic Weather 설정
        WeatherClass.criticCondition = generateKRWeatherCondition(of: originalCode)
        
        // 3. Average Temp 설정
        let averageTemp = totalTemp / Float(count)
        WeatherClass.mainTemp = getValidKRTemperature(by: averageTemp)
        WeatherClass.maxTemp = Int(maxTemp)
        WeatherClass.minTemp = Int(minTemp)
        
        // 4. Weather가 clear나 cloud일때와 아닐때 구분
        if WeatherClass.criticCondition != .clear && WeatherClass.criticCondition != .cloud {
            WeatherClass.criticCloth = EJClothManager.shared.setClothByCondition(WeatherClass.criticCondition)
        } else {
            WeatherClass.criticCloth = EJClothManager.shared.setOuterCloth(by: WeatherClass.mainTemp)
        }
        
        // 5. MaxCloth, MinCloth 설정
        WeatherClass.maxCloth = EJClothManager.shared.setTopCloth(by: WeatherClass.minTemp)
        WeatherClass.minCloth = EJClothManager.shared.setBottomCloth(by: WeatherClass.maxTemp)
        
        // 6. WeatherDescription 설정
        WeatherClass.weatherDescription = weatherDescription(WeatherClass.criticCondition)
        
        return WeatherClass
    }
    
    public func weatherDescription(_ condition: WeatherCondition) -> String {
        var description = LocalizedString(with: "desc_tody") + " "
        
        switch condition {
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
            EJLogger.d("Description : 따뜻하게 입으세요 \(WeatherClass.maxTemp)도")
            description += LocalizedString(with: "desc_add_warm")
        } else if WeatherClass.minTemp > 23 {
            EJLogger.d("Description : 더위 조심하세요")
            description += LocalizedString(with: "desc_add_cool")
        } else if WeatherClass.maxTemp - WeatherClass.minTemp >= 8 {
            EJLogger.d("Description : 일교차가 큰 날이에요")
            description = description + LocalizedString(with: "desc_add_cross") + "\n"
            
            // TODO: 몇 도씨 미만이고, 일교차가 크면 겉옷을 챙기도록 추천!
            let cloth = LocalizedString(with: WeatherClass.criticCloth)
            description = description + " \(cloth) " + LocalizedString(with: "desc_add_cloth")
        }
        
        return description
    }
    
    // TODO: - 지명 지역화
    public func getValidUnit() -> String {
        if self.country == "South Korea" { return "℃" }
        return LocalizedString(with: "temp")
    }
    
    public func getValidTemperature(by temperature:Float) -> Int {
        
        // Non fatal Error
        let errorInfo = [
            NSLocalizedDescriptionKey : "Temperature",
            "temperature" : "\(temperature)"
        ]
        let errorLog = NSError.init(domain: "GetValidTemperature", code: -1001, userInfo: errorInfo)
        Crashlytics.sharedInstance().recordError(errorLog)
        
        var temp = Int(temperature)
        
        if !Library.systemLanguage.contains("en") {
            temp = Int(temperature) - 273
        }
        
        return temp
    }
    
    public func getValidKRTemperature(by temperature:Float) -> Int {
        
        // Non fatal Error
        let errorInfo = [
            NSLocalizedDescriptionKey : "Temperature",
            "temperature" : "\(temperature)"
        ]
        let errorLog = NSError.init(domain: "GetValidTemperature", code: -1001, userInfo: errorInfo)
        Crashlytics.sharedInstance().recordError(errorLog)
        
        var temp = Int(temperature)
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
