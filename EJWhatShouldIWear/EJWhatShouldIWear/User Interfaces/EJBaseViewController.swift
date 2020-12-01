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

class EJBaseViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    var selectionFeedbackGenerator = UISelectionFeedbackGenerator()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Status Bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
    
    // MARK: - User Feedback
    func selectionHapticFeedback() {
        selectionFeedbackGenerator.selectionChanged()
    }
    
    // MARK: - Alert Controller
    func popAlertVC(_ controller: UIViewController, title:String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "btn_ok".localized, style: .default, handler: nil))
        controller.present(alert, animated: true, completion: nil)
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
        let remoteConfigSetting = RemoteConfigSettings()
        remoteConfig.configSettings = remoteConfigSetting
        #endif
        
        let expirationDuration: TimeInterval = 3600
        remoteConfig.fetch(withExpirationDuration: expirationDuration) { (status, error) in
            if status == .success {
                remoteConfig.activate(completion: nil)
                
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
                // Config not fetched
                if let error = error { failure(error) }
            }
        }
    }
    
    fileprivate func successCompletionOfReqAppVersionInfoWithResult() {
        DispatchQueue.main.async {
            let alertController = UIAlertController.init(title: "update_title".localized, message: "update_message".localized, preferredStyle: .alert)
            let updateAction = UIAlertAction.init(title: "update_title".localized, style: .default, handler: { (alertAction) in
                self.moveToAppStore(storeId: "")
            })
            let cancelAction = UIAlertAction.init(title: "btn_cancel".localized, style: .cancel, handler: { (alertAction) in
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
                EJLogger.w("'storeId is nil!'")
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
