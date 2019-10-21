//
//  AlarmDetailTableViewCell.swift
//  EJWhatShouldIWear
//
//  Created by CHUNGEUNJI on 22/10/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class AlarmDetailTableViewCell: UITableViewCell {
    
    // MARk: - Identifier
    static let identifier = "AlarmDetailTableViewCell"
    
    // MARK: - IBOutlets
    @IBOutlet weak var datePickerView: UIDatePicker!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
