//
//  InfoTableViewCell.swift
//  EJWhatShouldIWear
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 16/07/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class EJInfoTableViewCell: UITableViewCell {
    
    static let identifier = "InfoTableViewCell"

    @IBOutlet weak var alcLeadingOfTextLabel: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        alcLeadingOfTextLabel.constant = EJSize(21.0)
        titleLabel.text = "setting_info".localized
    }
}
