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
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherTellingLabel: UILabel!
    

    // MARK : - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK : - Public Method
//    public func setWeekelyInfo(to index: Int) {
//        WeatherManager.WeekelyWeatherInfo(success: { (result) in
//
//            // 오늘 요일을 받아서 그 뒤로 7일까지 추출
//            self.dateLabel.text = "\(self.getWeekday(of: index))요일"
//
//            // 해당 요일 온도 추출
//            let currentTemp = result["tmax\(index+2)day"] as! String
//            let temp = WeatherManager.changeValidTempString(currentTemp)
//            self.tempLabel.text = "\(temp)℃"
//
//            // 어제보다 어떤지 얘기
//            self.weatherTellingLabel.text = self.tellWeatherCondition(of: "27.0", of: "28.0")
//            
//        }) { (error) in
//            print(error)
//        }
//    }
    
    // MARK : - Private Method
    private func getWeekday(of index: Int) -> String {
        var weekDay = ["일", "월", "화", "수", "목", "금", "토"]
        
        // 1. 오늘 요일을 구한다
        let calendar = Calendar(identifier: .gregorian)
        let now = Date()
        let component = calendar.dateComponents([.weekday], from: now)
        
        // 2. 오늘 요일로부터 지난 시간을 index로 계산한다
        let day = (component.weekday! + index) % 7
        
        // 3. 해당 day만큼 weekDay 문자열 배열에 있는 값을 리턴한다
        return weekDay[day]
    }
    
    private func tellWeatherCondition(of yesterday: String, of today: String) -> String {
        var result = "전날과 비슷해요"
        
        guard let todayTemp = Double(today) else {
            fatalError()
        }
        guard let yesterdayTemp = Double(yesterday) else {
            fatalError()
        }
        
        let difference = abs(todayTemp - yesterdayTemp)
        
        if difference > 3 {
            if todayTemp > yesterdayTemp
            {
                result = "전날보다 더워요"
            } else {
                result = "전날보다 추워요"
            }
        }
        
        return result
    }

}
