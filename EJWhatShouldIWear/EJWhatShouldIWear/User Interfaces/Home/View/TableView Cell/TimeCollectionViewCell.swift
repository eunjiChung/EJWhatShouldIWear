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
    
    @IBOutlet weak var alcTopOfHourLabel: NSLayoutConstraint!
    @IBOutlet weak var alcTopOfTempLabel: NSLayoutConstraint!
    @IBOutlet weak var alcTopOfSkyConditionLabel: NSLayoutConstraint!
    @IBOutlet weak var alcTopOfClothImage: NSLayoutConstraint!
    @IBOutlet weak var alcBottomOfClothImage: NSLayoutConstraint!
    
    // MARK: - Properties
    let hour = LocalizedString(with: "hour")
    var index: Int = 0
    var model: [EJThreedaysForecastModel]? {
        didSet {
            setKRHourlyWeather()
        }
    }
    
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
    // TODO: 여기 정리해야돼...
    public func setKRHourlyWeather() {
        // 1. 현재 시간 받아오기
        let date = Date()
        // 2. 시간별 온도(fcst3hour-sky&temperature) 정보 받아오기
        guard let fcstModel = model, let fcst3hour = fcstModel.first?.fcst3hour, let timeRelease = fcstModel.first?.timeRelease else { return }
        // 현재 sky 정보 뿌릴 Label이 없음..
        let sky = fcst3hour.sky
        let temp = fcst3hour.temperature
        // 3. 향후 3일 날씨까지 뿌리기
        let unit = EJWeatherManager.shared.getValidUnit()
        let timeIndex = 4 + 3 * index
        
        let tempList = temp.dictionaryRepresentation()
        let skyList = sky.dictionaryRepresentation()
        let strTemp = tempList["temp\(timeIndex)hour"]!
        let skyCondition = skyList["name\(timeIndex)hour"]!

        // hourLabel
        let currentDate = timeRelease.toDate(0)
        guard let releaseHour = Int(currentDate.todayHourString()) else { return }
        let futureHour = (releaseHour + timeIndex) % 24
        let num = Double((releaseHour + timeIndex) / 24)
        let dayArray = [LocalizedString(with: "today"), LocalizedString(with: "tomorrow"), LocalizedString(with: "day_after_tomorrow"), Date(timeIntervalSinceNow: 86400 * 3).dateCompose()]

        hourLabel.text = "\(futureHour) \(hour)"

        // dateLabel
        if num == 0 && index == 0 {
            dateLabel.text = dayArray[0]
        } else {
            if futureHour == 0 || futureHour == 1 || futureHour == 2 {
                if dayArray[Int(num)] != "" {
                    dateLabel.text = Date(timeIntervalSinceNow: 86400 * num).dateCompose()
                } else {
                    dateLabel.text = dayArray[Int(num)]
                }
            } else {
                dateLabel.text = "-"
            }
        }

        // tempLabel, skyConditionLabel, clothImageView 구성
        if strTemp != "", let floatTemp = Float(strTemp) {
            let intTemp = Int(floatTemp)
            tempLabel.text = "\(intTemp)\(unit)"
            skyConditionLabel.text = skyCondition

            let style = EJClothManager.shared.setTopCloth(by: intTemp)
            clothImageView.image = UIImage.init(named: style)
        }
    }
    
    public func setHourlyWeather(of model: EJFiveDaysWeatherModel, at index: Int) {
        guard let city = model.city, let timezone = city.timezone else { return }
        guard let list = model.list else { return }
        let item = list[index]
        
        skyConditionLabel.text = ""
        dateLabel.text = ""
        
        if let time = item.dtTxt {
            let date = time.toDate(timezone)
            let time = date.todayHourString()
            hourLabel.text = "\(time) \(hour)"
        }
        
        let unit = EJWeatherManager.shared.getValidUnit()
        if let weatherInfo = item.main, let floatTemp = weatherInfo.temp {
            let temp = EJWeatherManager.shared.getValidTemperature(by: floatTemp)
            tempLabel.text = "\(temp)\(unit)"
            
            let style = EJClothManager.shared.setTopCloth(by: temp)
            clothImageView.image = UIImage.init(named: style)
            
        }
    }
    
    // MARK: - Private Method
}
