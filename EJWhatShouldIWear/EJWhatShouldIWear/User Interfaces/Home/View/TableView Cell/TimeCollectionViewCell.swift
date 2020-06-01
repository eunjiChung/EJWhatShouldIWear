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
    
    var skyModel: EJKisangTimelyModel?
    var rainyModel: EJKisangTimelyModel?
    var tempModel: EJKisangTimelyModel? {
        didSet {
            setDate(tempModel?.fcstDate ?? "")
            setTime(tempModel?.fcstTime ?? "")
            setTemperature()
            setDescription()
            setDress()
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
    
    private func setTemperature() {
        guard let tempModel = self.tempModel, tempModel.category == .threeHourTemp else { return }
        tempLabel.text = tempModel.fcstValue + EJWeatherManager.shared.getValidUnit()
    }
    
    private func setDescription() {
        guard let skyModel = self.skyModel, skyModel.category == .skyCode else { return }
        guard let rainyModel = self.rainyModel, rainyModel.category == .rainFallType else { return }
        var description = ""
        
        guard let skyValue = Int(skyModel.fcstValue), let skyType = EJSkyCode(rawValue: skyValue) else { return }
        switch skyType {
        case .sunny:
            description = "맑아요"
        case .cloudy:
            description = "구름조금"
        case .grey:
            description = "흐려요"
        }
        
        guard let rainyValue = Int(rainyModel.fcstValue), let rainyType = EJPrecipitationCode(rawValue: rainyValue) else { return }
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
    
    private func setDress() {
        guard let tempModel = self.tempModel, tempModel.category == .threeHourTemp else { return }
        guard let temp = Int(tempModel.fcstValue) else { return }
        let style = EJClothManager.shared.setTopCloth(by: temp)
        clothImageView.image = UIImage(named: style)
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
