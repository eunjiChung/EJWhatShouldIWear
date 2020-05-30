//
//  EJNameTableViewCell.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/05/01.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class EJNameTableViewCell: UITableViewCell {

    static let identifier = "EJNameTableViewCell"
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var checkImageview: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        locationLabel.text = "Show current location weather".localized
    }

}
