//
//  SideMenuShareTableViewCell.swift
//  EJWhatShouldIWear
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 17/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class SideMenuShareTableViewCell: UITableViewCell {
    
    static let identifier = "SideMenuShareTableViewCell"
    
    // MARK: - IBOutlets
    @IBOutlet weak var shareImageView: UIImageView!
    @IBOutlet weak var shareLabel: UILabel!
    
    // MARK: - Alc Of Constraints
    @IBOutlet weak var alcLeadingOfShareImageView: NSLayoutConstraint!
    @IBOutlet weak var alcTopOfImageView: NSLayoutConstraint!
    @IBOutlet weak var alcBottomOfImageView: NSLayoutConstraint!
    @IBOutlet weak var alcWidthOfImageView: NSLayoutConstraint!
    @IBOutlet weak var alcLeadingOfShareLabel: NSLayoutConstraint!
    @IBOutlet weak var alcTrailingOfShareLabel: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        shareLabel.text = LocalizedString(with: "share")
        shareLabel.adjustsFontSizeToFitWidth = true
        shareLabel.minimumScaleFactor = 0
        
        alcLeadingOfShareLabel.constant = EJSize(9.0)
        alcTrailingOfShareLabel.constant = EJSize(21.0)
        alcBottomOfImageView.constant = EJSizeHeight(27.0)
        alcTopOfImageView.constant = EJSizeHeight(27.0)
        alcLeadingOfShareImageView.constant = EJSize(21.0)
        alcWidthOfImageView.constant = EJSize(23.0)
        
        
    }
}
