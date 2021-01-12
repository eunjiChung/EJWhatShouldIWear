//
//  EJProductCollectionViewCell.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2021/01/12.
//  Copyright © 2021 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

final class EJProductCollectionViewCell: UICollectionViewCell {

    static let id = "EJProductCollectionViewCell"

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var mallLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        productLabel.textColor = titleColor
    }

}
