//
//  SideMenuLogoTableViewCell.swift
//  EJWhatShouldIWear
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 17/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class SideMenuLogoTableViewCell: UITableViewCell {
    
    static let identifier = "SideMenuLogoTableViewCell"
    
    // MARK: - IBOutlets
    @IBOutlet weak var logoImageView: UIImageView!
    
    // MARK: - Contraints

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addShadow()
    }
    
    // MARK: - Private Method
    private func addShadow() {
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shadowOpacity = 0.05
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 2
        self.layer.masksToBounds = false
    }

}
