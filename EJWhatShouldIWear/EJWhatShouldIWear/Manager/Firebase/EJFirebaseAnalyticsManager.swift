//
//  EJFirebaseAnalyticsManager.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2021/01/18.
//  Copyright © 2021 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Foundation
import Firebase

final class EJFirebaseAnalyticsManager: NSObject {

    private override init() { super.init() }

    static func firebaseLogEvent(_ name: String, param: [String: Any]? = nil) {
        #if DEBUG
        EJLogger.d("--------------------------")
        EJLogger.d("Firebase Log Event Name: \(name)")
        if let param = param {
            EJLogger.d("Firebase Log Event Param: \(param.description)")
        }
        #endif
        Analytics.logEvent(name, parameters: param)
    }

    static func firebaseLogScreen(_ name: String, fileName: String = #file) {
        #if DEBUG
        EJLogger.d("------------------------")
        EJLogger.d("Firebase Log Screen Name: \(name)")
        #endif

        let screenClass = EJLogger.sourceFileName(filePath: fileName)

        Analytics.logEvent(AnalyticsEventScreenView,
        parameters: [AnalyticsParameterScreenName: name,
                     AnalyticsParameterScreenClass: screenClass])
    }
}
