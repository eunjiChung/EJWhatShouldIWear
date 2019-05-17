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
    
    // MAKR : - Alc Of Constraints
    @IBOutlet weak var alcLeadingOfFeedbackLabel: NSLayoutConstraint!
    @IBOutlet weak var alcWidthOfFeedBackImageView: NSLayoutConstraint!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        alcLeadingOfFeedbackLabel.constant = EJSize(16.0)
        alcWidthOfFeedBackImageView.constant = EJSize(52.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
