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
    
    // MARK : - IBOutlets
    @IBOutlet weak var shareImageView: UIImageView!
    @IBOutlet weak var shareLabel: UILabel!
    
    // MARK : - Alc Of Constraints
    @IBOutlet weak var alcWidthOfShareImageView: NSLayoutConstraint!
    @IBOutlet weak var alcLeadingOfShareLabel: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        alcWidthOfShareImageView.constant = EJSize(28.0)
        alcLeadingOfShareLabel.constant = EJSize(16.0)
        shareLabel.text = LocalizedString(with: "share")
    }
}
