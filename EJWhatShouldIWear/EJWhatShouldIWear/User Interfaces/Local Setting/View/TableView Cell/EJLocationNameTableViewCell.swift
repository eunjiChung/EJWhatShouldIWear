//
//  EJLocationNameTableViewCell.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/05/01.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class EJLocationNameTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var checkImageView: UIImageView!
    
    // MARK: - Properties
    static let identifier = "EJLocationNameTableViewCell"

    // MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
