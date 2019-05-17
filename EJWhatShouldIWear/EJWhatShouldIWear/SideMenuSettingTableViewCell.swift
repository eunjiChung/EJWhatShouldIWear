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
    
    // MARK : - Alc Of Constraints
    @IBOutlet weak var alcWidthOfSettingImageView: NSLayoutConstraint!
    @IBOutlet weak var alcLeadingOfSettingLabel: NSLayoutConstraint!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        alcWidthOfSettingImageView.constant = EJSize(52.0)
        alcLeadingOfSettingLabel.constant = EJSize(16.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
