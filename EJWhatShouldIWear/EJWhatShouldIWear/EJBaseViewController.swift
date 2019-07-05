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
import CoreLocation



// MARK : - Define Segue Identifier
let EJSegueSetting                      = "setting_segue"


class EJBaseViewController: UIViewController, MFMailComposeViewControllerDelegate{
    
    // MARK: - Global instance
    let composeVC = MFMailComposeViewController()
    var location: String = LocalizedString(with: "unknown")
    
    lazy var locationManager: CLLocationManager = {
        let m = CLLocationManager()
        m.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        return m
    }()
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Location Method
    func checkLocationStatus() {
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse:
            updateLocation()
        default:
            print("location miss")
        }
    }
    
    func updateLocation() {
        locationManager.startUpdatingLocation()
    }
    
    
    // MARK: - Instance for View Controller
    func sendEmailWithCompose() {
        if MFMailComposeViewController.canSendMail() {
            composeVC.mailComposeDelegate = self as MFMailComposeViewControllerDelegate
            composeVC.setToRecipients(["twih1203@gmail.com"])
            composeVC.setSubject(LocalizedString(with: "send_title"))
            composeVC.setMessageBody(LocalizedString(with: "send_message"), isHTML: false)
            
            self.present(composeVC, animated: true, completion: nil)
        } else {
            popAlertVC(self, with: LocalizedString(with: "mail_warning_title"), LocalizedString(with: "mail_warning_message"))
        }
    }
   
    // MARK: - MFMailComposeViewControllerDelegate
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    
    // MARK: - Alert Controller
    func popAlertVC(_ controller: UIViewController, with title:String, _ message: String) {
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

}
