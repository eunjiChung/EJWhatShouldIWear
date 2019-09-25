//
//  ClothCollectionViewCell.swift
//  EJWhatShouldIWear
//
//  Created by eunji on 25/09/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class ClothCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ClothCollectionViewCell"
    
    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var bottomImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
