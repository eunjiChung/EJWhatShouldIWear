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
            return "안개가 꼈어요"
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
            firstTag = "민소매"
            second = UIImage.init(named: "big_short_sleeved_t_shirt_icon")!
            secondTag = "반팔티"
            third = UIImage.init(named: "big_hot_pants_icon")!
            thirdTag = "반바지"
        case 23...27:
            first = UIImage.init(named: "bit_one_piece_icon")!
            firstTag = "원피스"
            second = UIImage.init(named: "big_short_sleeved_t_shirt_icon")!
            secondTag = "반팔티"
            third = UIImage.init(named: "big_cotton_pants_icon")!
            thirdTag = "면바지"
        case 20...22:
            first = UIImage.init(named: "big_shirt_icon")!
            firstTag = "긴팔"
            second = UIImage.init(named: "big_blouse_icon")!
            secondTag = "블라우스"
            third = UIImage.init(named: "big_blue_jeans_icon")!
            thirdTag = "청바지"
        case 17...19:
            first = UIImage.init(named: "big_blue_jean_jacket_icon")!
            firstTag = "청자켓"
            second = UIImage.init(named: "big_cardigan_icon")!
            secondTag = "가디건"
            third = UIImage.init(named: "big_blue_jeans_icon")!
            thirdTag = "청바지"
        case 12...16:
            first = UIImage.init(named: "big_sweatshirt_icon")!
            firstTag = "맨투맨"
            second = UIImage.init(named: "big_checked_shirt_icon")!
            secondTag = "체크셔츠"
            third = UIImage.init(named: "big_cotton_pants_icon")!
            thirdTag = "면바지"
        case 9...11:
            first = UIImage.init(named: "big_trench_coat_icon")!
            firstTag = "트렌치코트"
            second = UIImage.init(named: "big_jacket_icon")!
            secondTag = "자켓"
            third = UIImage.init(named: "big_slacks_icon")!
            thirdTag = "슬랙스"
        case 5...8:
            first = UIImage.init(named: "big_coat_icon")!
            firstTag = "코트"
            second = UIImage.init(named: "big_knitwear_icon")!
            secondTag = "니트"
            third = UIImage.init(named: "big_long_skirt_icon")!
            thirdTag = "롱스커트"
        case ...4:
            first = UIImage.init(named: "big_muffler_icon")!
            firstTag = "목도리"
            second = UIImage.init(named: "big_padding_icon")!
            secondTag = "패딩"
            third = UIImage.init(named: "big_fur_gloves_icon")!
            thirdTag = "털장갑"
        default:
            first = UIImage.init(named: "big_blouse_icon")!
            firstTag = "블라우스"
            second = UIImage.init(named: "big_cardigan_icon")!
            secondTag = "가디건"
            third = UIImage.init(named: "big_one_piece_icon")!
            thirdTag = "원피스"
        }
        
        if 200 <= id && id < 600 {
            first = UIImage.init(named: "big_umbrella_icon")!
            firstTag = "우산"
        }
        
        images = [first:firstTag, second:secondTag, third:thirdTag]
        return images
    }
}
