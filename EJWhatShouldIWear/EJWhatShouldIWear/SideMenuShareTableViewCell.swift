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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        shareLabel.text = LocalizedString(with: "share")
    }
}
