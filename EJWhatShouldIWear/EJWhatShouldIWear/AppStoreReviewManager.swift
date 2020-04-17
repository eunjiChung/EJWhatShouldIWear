//
//  AppStoreReviewManager.swift
//  EJWhatShouldIWear
//
//  Created by eunji on 25/09/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import StoreKit

enum AppStoreReviewManager {
    
    static let minimumReviewWorthyActionCount = 3
    
    static func requestReviewIfAppropriate() {
        let defaults = UserDefaults.standard
        var actionCount = defaults.integer(forKey: .reviewWorthyActionCount)
        
        actionCount += 1
        defaults.set(actionCount, forKey: .reviewWorthyActionCount)
        
        guard actionCount == minimumReviewWorthyActionCount else { return }
        
        SKStoreReviewController.requestReview()
        defaults.set(4, forKey: .reviewWorthyActionCount)
    }
}
