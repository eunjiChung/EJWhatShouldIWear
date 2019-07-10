//
//  SideMenuSettingTableViewCell.swift
//  EJWhatShouldIWear
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 17/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class SideMenuSettingTableViewCell: UITableViewCell {
    
    static let identifier = "SideMenuSettingTableViewCell"
    
    // MARK: - IBOutlet
    @IBOutlet weak var setLabel: UILabel!
    
    // MARK: - Alc Of Constraints
    @IBOutlet weak var alcLeadingOfImageView: NSLayoutConstraint!
    @IBOutlet weak var alcTopOfImageView: NSLayoutConstraint!
    @IBOutlet weak var alcBottomOfImageView: NSLayoutConstraint!
    @IBOutlet weak var alcWidthOfImageView: NSLayoutConstraint!
    @IBOutlet weak var alcLeadingOfLabel: NSLayoutConstraint!
    @IBOutlet weak var alcTrailingOfLabel: NSLayoutConstraint!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        setLabel.text = LocalizedString(with: "setting")
        setLabel.adjustsFontSizeToFitWidth = true
        setLabel.minimumScaleFactor = 0
        
        alcLeadingOfImageView.constant = EJSize(21.0)
        alcTopOfImageView.constant = EJSizeHeight(27.0)
        alcBottomOfImageView.constant = EJSizeHeight(27.0)
        alcWidthOfImageView.constant = EJSize(24.0)
        alcLeadingOfLabel.constant = EJSize(9.0)
        alcTrailingOfLabel.constant = EJSize(21.0)
    }
}
