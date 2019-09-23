//
//  TimeCollectionViewCell.swift
//  EJWhatShouldIWear
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 16/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class TimeCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TimeCollectionViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var clothImageView: UIImageView!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    // MARK: - Alc of Constraints
    @IBOutlet weak var alcTopOfHourLabel: NSLayoutConstraint!
    @IBOutlet weak var alcTopOfTempLabel: NSLayoutConstraint!
    @IBOutlet weak var alcTopOfClothImage: NSLayoutConstraint!
    @IBOutlet weak var alcBottomOfClothImage: NSLayoutConstraint!
    
    let hour = LocalizedString(with: "hour")
    
    
    // MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        alcTopOfHourLabel.constant = EJSizeHeight(7.0)
        alcTopOfTempLabel.constant = EJSizeHeight(22.0)
        alcTopOfClothImage.constant = EJSizeHeight(6.0)
        alcBottomOfClothImage.constant = EJSizeHeight(10.0)
    }
    
    
    // MARK: - Public Method
    public func setKRHourlyWeather(of model: SKThreeThreedays, at index: Int) {
        // 1. 현재 시간 받아오기
        let date = Date()
        guard let currentHour = Int(date.todayHourString()) else { return }
        
        // 2. 시간별 온도(fcst3hour-sky&temperature) 정보 받아오기
        guard let weather = model.weather, let fcst3days = weather.forecast3days, let fcst3hour = fcst3days.first?.fcst3hour else { return }
        // 현재 sky 정보 뿌릴 Label이 없음..
        guard let sky = fcst3hour.sky, let temp = fcst3hour.temperature else { return }
        
        // 3. 향후 3일 날씨까지 뿌리기
        var time = 4
        let tempList = temp.dictionaryRepresentation()
        
        let unit = WeatherManager.getValidUnit()
        repeat {
            let futureHour = (currentHour + time) % 24
            print("Future Hour?? \(futureHour)")
            hourLabel.text = "\(futureHour) \(hour)"
            
            let strTemp = tempList["temp\(time)hour"] as! String
            if strTemp != "", let floatTemp = Float(strTemp) {
                let intTemp = Int(floatTemp)
                tempLabel.text = "\(intTemp)\(unit)"
                
                let style = WeatherManager.setTopCloth(by: intTemp)
                clothImageView.image = UIImage.init(named: style)
            }
            
            time += 3
        } while time <= 67
    }
    
    public func setHourlyWeather(of model: EJFiveDaysWeatherModel, at index: Int) {
        guard let city = model.city, let timezone = city.timezone else { return }
        guard let list = model.list else { return }
        let item = list[index]
        
        if let time = item.dtTxt {
            let date = time.toDate(timezone)
            let time = date.todayHourString()
            hourLabel.text = "\(time) \(hour)"
        }
        
        let unit = WeatherManager.getValidUnit()
        if let weatherInfo = item.main, let floatTemp = weatherInfo.temp {
            let temp = WeatherManager.getValidTemperature(by: floatTemp)
            tempLabel.text = "\(temp)\(unit)"
            
            let style = WeatherManager.setTopCloth(by: temp)
            clothImageView.image = UIImage.init(named: style)
            
        }
    }
}
