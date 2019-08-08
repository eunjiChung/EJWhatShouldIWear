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
    public func setHourlyWeather(of model: EJFiveDaysWeatherModel, at index: Int) {
        let hour = LocalizedString(with: "hour")
        let unit = LocalizedString(with: "temp")
        
        guard let city = model.city, let timezone = city.timezone else { return }
        guard let list = model.list else { return }
        let item = list[index]
        
        if let time = item.dtTxt {
            let date = time.toDate(timezone)
            let time = date.toHourString()
            hourLabel.text = "\(time) \(hour)"
        }
        
        if let weatherInfo = item.main {
            if let floatTemp = weatherInfo.temp {
                let temp = WeatherManager.getValidTemperature(by: floatTemp)
                tempLabel.text = "\(temp)\(unit)"
                
                let style = WeatherManager.setTopCloth(by: temp)
                clothImageView.image = UIImage.init(named: style)
            }
        }
    }
}
