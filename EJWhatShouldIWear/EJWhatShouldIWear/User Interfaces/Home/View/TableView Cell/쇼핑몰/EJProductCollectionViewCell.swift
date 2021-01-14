//
//  EJProductCollectionViewCell.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2021/01/12.
//  Copyright © 2021 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit
import SDWebImage

final class EJProductCollectionViewCell: UICollectionViewCell {

    static let id = "EJProductCollectionViewCell"

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var mallLabel: UILabel!

    var model: EJItemModel? {
        didSet {
            guard let model = model else { return }

            if let url = URL(string: model.imageUrl) {
                imageView.sd_setImage(with: url, completed: nil)
            }
            productLabel.text = model.name
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        productLabel.textColor = titleColor
    }

}
