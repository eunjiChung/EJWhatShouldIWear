//
//  WeekelyWeatherTableViewCell.swift
//  EJWhatShouldIWear
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 16/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class WeekelyWeatherTableViewCell: UITableViewCell {
    
    static let identifier = "WeekelyWeatherTableViewCell"
    
    let today = Date()
    let dateFormatter = DateFormatter()
    let calendar = Calendar(identifier: .gregorian)
    
    var weatherList:[EJFiveDaysList]?
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherTellingLabel: UILabel!
    

    // MARK : - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        dateFormatter.dateFormat = "YYYY-MM-dd 12:00:00"
    }
    
    // MARK : - Public Method
    public func setWeekelyInfo(by info: [EJFiveDaysList],to index: Int) {
        self.weatherList = info
        dateLabel.text = "\(getWeekday(of: index))요일"
        tempLabel.text = "\(getTemp(of: index))도"
        weatherTellingLabel.text = "\(tellWeatherCondition(of: index))"
    }
    
    // MARK : - Private Method
    private func getWeekday(of index: Int) -> String {
        var weekDay = ["일", "월", "화", "수", "목", "금", "토"]
        
        // 1. 오늘 요일을 구한다
        let component = calendar.dateComponents([.weekday], from: today)
        
        // 2. 오늘 요일로부터 지난 시간을 index로 계산한다
        print("Today is \(weekDay[component.weekday!])") // 왜 월요일인데...?
        let day = (component.weekday! + index) % 7
        
        // 3. 해당 day만큼 weekDay 문자열 배열에 있는 값을 리턴한다
        return weekDay[day]
    }
    
    private func getTemp(of index: Int) -> Int {
        guard let oneDay = returnCertainWeather(of: index) else { return 0}
        guard let floatTemp = oneDay.temp else { return 0 }
        let temp = Int(floatTemp) - 273
        return temp
    }
    
    private func tellWeatherCondition(of index: Int) -> String {
        let day = getDay(from: index)
        guard let oneDayWeather = weatherInfo(which: "weather", of: day) else { return "" }
        let oneDay = oneDayWeather as? EJFiveDaysWeather
        if let weatherID = oneDay?.id {
            return WeatherManager.weatherCondition(of: weatherID)
        }
        
        return ""
    }
    
    private func returnCertainWeather(of index: Int) -> EJFiveDaysMain? {
        let day = getDay(from: index)
        guard let oneDayWeather = weatherInfo(which: "main", of: day) else { return nil }
        return oneDayWeather as? EJFiveDaysMain
    }
    
    
    // MARK : - Date Method
    func getTodayDate() -> String {
        let dateString = dateFormatter.string(from: today)
        return dateString
    }
    
    func getDay(from index: Int) -> String {
        let offset = DateComponents(day: index+1)
        guard let dayOffset = calendar.date(byAdding: offset, to: today) else {
            return ""
        }
        let day = dateFormatter.string(from: dayOffset)
        
        return day
    }
    
    func weatherInfo(which type:String, of day:String) -> Any? {
        guard let list = weatherList else { return nil }
        
        for weather in list
        {
            if weather.dtTxt == day
            {
                switch type
                {
                case "main":
                    if let main = weather.main{
                        return main
                    }
                default:
                    if let weather = weather.weather {
                        return weather.first
                    }
                    
                }
            }
        }
        return nil
    }
    
}
