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
    
    
    // MARK : - Get Proper Data From HTTP Response by SwiftyJSON
    func getCurrentWeatherInfo(from data: [String: Any]?) -> String {
        let json = JSON(data!)
        print(json)
        let result = json["weather"]["hourly"][0]["temperature"]["tc"].string!
        return result
    }
    
    func getTimeRelease(from data: [String: Any]?) -> String {
        let json = JSON(data!)
        let result = json["weather"]["forecast3days"][0]
        let timeRelease = result["timeRelease"].string!
        return timeRelease
    }
    
    func getHourlyWeatherInfo(from data: [String: Any]?) -> [String: Any] {
        let json = JSON(data!)
        let result = json["weather"]["forecast3days"][0]
        let fcst3hour = result["fcst3hour"]["temperature"].dictionaryObject!
        return fcst3hour
    }
    
    func getWeekelyWeatherInfo(from data: [String: Any]?) -> [String: Any] {
        let json = JSON(data!)
        let result = json["weather"]["forecast6days"][0]["temperature"].dictionaryObject!
        return result
    }
    
    // MARK : - Public Method
    public func changeValidTempString(_ string: String) -> String {
        guard let float = Double(string) else {
            fatalError()
        }
        let temp = Int(float)
        let result = String(temp)
        
        return result
    }
    
    public func weatherCondition(of id:Int) -> String {
        if 200 <= id {
            return "비와요"
        } else if 600 <= id {
            return "눈와요"
        } else if 700 <= id {
            return ""
        } else if id == 800 {
            return "맑아요"
        } else if 800 <= id {
            return "흐려요"
        }
        
        return ""
    }
}
