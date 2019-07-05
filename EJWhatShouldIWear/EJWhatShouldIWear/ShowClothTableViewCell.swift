//
//  ShowClothTableViewCell.swift
//  EJWhatShouldIWear
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 16/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class ShowClothTableViewCell: UITableViewCell {
    
    static let identifier = "ShowClothTableViewCell"
    
    // MARK: - IBOutlet
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var firstClothImageView: UIImageView!
    @IBOutlet weak var secondClothImageview: UIImageView!
    @IBOutlet weak var thirdClothImageView: UIImageView!
    @IBOutlet weak var suggestLabel: UILabel!
    @IBOutlet weak var yesterdayLabel: UILabel!
    @IBOutlet weak var feelingLabel: UILabel!
    
    // MARK: - Constraints
    
    @IBOutlet weak var alcTopOfLocationLabel: NSLayoutConstraint!
    @IBOutlet weak var alcHeightOfClothImageView: NSLayoutConstraint!
    @IBOutlet weak var alcTopOfCurrentTempLabel: NSLayoutConstraint!
    @IBOutlet weak var alcHeightOfSuggestLabel: NSLayoutConstraint!
    @IBOutlet weak var alcHeightOfYesterdayLabel: NSLayoutConstraint!
    @IBOutlet weak var alcBottomOfYesterdayLabel: NSLayoutConstraint!
    
    // MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        alcTopOfLocationLabel.constant = EJSize(20.0)
        alcHeightOfClothImageView.constant = EJSize(250.0)
//        alcTopOfCurrentTempLabel.constant = EJSize(21.0)
        alcHeightOfSuggestLabel.constant = EJSize(45.5)
        alcHeightOfYesterdayLabel.constant = EJSize(47.0)
        alcBottomOfYesterdayLabel.constant = EJSize(30.0)
    }

    
    // MARK: - Public Method
    public func setCurrentLocality(by locationStr:String) {
        locationLabel.text = locationStr
    }
    
    public func setWeatherInfo(by info: EJMain, with description:EJWeather) {
        if let temp = info.temp, let id = description.id {
            // 나라별 온도 사용 단위
            let intTemp = Int(temp) - 273
            currentTempLabel.text = "\(intTemp)℃"
            yesterdayLabel.text = WeatherManager.weatherCondition(of: id)
        }
    }
    
}
