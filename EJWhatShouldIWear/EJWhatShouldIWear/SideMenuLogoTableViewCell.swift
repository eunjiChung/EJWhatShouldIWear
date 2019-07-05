//
//  SideMenuLogoTableViewCell.swift
//  EJWhatShouldIWear
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 17/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class SideMenuLogoTableViewCell: UITableViewCell {
    
    static let identifier = "SideMenuLogoTableViewCell"
    
    // MARK: - IBOutlets
    @IBOutlet weak var logoImageView: UIImageView!
    
    // MARK: - Contraints
    @IBOutlet weak var alcHeightOfWSIWLabel: NSLayoutConstraint!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        alcHeightOfWSIWLabel.constant = EJSize(48.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
