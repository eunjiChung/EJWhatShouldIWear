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
    

    // MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        alcTopOfHourLabel.constant = EJSize(7.0)
        alcTopOfTempLabel.constant = EJSize(22.0)
        alcTopOfClothImage.constant = EJSize(9.0)
    }
    
    
    // MARK: - Public Method
    public func setHourlyWeather(by info: EJFiveDaysList) {
        
        let hour = LocalizedString(with: "hour")
        let unit = LocalizedString(with: "temp")
        
        let weatherInfo = info.main
        if let dateInfo = info.dtTxt {
            let time = getTime(from: dateInfo)
            hourLabel.text = "\(time)\(hour)"
        }
        
        if let floatTemp = weatherInfo?.temp {
            let temp = WeatherManager.getValidTemperature(by: floatTemp)
            tempLabel.text = "\(temp)\(unit)"
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
