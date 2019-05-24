//
//  WeekelyWeatherTableViewCell.swift
//  EJWhatShouldIWear
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 16/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class WeekelyWeatherTableViewCell: UITableViewCell {
    
    static let identifier = "WeekelyWeatherTableViewCell"
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherTellingLabel: UILabel!
    

    // MARK : - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK : - Public Method
    public func setWeekelyInfo(to index: Int) {
        WeatherManager.WeekelyWeatherInfo(success: { (result) in
            
        }) { (error) in
            print(error)
        }
    }

}
