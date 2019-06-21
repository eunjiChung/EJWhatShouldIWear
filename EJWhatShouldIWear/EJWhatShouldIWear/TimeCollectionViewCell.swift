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
    
    // MARK : - Outlets
    @IBOutlet weak var clothImageView: UIImageView!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    // MARK: - Alc of Constraints
    @IBOutlet weak var alcHeightOfClothImageView: NSLayoutConstraint!
    @IBOutlet weak var alcHeightOfTempLabel: NSLayoutConstraint!
    

    // MARK : - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        alcHeightOfClothImageView.constant = EJSize(120.0)
        alcHeightOfTempLabel.constant = EJSize(15.0)
    }
    
    
    // MARK : - Public Method
//    public func setHourlyWeather(_ index: Int) {
//        WeatherManager.HourlyWeatherInfo(success: { (time, hourArray) in
//
//            let timeGap = self.timeJump(index)
//            let hour = self.getTime(from: time, to: timeGap)
//            let newArray = hourArray
//            let currentTemp = newArray["temp\(timeGap)hour"] as! String
//            let temp = WeatherManager.changeValidTempString(currentTemp)
//
//            self.hourLabel.text = "\(hour)시"
//            self.tempLabel.text = "\(temp)℃"
//
//        }) { (error) in
//            print(error)
//        }
//    }
    
    // MARK : - Private Method
    fileprivate func getTime(from string: String, to index: Int) -> Int {
        let array = string.components(separatedBy: " ")
        let onlyTime = array[1]
        let timeArray = onlyTime.components(separatedBy: ":")
        let currentHour = timeArray[0]
        let currentIntHour = Int(currentHour)!
        return (currentIntHour + index) % 24
    }
    
    fileprivate func timeJump(_ index: Int) -> Int {
        return 4 + 3 * index
    }
}
