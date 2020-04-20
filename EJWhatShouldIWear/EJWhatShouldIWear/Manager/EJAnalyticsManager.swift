//
//  EJAnalyticsManager.swift
//  EJWhatShouldIWear
//
//  Created by eunji chung on 2020/04/20.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Foundation
import Firebase

final class EJAnalyticsManager: NSObject {
    
    static let shared = EJAnalyticsManager()
    
    private override init() { super.init() }
    
    func firebaseRemoteConfigSetting() {
        
    }
    
    func firebaseAnalyticsEventDidBecomeActive() {
        updateUserInfo()
        
    }
    
    func updateUserInfo() {
        // crashlytic 사용자 데이터 set
        Crashlytics.crashlytics().setUserID("")
    }
    
    func sendCustomEvent(_ name: String, param: [String: Any] = [String:Any]()) {
        // param 예시
//        let firebaseParameters: [String: Any] = ["base_price" : priceValue.string ?? "",
//                                                 AnalyticsParameterPrice : revenueValue,  // double as Number
//                                                 AnalyticsParameterContentType : contentTypeValue,
//                                                 AnalyticsParameterItemID : contentIdValue,
//                                                 AnalyticsParameterItemName : contentValue,
//                                                 AnalyticsParameterQuantity : quantityValue, // Number
//                                                 AnalyticsParameterCurrency : currencyValue,
//                                                 AnalyticsParameterTransactionID : orderIdValue,
//                                                 "prime" : primeValue,
//                                                 "pid" : pidValue,
//                                                 "title" : titleValue,
//                                                 "proposal_id" : proposalIdValue,
//                                                 "request_id" : requestIdValue,
//                                                 "additional_pay" : additionalPayValue,
//                                                 "coupon_name" : couponNameValue,
//                                                 "coupon_id" : couponId,
//                                                 "coupon_price" : couponPrice]
//
//        firebaseLogEvent(AnalyticsEventEcommercePurchase, param: firebaseParameters)
        #if DEBUG
        print("Firebase Log Event Name: \(name)")
        print("Firebase Log Event Param: \(param)")
        #endif
        Analytics.logEvent(name, parameters: param)
    }
    
    func firebaseRegisterUserInfo() {
//        Analytics.setUserID(userId)
    }
    
    func firebaseLogEvent(_ name: String, param: [String: Any]? = nil) {
        #if DEBUG
        print("Firebase Log Event Name: \(name)")
        if let param = param {
            print("Firebase Log Event Param: \(param)")
        }
        #endif
        Analytics.logEvent(name, parameters: param)
    }
    
    func firebaseLogScreen(_ name: String) {
        #if DEBUG
        print("Firebase Log Screen Name: \(name)")
        #endif
        Analytics.setScreenName(name, screenClass: nil)
    }
}
