//
//  TimeCollectionViewCell.swift
//  EJWhatShouldIWear
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 16/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class TimeCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TimeCollectionViewCell"
    
    // MARK : - Outlets
    @IBOutlet weak var clothImageView: UIImageView!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    // MARK: - Alc of Constraints
    @IBOutlet weak var alcHeightOfClothImageView: NSLayoutConstraint!
    @IBOutlet weak var alcHeightOfTempLabel: NSLayoutConstraint!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        alcHeightOfClothImageView.constant = EJSize(120.0)
        alcHeightOfTempLabel.constant = EJSize(15.0)
    }

}
