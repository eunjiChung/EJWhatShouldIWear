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
    @IBOutlet weak var firstClothLabel: UILabel!
    @IBOutlet weak var secondClothLabel: UILabel!
    @IBOutlet weak var thirdClothLabel: UILabel!
    
    // MARK: - Constraints
    
    // MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    
    // MARK: - Public Method
    public func setCurrentLocality(by locationStr:String) {
        locationLabel.text = locationStr
    }
    
    public func setWeatherInfo(by info: EJMain, with description:EJWeather) {
        if let temp = info.temp, let id = description.id {
            // 나라별 온도 사용 단위
            let intTemp = Int(temp) - 273
            currentTempLabel.text = "\(intTemp)"
            suggestLabel.text = WeatherManager.weatherCondition(of: id)
        }
    }
    
}
