//
//  DeveloperTableViewCell.swift
//  EJWhatShouldIWear
//
//  Created by eunji on 23/08/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class DeveloperTableViewCell: UITableViewCell {
    
    @IBOutlet weak var InfoTitleLabel: UILabel!
    @IBOutlet weak var infoDescriptionLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
