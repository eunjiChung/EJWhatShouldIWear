//
//  AdmobTableViewCell.swift
//  EJWhatShouldIWear
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 16/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit
import GoogleMobileAds

class AdmobTableViewCell: UITableViewCell, GADBannerViewDelegate {
    
    static let identifier = "AdmobTableViewCell"
    var banner: GADBannerView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        let size = CGSize.init(width: EJ_SCREEN_WIDTH, height: EJSizeHeight(60.0))
        banner = GADBannerView(adSize: GADAdSizeFromCGSize(size))
        banner.delegate = self
        self.addSubview(banner)
        
    }
    
    // MARK: - Admob Method
    func createAdmob(_ viewController: UIViewController) {
        banner.adUnitID = googleAdmobUnitID
        banner.rootViewController = viewController
        let request = GADRequest()
        banner.load(request)
    }
    
    // MARK: Google Admob Banner Delegate
    
    // Called when an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print(#function)
    }
    
    // Called when an ad request failed.
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        print("\(#function): \(error.localizedDescription)")
    }
    
    // Called just before presenting the user a full screen view, such as a browser, in response to
    // clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        print(#function)
    }
    
    // Called just before dismissing a full screen view.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
        print(#function)
    }
    
    // Called just after dismissing a full screen view.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
        print(#function)
    }
    
    // Called just before the application will background or terminate because the user clicked on an
    // ad that will launch another application (such as the App Store).
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        print(#function)
    }
    
}
