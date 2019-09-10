//
//  EJLibrary.swift
//  EJWhatShouldIWear
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 17/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit
import UserNotifications
import ESPullToRefresh

// MARK: - App Store URL
public let AppStoreURL                          =   "https://apps.apple.com/kr/app/%EC%98%A4%EB%8A%98%EB%AA%A8%EC%9E%85%EC%A7%80/id1469342013"
public let appStoreID                           =   "1469342013"

// MARK: - Google Admob
public let googleAdmobAppID                     =   "ca-app-pub-1994779937843028~3906710093"
public let googleAdmobUnitID                    =   "ca-app-pub-1994779937843028/3973448265"
//public let googleAdmobUnitID                    =   "ca-app-pub-3940256099942544/2934735716" // Google's TestID

// MARK: - Screen Size
public let EJ_SCREEN_WIDTH: CGFloat             =   UIScreen.main.bounds.width
public let EJ_SCREEN_HEIGHT: CGFloat            =   UIScreen.main.bounds.height
public let EJ_SCREEN_HEIGHT_812 : CGFloat       =   812.0
public let EJ_SCREEN_WIDTH_414: CGFloat         =   414.0
public let EJ_SCREEN_WIDTH_375: CGFloat         =   375.0

// MARK: UserDefaults Keys
public let LOCATION_KEY : String                =   "location"
public let SWITCH_ID : String                   =   "switchState"

// MARK: - Global Instance
let Library = EJLibrary.sharedInstance
let myUserDefaults = UserDefaults.standard

// MARK: - Auto Layout
func EJSize(_ standardSize: CGFloat) -> CGFloat {
    // iPhoneX 기준으로 잡음
    return round(standardSize * (EJ_SCREEN_WIDTH / EJ_SCREEN_WIDTH_375))
}

func EJSizeHeight(_ size: CGFloat) -> CGFloat {
    return round(size * (EJ_SCREEN_HEIGHT / EJ_SCREEN_HEIGHT_812))
}

// MARK: - Localizable
func LocalizedString(with key: String) -> String {
    let localString = NSLocalizedString(key, comment: "")
    return localString
}

// MARK: - Class EJLibrary
class EJLibrary: NSObject {
    
    static let sharedInstance = EJLibrary()
    var systemLanguage = ""
    
    var selectionFeedbackGenerator = UISelectionFeedbackGenerator()
    
    override init() {
        let locale = NSLocale.autoupdatingCurrent
        let code = locale.languageCode!
        let language = locale.localizedString(forLanguageCode: code)!
        systemLanguage = language
    }
    
    func requestNotificationAuthenticate() {
        print("requesting Notification")
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (didAllow, error) in
            print("UserNotiAutehntication!!!!!!!")
            if error == nil {
                if didAllow {
                    print("Allowing Auth")
                    myUserDefaults.set(true, forKey: SWITCH_ID)
                    Library.allowNotification()
                } else {
                    print("Disallow Auth")
                    myUserDefaults.set(false, forKey: SWITCH_ID)
                }
            } else {
                print("ERROR============================================")
                print(error as Any)
            }
        }
    }
    
    
    func allowNotification() {
        let content = UNMutableNotificationContent()
        content.title = LocalizedString(with: "APP_NAME")
        content.body = LocalizedString(with: "noti_body")
        
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
    
    
    // MARK: - User Feedback
    func selectionHapticFeedback() {
        self.selectionFeedbackGenerator.selectionChanged()
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
    
    // MARK: - Pull To Refresh
    func addPullToRefreshControl(toScrollView: UIScrollView, completionHandler: @escaping () -> ()) {
        DispatchQueue.main.async {
            toScrollView.es.addPullToRefresh {
                DispatchQueue.main.async {
                    completionHandler()
                }
            }
        }
    }
    
    func stopPullToRefresh(toScrollView: UIScrollView) {
        DispatchQueue.main.async {
            toScrollView.es.stopPullToRefresh()
        }
    }
    
    
    
}
