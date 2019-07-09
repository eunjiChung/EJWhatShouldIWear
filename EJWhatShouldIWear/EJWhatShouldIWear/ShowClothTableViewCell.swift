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
    @IBOutlet weak var unitLabel: UILabel!
    
    // MARK: - Constraints
    @IBOutlet weak var alcLeadingOfLocationLabel: NSLayoutConstraint!
    @IBOutlet weak var alcLeadingOfCurrentTempLabel: NSLayoutConstraint!
    @IBOutlet weak var alcHeightOfFirstView: NSLayoutConstraint!
    @IBOutlet weak var alcTopOfHomeBoxImageView: NSLayoutConstraint!
    @IBOutlet weak var alcHeightOfClothHangerImageView: NSLayoutConstraint!
    
    
    // MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        addShadow()
        
        alcLeadingOfLocationLabel.constant = EJSize(14.0)
        alcLeadingOfCurrentTempLabel.constant = EJSize(64.0)
//        alcHeightOfFirstView.constant = EJSizeHeight(256.0)
//        alcTopOfHomeBoxImageView.constant = EJSizeHeight(62.0)
//        alcHeightOfClothHangerImageView.constant = EJSizeHeight(146.0)
    }

    
    // MARK: - Public Method
    public func setCurrentLocality(by locationStr:String) {
        locationLabel.text = locationStr
    }
    
    public func setWeatherInfo(by info: EJMain, with description:EJWeather) {
        if let temp = info.temp, let id = description.id {
            let intTemp = WeatherManager.getValidTemperature(by: temp)
            currentTempLabel.text = "\(intTemp)"
            unitLabel.text = LocalizedString(with: "temp")
            suggestLabel.text = WeatherManager.weatherCondition(of: id)
            
            let weatherStyle = WeatherManager.setTodayStyle(by: intTemp, id: id)
            let weatherClothes = weatherStyle.keys.map { $0 }
            
            firstClothImageView.image = weatherClothes[0]
            firstClothLabel.text = weatherStyle[weatherClothes[0]]
            secondClothImageview.image = weatherClothes[1]
            secondClothLabel.text = weatherStyle[weatherClothes[1]]
            thirdClothImageView.image = weatherClothes[2]
            thirdClothLabel.text = weatherStyle[weatherClothes[2]]
            
        }
    }
    
    // MARK: - Private Shadow
    private func addShadow() {
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shadowOpacity = 0.05
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 2
        self.layer.masksToBounds = false
    }
    
}
