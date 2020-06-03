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
    let hour = "hour".localized
    var index: Int = 0
    
    var model: EJKisangTimeModel? {
        didSet {
            setView()
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
    
    // MARK: - Kisang
    private func setView() {
        guard let model = model else { return }
        tempLabel.text = "\(model.temperature)" + EJWeatherManager.shared.getValidUnit()
        setDate(model.fcstDate)
        setTime(model.fcstTime)
        setDress()
        setDescription()
    }
    
    private func setDress() {
        guard let model = model else { return }
        
        var dress = ""
        var type: EJWeatherType = .no
        switch model.rainyCode {
        case .no:
            let skyType = EJWeatherManager.shared.criticCondition(by: .sky, code: model.skyCode.rawValue)
            type = EJWeatherType(rawValue: skyType.rawValue) ?? .no
        default:
            let rainyType = EJWeatherManager.shared.criticCondition(by: .rainy, code: model.rainyCode.rawValue)
            type = EJWeatherType(rawValue: rainyType.rawValue) ?? .no
        }
        
        dress = EJClothManager.shared.setItem(by: type)
        if dress == "outer" {
            dress = EJClothManager.shared.setOuterCloth(by: EJWeatherManager.shared.properSeasonValue(model.fcstDate, model.temperature, model.temperature))
        }
        clothImageView.image = UIImage(named: dress)
    }
    
    private func setDate(_ date: String) {
        let startIndex = date.index(date.startIndex, offsetBy: 4)
        let monthEndIndex = date.index(after: startIndex)
        let month = "\(date[startIndex...monthEndIndex])"
        
        let dayStartIndex = date.index(after: monthEndIndex)
        let dayEndIndex = date.index(after: dayStartIndex)
        let day = "\(date[dayStartIndex...dayEndIndex])"
        
        dateLabel.text = "\(month)/\(day)"
    }
    
    private func setTime(_ time: String) {
        let startIndex = time.startIndex
        let endIndex = time.index(after: startIndex)
        let hourString = "\(time[startIndex...endIndex])"
        hourLabel.text = hourString + hour
    }
    
    private func setDescription() {
        var description = ""
        
        guard let skyType = model?.skyCode else { return }
        switch skyType {
        case .sunny:
            description = "맑아요"
        case .cloudy:
            description = "구름조금"
        case .grey:
            description = "흐려요"
        }
        guard let rainyType = model?.rainyCode else { return }
        switch rainyType {
        case .no:
            EJLogger.d("")
        case .rain, .both, .shower:
            description = "비와요"
        case .snow:
            description = "눈와요"
        }
        skyConditionLabel.text = description
    }
    
    // MARK: - Public Method
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
}
