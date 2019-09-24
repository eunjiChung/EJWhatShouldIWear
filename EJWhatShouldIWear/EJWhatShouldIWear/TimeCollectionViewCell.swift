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
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var clothImageView: UIImageView!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var skyConditionLabel: UILabel!
    
    // MARK: - Alc of Constraints
    @IBOutlet weak var alcTopOfHourLabel: NSLayoutConstraint!
    @IBOutlet weak var alcTopOfTempLabel: NSLayoutConstraint!
    @IBOutlet weak var alcTopOfSkyConditionLabel: NSLayoutConstraint!
    @IBOutlet weak var alcTopOfClothImage: NSLayoutConstraint!
    @IBOutlet weak var alcBottomOfClothImage: NSLayoutConstraint!
    
    let hour = LocalizedString(with: "hour")
    
    // MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        alcTopOfHourLabel.constant = EJSizeHeight(3.0)
        alcTopOfTempLabel.constant = EJSizeHeight(8.0)
        alcTopOfSkyConditionLabel.constant = EJSizeHeight(3.0)
        alcTopOfClothImage.constant = EJSizeHeight(10.0)
        alcBottomOfClothImage.constant = EJSizeHeight(7.0)
    }
    
    
    // MARK: - Public Method
    public func setKRHourlyWeather(of model: SKThreeThreedays, at index: Int) {
        // 1. 현재 시간 받아오기
        let date = Date()
        guard let currentHour = Int(date.todayHourString()) else { return }
        // 2. 시간별 온도(fcst3hour-sky&temperature) 정보 받아오기
        guard let weather = model.weather, let fcst3days = weather.forecast3days else { return }
        guard let fcst3hour = fcst3days.first?.fcst3hour, let timeRelease = fcst3days.first?.timeRelease else { return }
        // 현재 sky 정보 뿌릴 Label이 없음..
        guard let sky = fcst3hour.sky, let temp = fcst3hour.temperature else { return }
        // 3. 향후 3일 날씨까지 뿌리기
        let unit = WeatherManager.getValidUnit()
        let timeIndex = 4 + 3 * index
        
        let tempList = temp.dictionaryRepresentation()
        let skyList = sky.dictionaryRepresentation()
        let strTemp = tempList["temp\(timeIndex)hour"] as! String
        let skyCondition = skyList["name\(timeIndex)hour"] as! String
        
        // hourLabel
        let currentDate = timeRelease.toDate(0)
        guard let releaseHour = Int(currentDate.todayHourString()) else { return }
        let futureHour = (releaseHour + timeIndex) % 24
        hourLabel.text = "\(futureHour) \(hour)"
        
        // dateLabel
        dateLabel.text = "-"
        if index == 0 {
            dateLabel.text = date.dateCompose()
        }
        if index != 0 && futureHour == 1 {
            print("Index : \(index)")
            let future = Date(timeIntervalSinceNow: 86400).dateCompose()
            dateLabel.text = future
        }
        
        // tempLabel, skyConditionLabel, clothImageView 구성
        if strTemp != "", let floatTemp = Float(strTemp) {
            let intTemp = Int(floatTemp)
            tempLabel.text = "\(intTemp)\(unit)"
            skyConditionLabel.text = skyCondition
            
            let style = WeatherManager.setTopCloth(by: intTemp)
            clothImageView.image = UIImage.init(named: style)
        }
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
