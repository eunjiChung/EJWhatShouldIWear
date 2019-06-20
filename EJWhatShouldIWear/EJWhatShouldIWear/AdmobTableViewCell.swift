//
//  AdmobTableViewCell.swift
//  EJWhatShouldIWear
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 16/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit
import GoogleMobileAds

class AdmobTableViewCell: UITableViewCell {
    
    static let identifier = "AdmobTableViewCell"
    var banner: GADBannerView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let bounds = UIScreen.main.bounds
        let screenWidth = bounds.width
        let size = CGSize.init(width: screenWidth, height: EJSize(60.0))
        banner = GADBannerView(adSize: GADAdSizeFromCGSize(size))
        self.addSubview(banner)
    }

    // MARK : - Admob Method
    func createAdmob(_ viewController: UIViewController) {
        banner.adUnitID = googleAdmobUnitID
        banner.rootViewController = viewController
        banner.load(GADRequest())
    }
    
}
