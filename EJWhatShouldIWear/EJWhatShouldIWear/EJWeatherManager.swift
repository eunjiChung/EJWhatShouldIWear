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
//typealias SuccessHandler = (Any) -> ()
typealias FailureHandler = (Error) -> ()

// MARK : - Shared Instance
let WeatherManager = EJWeatherManager.sharedInstance

class EJWeatherManager: NSObject {
    
    static let sharedInstance = EJWeatherManager()
    static var latitude: Double = 37.51151
    static var longitude: Double = 127.0967
    
    let httpClient = EJHTTPClient.init(latitude, longitude)
    
    // MARK : - HTTP Request
    func CurrentWeatherInfo(success: @escaping (String) -> (),
                            failure: @escaping FailureHandler) {
        httpClient.basicRequest(to: "current/hourly", success: { (response) in
            let currentTemp = self.getCurrentWeatherInfo(from: response)
            success(currentTemp)
        }) { (error) in
            failure(error)
        }
    }
    
    func HourlyWeatherInfo(success: @escaping ([String: Any]) -> (),
                           failure: @escaping FailureHandler) {
        httpClient.basicRequest(to: "forecast/3days", success: { (response) in
            let result = self.getHourlyWeatherInfo(from: response)
            success(result)
        }) { (error) in
            failure(error)
        }
    }
    
    func WeekelyWeatherInfo(success: @escaping ([String: Any]) -> (),
                            failure: @escaping FailureHandler) {
        httpClient.basicRequest(to: "forecast/6days", success: { (response) in
            let result = self.getWeekelyWeatherInfo(from: response)
            success(result)
        }) { (error) in
            failure(error)
        }
    }
    
    func YesterdayWeatherInfo() {
        
    }
    
    // MARK : - Get Proper Data From HTTP Response by SwiftyJSON
    func getCurrentWeatherInfo(from data: [String: Any]?) -> String {
        let json = JSON(data!)
        let result = json["weather"]["hourly"][0]["temperature"]["tc"].string!
        return result
    }
    
    func getHourlyWeatherInfo(from data: [String: Any]?) -> [String: Any] {
        let json = JSON(data!)
        let result = json["weather"]["forecast3days"][0]
        let timeRelease = result["timeRelease"].string!
        let fcst3hour = result["fcst3hour"]["temperature"].dictionary!
        let dictionary = ["timeRelease" : timeRelease,
                          "fcst3hour" : fcst3hour] as [String : Any]
        return dictionary
    }
    
    func getWeekelyWeatherInfo(from data: [String: Any]?) -> [String: Any] {
        let json = JSON(data!)
        let result = json["weather"]["forecast6days"][0]["temperature"].dictionary!
        return result
    }
}
