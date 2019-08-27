//
//  InstagramTableViewCell.swift
//  EJWhatShouldIWear
//
//  Created by eunji on 23/08/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class InstagramTableViewCell: UITableViewCell {
    
    @IBOutlet weak var infoTitleLabel: UILabel!
    @IBOutlet weak var tableButton: UIButton!
    
    var typeOfButton: String?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    @IBAction func didTouchButton(_ sender: Any) {
        print("Touched Instagram Button")
    }
    
}
