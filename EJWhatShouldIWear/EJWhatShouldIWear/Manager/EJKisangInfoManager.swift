//
//  EJKisangInfoManager.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/05/31.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Foundation

class EJKisangInfoManager {
    
    let presentTime = [2, 5, 8, 11, 14, 17, 20, 23]
    
    func generateBaseTime() -> String {
        let currentHour = Date().currentHourInt()
        let currentMinute = Date().currnetMinuteInt()
        
        var resultHour = presentTime.first ?? 2
        for (index, hour) in presentTime.enumerated() {
            if hour <= currentHour {
                resultHour = hour
                if hour == currentHour, currentMinute < 10, index != 0 {
                    resultHour = presentTime[index-1]
                }
            }
        }
        if currentHour < 2 {
            resultHour = 23
        }
        
        if resultHour == 2 || resultHour == 5 || resultHour == 8 {
            return "0\(resultHour)00"
        } else {
            return "\(resultHour)00"
        }
    }
    
    func generateBaseDate() -> String {
        let date = Date()
        let calendar = Calendar.current
        
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        
        let today = "\(year)-\(month)-\(day)"
        
        let date1 = DateFormatter()
        date1.locale = Locale(identifier: "ko_kr")
        date1.dateFormat = "yyyy-MM-dd"
        let time = date1.date(from: today)!
        
        if hour >= 0, hour <= 2 {
            if hour == 2, minute > 10 { return "" }
            return time.yesterday().generateWeatherBaseDate()
        }
        
        return date.generateWeatherBaseDate()
    }
    
    // MARK: - Weekely
    func weekelyForecastTime() -> String {
        let date = Date().generateWeatherBaseDate()
        let hour = Calendar.current.component(.hour, from: Date())
        
        if hour < 7 {
            let date = Date()
            let calendar = Calendar.current
            let year = calendar.component(.year, from: date)
            let month = calendar.component(.month, from: date)
            let day = calendar.component(.day, from: date)
            let today = "\(year)-\(month)-\(day)"
            let date1 = DateFormatter()
            date1.locale = Locale(identifier: "ko_kr")
            date1.dateFormat = "yyyy-MM-dd"
            let time = date1.date(from: today)!
            return time.yesterday().generateWeatherBaseDate() + "1800"
        } else if hour >= 7 && hour < 18 {
            return date + "0600"
        } else {
            return date + "1800"
        }
    }
}
