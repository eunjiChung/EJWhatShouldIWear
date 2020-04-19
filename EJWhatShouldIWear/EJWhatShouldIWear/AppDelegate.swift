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
        // Override point for customization after application launch.
        
        // iOS 다크모드 일단 방지
        if #available(iOS 13.0, *) {
            self.window?.overrideUserInterfaceStyle = .light
        }

        // FirebaseApp config 설정
        FirebaseApp.configure()
        
        // Initialize Google Mobile Ads SDK
        GADMobileAds.sharedInstance().start(completionHandler: nil)

        return true
    }

    func applicationDidFinishLaunching(_ application: UIApplication) {
    }
}

