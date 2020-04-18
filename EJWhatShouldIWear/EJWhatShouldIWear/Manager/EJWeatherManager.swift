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

// MARK: - Shared Instance
let WeatherManager = EJWeatherManager.sharedInstance

class EJWeatherManager: NSObject {
    
    static let sharedInstance = EJWeatherManager()
    
    var latitude: Double = 0    //37.51151
    var longitude: Double = 0   //127.0967
    var country: String = ""
    
    let httpClient = EJHTTPClient.init()
    let WeatherClass = WeatherMain()
    var delegate: EJWeatherControlDelegate?
    
    // MARK: - HTTP Request
    func owmFiveDaysWeatherInfo(success: @escaping SuccessHandler,
                                failure: @escaping FailureHandler) {
        let url = owmAPIPath + "forecast?lat=\(latitude)&lon=\(longitude)&apiKey=\(owmAppKey)"
        httpClient.weatherRequest(url: url,
                                  success: success,
                                  failure: failure)
        
    }
    
    func skwpSixDaysWeatherInfo(_ index: Int, success: @escaping (SKSixSixdaysBase?) -> (),
                                failure: @escaping FailureHandler) {
        latitude = 37.51151
        longitude = 127.0967
        let url = skWPSixDaysAPI + "?appKey=\(skPublicAppKey[index])&lat=\(latitude)&lon=\(longitude)"
        httpClient.weatherRequest(url: url,
                                  success: { result in
                                    if let error = result["error"] {
                                        let errorJSON = error as! JSONType
                                        let code = errorJSON["code"] as! String
                                        if code == "8102" {
                                            return
                                        }
                                    } else {
                                        let sixdaysBase = SKSixSixdaysBase(object: result)
                                        success(sixdaysBase)
                                    }
        },
                                  failure: failure)
    }
    
    func skwpThreeDaysWeatherInfo(_ index: Int, success: @escaping (SKThreeThreedays?) -> (),
                                  failure: @escaping FailureHandler) {
        latitude = 37.51151
        longitude = 127.0967
        let url = skWPThreeDaysAPI + "?appKey=\(skPublicAppKey[index])&lat=\(latitude)&lon=\(longitude)"
        httpClient.weatherRequest(url: url,
                                  success: { result in
                                    if let error = result["error"] {
                                        let errorJSON = error as! JSONType
                                        let code = errorJSON["code"] as! String
                                        if code == "8102" {
                                            self.delegate?.didRequestWeatherInfo(index+1)
                                            return
                                        }
                                    } else {
                                        let threedaysBase = SKThreeThreedays(object: result)
                                        success(threedaysBase)
                                    }
        },
                                  failure: failure)
    }
    
    // MARK: - Public Method
    public func callWeatherInfo(_ index: Int,
                                success: @escaping (SKThreeThreedays?, SKSixSixdaysBase?) -> (),
                                failure: @escaping FailureHandler) {
        var threeDaysWeather: SKThreeThreedays?
        var sixDaysWeather: SKSixSixdaysBase?
        var resultError: Error?
        print("=============== Dispatch Group ===== START! ==============")
        
        let dispatchGroup = DispatchGroup()
        let dispatchQueue = DispatchQueue.global()
        
        dispatchGroup.enter()
        dispatchQueue.async {
            self.skwpThreeDaysWeatherInfo(index,
                                          success: { (result) in
                                            threeDaysWeather = result
                                            dispatchGroup.leave()
            }) { (error) in
                resultError = error
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.enter()
        dispatchQueue.async {
            self.skwpSixDaysWeatherInfo(index,
                                        success: { (result) in
                                            sixDaysWeather = result
                                            dispatchGroup.leave()
            }) { (error) in
                resultError = error
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            print("=============== Dispatch Group ===== Done! ==============")
            if let error = resultError {
                failure(error)
            } else {
                success(threeDaysWeather, sixDaysWeather)
            }
        }
    }
    
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
            WeatherClass.criticCloth = setClothByCondition(WeatherClass.criticCondition)
        } else {
            WeatherClass.criticCloth = setOuterCloth(by: WeatherClass.mainTemp)
        }
        
        // 5. MaxCloth, MinCloth 설정
        WeatherClass.maxCloth = setTopCloth(by: WeatherClass.minTemp)
        WeatherClass.minCloth = setBottomCloth(by: WeatherClass.maxTemp)
        
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
            print("Description : 따뜻하게 입으세요 \(WeatherClass.maxTemp)도")
            description += LocalizedString(with: "desc_add_warm")
        } else if WeatherClass.minTemp > 23 {
            print("Description : 더위 조심하세요")
            description += LocalizedString(with: "desc_add_cool")
        } else if WeatherClass.maxTemp - WeatherClass.minTemp >= 8 {
            print("Description : 일교차가 큰 날이에요")
            description = description + LocalizedString(with: "desc_add_cross") + "\n"
            
            // TODO: 몇 도씨 미만이고, 일교차가 크면 겉옷을 챙기도록 추천!
            let cloth = LocalizedString(with: WeatherClass.criticCloth)
            description = description + " \(cloth) " + LocalizedString(with: "desc_add_cloth")
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
    
    public func getClothList(_ minTemp: Int, _ maxTemp: Int) -> [String] {
        var list = [String]()
        
        switch maxTemp {
        case TempRange.temp_28:
            list += Top._28
            if !TempRange.temp_28.contains(minTemp) { fallthrough }
        case TempRange.temp_23_27:
            list += Top._23_27
            if !TempRange.temp_23_27.contains(minTemp) { fallthrough }
        case TempRange.temp_20_22:
            list += Top._20_22
            if !TempRange.temp_20_22.contains(minTemp) { fallthrough }
        case TempRange.temp_17_19:
            list += Top._17_19
            if !TempRange.temp_17_19.contains(minTemp) { fallthrough }
        case TempRange.temp_12_16:
            list += Top._12_16
            if !TempRange.temp_12_16.contains(minTemp) { fallthrough }
        case TempRange.temp_9_11:
            list += Top._9_11
            if !TempRange.temp_9_11.contains(minTemp) { fallthrough }
        case TempRange.temp_5_8:
            list += Top._5_8
            if !TempRange.temp_5_8.contains(minTemp) { fallthrough }
        case TempRange.temp_4:
            list += Top._4
            if !TempRange.temp_4.contains(minTemp) { fallthrough }
        default:
            list = Top._23_27
        }
        
        return list
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
    
    // TODO: - 지명 지역화
    public func getValidUnit() -> String {
        if self.country == "South Korea" {
            return "℃"
        }
        
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
    
    // MARK: Locality
    public func getLocationInfo(of current: CLLocation,
                                success: @escaping (String, String) -> (),
                                failure: @escaping (Error) -> ())
    {
        let geoCoder = CLGeocoder()
        
        geoCoder.reverseGeocodeLocation(current) { (placemark, error) in
            if let error = error {
                failure(error)
            } else {
                var result = ""
                
                if let placemark = placemark, let first = placemark.first, let country = first.country
                {
                    if let firstLocality = first.locality
                    {
                        result += "\(firstLocality)"
                        
                        if let subLocality = first.subLocality
                        {
                            result += " \(subLocality)"
                        }
                    }
                    
                    self.country = country
                    
                    success(country, result)
                }
                else
                {
                    success("", result)
                }
            }
        }
    }
    
    // TODO: - 나라 지역화
    public func isLocationKorea() -> Bool {
//        if country == LocalizedString(with: "korea") {
//            return true
//        }
//        return false
        return true
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
