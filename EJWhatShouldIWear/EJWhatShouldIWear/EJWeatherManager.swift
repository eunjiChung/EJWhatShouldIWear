//
//  EJWeatherManager.swift
//  EJWhatShouldIWear
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 22/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit
import SwiftyJSON

// MARK : - Type Alias
typealias SuccessHandler = (Any) -> ()
typealias FailureHandler = (Error) -> ()

// MARK : - Shared Instance
let WeatherManager = EJWeatherManager.sharedInstance

class EJWeatherManager: NSObject {
    
    static let sharedInstance = EJWeatherManager()
    var latitude: Double = 0//37.51151
    var longitude: Double = 0//127.0967
    
    let httpClient = EJHTTPClient.init()
    
    // MARK : - HTTP Request
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
    
    // MARK : - Public Method
    public func weatherCondition(of id:Int) -> String {
        if 200 <= id {
            return LocalizedString(with: "rainy")
        } else if 600 <= id {
            return LocalizedString(with: "snowy")
        } else if 700 <= id {
            return ""
        } else if id == 800 {
            return "맑아요"
            return LocalizedString(with: "sunny")
        } else if 800 <= id {
            return LocalizedString(with: "cloudy")
        }
        
        return ""
    }
}
