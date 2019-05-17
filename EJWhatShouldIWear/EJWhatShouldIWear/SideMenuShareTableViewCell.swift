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
        // Initialization code
        alcWidthOfShareImageView.constant = EJSize(52.0)
        alcLeadingOfShareLabel.constant = EJSize(16.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
