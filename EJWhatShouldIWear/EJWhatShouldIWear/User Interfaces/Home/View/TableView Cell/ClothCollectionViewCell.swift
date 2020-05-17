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
    
    // MARK: - IBOutlets
    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    let attribute = ["더위타는 편이면", "추위타는 편이면"]

    func setCloth(_ name: String) {
        topImage.image = UIImage(named: name)
        descriptionLabel.text = name.localized
    }
    
    
}
