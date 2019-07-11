//
//  EJWeatherManager.swift
//  EJWhatShouldIWear
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 22/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit
import SwiftyJSON

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
    public func weatherCondition(of id:Int) -> String {
        if 200 <= id && id < 600 {
            return LocalizedString(with: "rainy")
        } else if 600 <= id && id < 700{
            return LocalizedString(with: "snowy")
        } else if 700 <= id && id < 800{
            return "Fog"
        } else if id == 800 {
            return LocalizedString(with: "sunny")
        } else if 800 < id {
            return LocalizedString(with: "cloudy")
        }
        return ""
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
    
}
