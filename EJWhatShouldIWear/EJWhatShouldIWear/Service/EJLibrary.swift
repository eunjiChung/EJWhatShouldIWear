//
//  EJLibrary.swift
//  EJWhatShouldIWear
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 17/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit
import UserNotifications

// MARK: - Global Instance
let Library = EJLibrary.sharedInstance

// MARK: - Class EJLibrary
class EJLibrary: NSObject {
    
    static let sharedInstance = EJLibrary()
    var systemLanguage = ""
    
    override init() {
        let locale = NSLocale.autoupdatingCurrent
        let code = locale.languageCode!
        let language = locale.localizedString(forLanguageCode: code)!
        systemLanguage = language
    }
    
    func requestNotificationAuthenticate() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (didAllow, error) in
            if error == nil {
                if didAllow {
                    // Allowing Auth
                    myUserDefaults.set(true, forKey: UserDefaultKey.switchId)
                    Library.allowNotification()
                } else {
                    // Disallow Auth
                    myUserDefaults.set(false, forKey: UserDefaultKey.switchId)
                }
            } else {
                EJLogger.e(error as Any)
            }
        }
    }
    
    func allowNotification() {
        let content = UNMutableNotificationContent()
        content.title = "APP_NAME".localized
        content.body = "noti_body".localized
        
        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        let dateString = Int(dateFormatter.string(from: today))
        
        var imageName = ""
        if let month = dateString {
            switch month {
            case 3...5:
                imageName = "blouse"
            case 6...8:
                imageName = "tshirt"
            case 9...11:
                imageName = "cardigan"
            default:
                imageName = "muffler"
            }
        }
        
        guard let imageURL = Bundle.main.url(forResource: imageName, withExtension: ".png") else { return }
        let attachment = try!  UNNotificationAttachment(identifier: imageName, url: imageURL, options: .none)
        content.attachments = [attachment]
        
        var date = DateComponents()
        date.hour = 9
        date.minute = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        
        let request = UNNotificationRequest(identifier: "test", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
    }
    
    func deniedNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    // MARK: - Device
    public func buildVersion() -> String {
        let mainBundle = Bundle.main
        return mainBundle.object(forInfoDictionaryKey: "CFBundleVersion") as! String
    }
    
    public func appVersion() -> String {
        let mainBundle = Bundle.main
        return mainBundle.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    }
    
}
