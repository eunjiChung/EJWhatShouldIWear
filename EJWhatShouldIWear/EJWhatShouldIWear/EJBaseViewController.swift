//
//  BaseViewController.swift
//  EJWhatShouldIWear
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 13/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit
import MessageUI
import ESPullToRefresh
import Firebase
import SwiftyJSON



// MARK : - Define Segue Identifier
let EJSegueSetting                      = "setting_segue"

class EJBaseViewController: UIViewController, MFMailComposeViewControllerDelegate{
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Status Bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    // MARK: - Instance for View Controller
    func sendEmailWithCompose() {
        if MFMailComposeViewController.canSendMail() {
            let composeVC = MFMailComposeViewController()
            composeVC.mailComposeDelegate = self as MFMailComposeViewControllerDelegate
            composeVC.setToRecipients(["twih1203@gmail.com"])
            composeVC.setSubject(LocalizedString(with: "send_title"))
            composeVC.setMessageBody(LocalizedString(with: "send_message"), isHTML: false)
            
            self.present(composeVC, animated: true, completion: nil)
        } else {
            popAlertVC(self, title: LocalizedString(with: "mail_warning_title"), message: LocalizedString(with: "mail_warning_message"))
        }
    }
   
    // MARK: - MFMailComposeViewControllerDelegate
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    
    // MARK: - Alert Controller
    func popAlertVC(_ controller: UIViewController, title:String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: LocalizedString(with: "btn_ok"), style: .default, handler: nil))
        controller.present(alert, animated: true, completion: nil)
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
    
    
    
    // MARK: Firebase Remote Config
    func requestAppVersionInfo() {
        self.firebaseRemote({ (success) in
            
            if success {
                self.successCompletionOfReqAppVersionInfoWithResult()
            } else {
                // No need to update
            }
        }) { (error) in
            if let error = error {
                self.popAlertVC(self, title: "", message: error.localizedDescription)
            }
        }
    }
    
    fileprivate func firebaseRemote(_ success: @escaping (_ success: Bool) -> Void,
                        failure: @escaping (_ error: Error?) -> Void) {
        let remoteConfig = RemoteConfig.remoteConfig()
        
        #if DEBUG
        let remoteConfigSetting = RemoteConfigSettings(developerModeEnabled: true)
        remoteConfig.configSettings = remoteConfigSetting
        #endif
        
        var expirationDuration: TimeInterval = 3600
        if remoteConfig.configSettings.isDeveloperModeEnabled {
            expirationDuration = 0
        }
        
        remoteConfig.fetch(withExpirationDuration: expirationDuration) { (status, error) in
            if status == .success {
                remoteConfig.activateFetched()
                
                let value: RemoteConfigValue = remoteConfig["validate_version"]
                
                do {
                    let data: JSON = try JSON(data: value.dataValue)
                    let validBuildVersion: Int = data["build_version"].intValue
                    let required: Bool = data["required"].boolValue
                    
                    guard let currentBuildVersion = Int(Library.buildVersion()) else { return }
                    
                    if currentBuildVersion < validBuildVersion {
                        if required {
                            success(true)
                        } else {
                            success(false)
                        }
                    } else {
                        failure(error)
                    }
                } catch {
                    
                }
            } else {
                print("Config not fetched")
                
                if let error = error {
                    failure(error)
                }
            }
        }
    }
    
    fileprivate func successCompletionOfReqAppVersionInfoWithResult() {
        DispatchQueue.main.async {
//            let alertController = UIAlertController.init(title: LocalizedString(with: "dialog_btn_update"), message: LocalizedString(with: "dialog_msg_force_update"), preferredStyle: .alert)
//            let updateAction = UIAlertAction.init(title: LocalizedString(with: "dialog_btn_update"), style: .default, handler: { (alertAction) in
//                self.moveToAppStore(storeId: "")
//            })
//            let cancelAction = UIAlertAction.init(title: LocalizedString(with: "dialog_btn_cancel"), style: .cancel, handler: { (alertAction) in
//            })
            let alertController = UIAlertController.init(title: "업데이트", message: "최신버전으로 업데이트를 진행하시겠습니까?", preferredStyle: .alert)
            let updateAction = UIAlertAction.init(title: "Update", style: .default, handler: { (alertAction) in
                self.moveToAppStore(storeId: appStoreID)
            })
            let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: { (alertAction) in
            })
            
            alertController.addAction(updateAction)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }

    fileprivate func moveToAppStore(storeId: String?) {
        DispatchQueue.main.async {
            if storeId != nil {
                self.openAppStore(withIdentifier: storeId!, completionHandler:{})
            } else {
                print("'storeId is nil!'")
            }
        }
    }
    
    func openAppStore(withIdentifier: String, completionHandler: @escaping () -> Void) {
        
        let storeViewController = SKStoreProductViewController()
        
        storeViewController.delegate = self as? SKStoreProductViewControllerDelegate
        storeViewController.loadProduct(withParameters: [SKStoreProductParameterITunesItemIdentifier : withIdentifier],
                                        completionBlock: { (success, error) in
                                            
                                            if success {
                                                completionHandler()
                                            }
        })
        
        self.present(storeViewController, animated: true, completion: nil)
    }
}
