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
    
    // MARK : - Global instance
    let composeVC = MFMailComposeViewController()
    var location: String = "알 수 없는 지역"
    
    lazy var locationManager: CLLocationManager = {
        let m = CLLocationManager()
        m.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        return m
    }()
    
    
    // MARK : - View Life Cycle    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK : - Location Method
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
    
    
    // MARK : - Instance for View Controller
    func sendEmailWithCompose() {
        if MFMailComposeViewController.canSendMail() {
            composeVC.mailComposeDelegate = self as MFMailComposeViewControllerDelegate
            composeVC.setToRecipients(["twih1203@gmail.com"])
            composeVC.setSubject("건의 드립니다.")
            composeVC.setMessageBody("불편사항 건의 드립니다~", isHTML: false)
            
            self.present(composeVC, animated: true, completion: nil)
        } else {
            popAlertVC(self, with: "메일 앱 미구성!", "아이폰 메일앱에 보내는 분 정보를 넣어주세요")
        }
    }
   
    // MARK : - MFMailComposeViewControllerDelegate
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    
    // MARK : - Alert Controller
    func popAlertVC(_ controller: UIViewController, with title:String, _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        controller.present(alert, animated: true, completion: nil)
    }
    
    
    
    // MARK : - Pull To Refresh
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
