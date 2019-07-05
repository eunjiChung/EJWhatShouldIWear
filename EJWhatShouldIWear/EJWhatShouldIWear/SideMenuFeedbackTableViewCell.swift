//
//  SideMenuFeedbackTableViewCell.swift
//  EJWhatShouldIWear
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 17/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class SideMenuFeedbackTableViewCell: UITableViewCell {
    
    static let identifier = "SideMenuFeedbackTableViewCell"
    
    // MAKR: - Alc Of Constraints
    @IBOutlet weak var alcLeadingOfFeedbackLabel: NSLayoutConstraint!
    @IBOutlet weak var alcWidthOfFeedBackImageView: NSLayoutConstraint!
    @IBOutlet weak var mailLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        alcLeadingOfFeedbackLabel.constant = EJSize(16.0)
        alcWidthOfFeedBackImageView.constant = EJSize(28.0)
        mailLabel.text = LocalizedString(with: "send_mail")
    }


}
