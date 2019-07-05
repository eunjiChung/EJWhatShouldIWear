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
    
    // MARK: - Alc Of Constraints
    @IBOutlet weak var alcWidthOfSettingImageView: NSLayoutConstraint!
    @IBOutlet weak var alcLeadingOfSettingLabel: NSLayoutConstraint!
    @IBOutlet weak var setLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        alcWidthOfSettingImageView.constant = EJSize(28.0)
        alcLeadingOfSettingLabel.constant = EJSize(16.0)
        setLabel.text = LocalizedString(with: "setting")
    }
}
