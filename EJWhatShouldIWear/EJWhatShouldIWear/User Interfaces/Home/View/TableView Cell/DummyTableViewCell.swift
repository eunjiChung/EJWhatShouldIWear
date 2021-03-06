//
//  DummyTableViewCell.swift
//  EJWhatShouldIWear
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 17/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class DummyTableViewCell: UITableViewCell {
    
    static let identifier = "DummyTableViewCell"
    
    @IBOutlet weak var copyrightLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        copyrightLabel.textColor = titleColor
        copyrightLabel.text = "Copyright By EunjiChung"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
