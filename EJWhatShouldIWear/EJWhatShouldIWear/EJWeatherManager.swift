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

// MARK: - Shared Instance
let WeatherManager = EJWeatherManager.sharedInstance

class EJWeatherManager: NSObject {
    
    static let sharedInstance = EJWeatherManager()
    var latitude: Double = 0    //37.51151
    var longitude: Double = 0   //127.0967
    
    let httpClient = EJHTTPClient.init()
        
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
    public func generateWeatherConditon(by list: [EJFiveDaysList]) {
        
        let weatherList = list.map { return $0.weather?.first }
        let mainList = list.map { $0.main! }
        
        criticalWeather(weatherList)
        
        // 3. 날씨 중에서 크리티컬한 날씨 정보 살펴보기
        // - 비, 눈, 천둥번개, 미세먼지가 있을 경우 첫번째 옷 설정
        // - 없을 경우 다음 온도로 설정
        
        // 4. 제일 높은 온도, 낮은 온도 가져오기
        // - 제일 높은 온도, 낮은 온도에 맞춰서 옷 설정 (setTodayStyle 수정)
        // - description 셋팅
        
        var maxTemp = 100
        var minTemp = -100
    }

    public func weatherCondition(of id:Int) -> String {
        switch id {
        case 200 ..< 600:
            return LocalizedString(with: "rainy")
        case 600 ..< 700:
            return LocalizedString(with: "snowy")
        case 700 ..< 800:
            return LocalizedString(with: "rainy")
        case 800:
            return LocalizedString(with: "sunny")
        case 801... :
            return LocalizedString(with: "cloudy")
        default:
            return ""
        }
    }
    
    public func setTodayStyle(by temp:Int, id:Int) -> [String] {
        var images = [String]()
        var firstTag, secondTag, thirdTag: String
        
        
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
        
        if 200 <= id && id < 600 {
            firstTag = "big_umbrella_icon"
        }
        
        images = [firstTag, secondTag, thirdTag]
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
    private func criticalWeather(_ list: [EJFiveDaysWeather?]) {
        var criticalID = 1000
        
        for item in list {
            if let item = item, let id = item.id {
                
                // 그냥 흐리거나, 그냥 맑거나
                if id >= 800 { return }
                
                // Atmosphere
                if id >= 700 {
                    if id == 781 || id == 762 {
                        criticalID = id
                        return
                    }
                }
                
                // Snow
                if id >= 600 {
                    criticalID = id
                }
                
                // Rain
                if id >= 500 {
                    
                }
                
                // drizzle
                if id >= 300 {
                    
                }
                
                // thunderStorm
                if id >= 200 {
                    
                }
            }
        }
    }
    
}
