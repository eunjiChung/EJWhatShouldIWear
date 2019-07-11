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
    

    // MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        alcTopOfHourLabel.constant = EJSizeHeight(7.0)
        alcTopOfTempLabel.constant = EJSizeHeight(22.0)
        alcTopOfClothImage.constant = EJSizeHeight(6.0)
        alcBottomOfClothImage.constant = EJSizeHeight(10.0)
    }
    
    
    // MARK: - Public Method
    public func setHourlyWeather(by info: EJFiveDaysList) {
        
        let hour = LocalizedString(with: "hour")
        let unit = LocalizedString(with: "temp")
        
        let weatherInfo = info.main
        let weatherID = info.weather
        if let dateInfo = info.dtTxt {
            let time = getTime(from: dateInfo)
            hourLabel.text = "\(time)\(hour)"
        }
        
        if let floatTemp = weatherInfo?.temp, let id = weatherID?.first?.id {
            let temp = WeatherManager.getValidTemperature(by: floatTemp)
            tempLabel.text = "\(temp)\(unit)"
            
            let style = WeatherManager.setTodayStyle(by: temp, id: id)
            let image = style.sorted(by: >)
            clothImageView.image = UIImage.init(named: image[0])
        }
    }
    
    // MARK: - Private Method
    fileprivate func getTime(from string: String) -> Int {
        let array = string.components(separatedBy: " ")
        let onlyTime = array[1]
        let timeArray = onlyTime.components(separatedBy: ":")
        let currentHour = timeArray[0]
        let currentIntHour = Int(currentHour)!
        return currentIntHour % 24
    }
}
