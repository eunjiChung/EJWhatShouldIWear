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
    
    // MAKR: - IBOutlets
    @IBOutlet weak var mailLabel: UILabel!
    
    // MARK: - Layout constraints
    @IBOutlet weak var alcTopOfImageView: NSLayoutConstraint!
    @IBOutlet weak var alcBottomOfImageView: NSLayoutConstraint!
    @IBOutlet weak var alcLeadingOfImageView: NSLayoutConstraint!
    @IBOutlet weak var alcTrailingOfLabel: NSLayoutConstraint!
    @IBOutlet weak var alcLeadingOfLabel: NSLayoutConstraint!
    @IBOutlet weak var alcWidthOfImageView: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mailLabel.text = LocalizedString(with: "send_mail")
        mailLabel.adjustsFontSizeToFitWidth = true
        mailLabel.minimumScaleFactor = 0
        
        alcTopOfImageView.constant = EJSizeHeight(27.0)
        alcBottomOfImageView.constant = EJSizeHeight(27.0)
        alcLeadingOfImageView.constant = EJSize(21.0)
        alcTrailingOfLabel.constant = EJSize(21.0)
        alcLeadingOfLabel.constant = EJSize(9.0)
        alcWidthOfImageView.constant = EJSize(24.0)
        
    }


}
