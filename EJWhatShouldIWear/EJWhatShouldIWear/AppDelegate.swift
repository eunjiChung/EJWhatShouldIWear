//
//  AppDelegate.swift
//  EJWhatShouldIWear
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 31/01/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit
import GoogleMobileAds
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        disableDarkMode()
        
        // FirebaseApp config 설정
        FirebaseApp.configure()
        // Initialize Google Mobile Ads SDK
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        // 한국 지역 런칭
        EJLocationManager.shared.setDefaultKoreaLocationList()
        EJLocationManager.shared.setRegionId()
        
        setInitialView()
        
        return true
    }
    
    private func disableDarkMode() {
        if #available(iOS 13.0, *) {
            self.window?.overrideUserInterfaceStyle = .light
        }
    }
    
    private func setInitialView() {
        guard let splashVC = UIStoryboard(name: "Welcome", bundle: nil).instantiateInitialViewController() as? EJSplashViewController else { return }
        window?.rootViewController = splashVC
        window?.makeKeyAndVisible()
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    func applicationDidFinishLaunching(_ application: UIApplication) {
        
    }
}

