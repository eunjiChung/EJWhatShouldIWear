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
    
    public func setTodayStyle(by temp:Int, id:Int) -> [UIImage:String] {
        var images = [UIImage:String]()
        var first, second, third: UIImage
        var firstTag, secondTag, thirdTag: String
        
        
        switch temp {
        case 28...:
            first = UIImage.init(named: "big_sleeveless_shirt_icon")!
            firstTag = LocalizedString(with: "sleeveless_shirt")
            second = UIImage.init(named: "big_short_sleeved_t_shirt_icon")!
            secondTag = LocalizedString(with: "short_sleeved_t_shirt")
            third = UIImage.init(named: "big_hot_pants_icon")!
            thirdTag = LocalizedString(with: "hot_pants")
        case 23...27:
            first = UIImage.init(named: "big_one_piece_icon")!
            firstTag = LocalizedString(with: "one_piece")
            second = UIImage.init(named: "big_short_sleeved_t_shirt_icon")!
            secondTag = LocalizedString(with: "short_sleeved_t_shirt")
            third = UIImage.init(named: "big_cotton_pants_icon")!
            thirdTag = LocalizedString(with: "cotton_pants")
        case 20...22:
            first = UIImage.init(named: "big_shirt_icon")!
            firstTag = LocalizedString(with: "shirt")
            second = UIImage.init(named: "big_blouse_icon")!
            secondTag = LocalizedString(with: "blouse")
            third = UIImage.init(named: "big_blue_jeans_icon")!
            thirdTag = LocalizedString(with: "blue_jeans")
        case 17...19:
            first = UIImage.init(named: "big_blue_jean_jacket_icon")!
            firstTag = LocalizedString(with: "blue_jean_jacket")
            second = UIImage.init(named: "big_cardigan_icon")!
            secondTag = LocalizedString(with: "cardigan")
            third = UIImage.init(named: "big_blue_jeans_icon")!
            thirdTag = LocalizedString(with: "blue_jeans")
        case 12...16:
            first = UIImage.init(named: "big_sweatshirt_icon")!
            firstTag = LocalizedString(with: "sweatshirt")
            second = UIImage.init(named: "big_checked_shirt_icon")!
            secondTag = LocalizedString(with: "checked_shirt")
            third = UIImage.init(named: "big_cotton_pants_icon")!
            thirdTag = LocalizedString(with: "cotton_pants")
        case 9...11:
            first = UIImage.init(named: "big_trench_coat_icon")!
            firstTag = LocalizedString(with: "trench_coat")
            second = UIImage.init(named: "big_jacket_icon")!
            secondTag = LocalizedString(with: "jacket")
            third = UIImage.init(named: "big_slacks_icon")!
            thirdTag = LocalizedString(with: "slacks")
        case 5...8:
            first = UIImage.init(named: "big_coat_icon")!
            firstTag = LocalizedString(with: "coat")
            second = UIImage.init(named: "big_knitwear_icon")!
            secondTag = LocalizedString(with: "knitwear")
            third = UIImage.init(named: "big_long_skirt_icon")!
            thirdTag = LocalizedString(with: "long_skirt")
        case ...4:
            first = UIImage.init(named: "big_muffler_icon")!
            firstTag = LocalizedString(with: "muffler")
            second = UIImage.init(named: "big_padding_icon")!
            secondTag = LocalizedString(with: "padding")
            third = UIImage.init(named: "big_fur_gloves_icon")!
            thirdTag = LocalizedString(with: "fur_gloves")
        default:
            first = UIImage.init(named: "big_blouse_icon")!
            firstTag = LocalizedString(with: "blouse")
            second = UIImage.init(named: "big_cardigan_icon")!
            secondTag = LocalizedString(with: "cardigan")
            third = UIImage.init(named: "big_one_piece_icon")!
            thirdTag = LocalizedString(with: "one_piece")
        }
        
        if 200 <= id && id < 600 {
            first = UIImage.init(named: "big_umbrella_icon")!
            firstTag = LocalizedString(with: "umbrella")
        }
        
        images = [first:firstTag, second:secondTag, third:thirdTag]
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
