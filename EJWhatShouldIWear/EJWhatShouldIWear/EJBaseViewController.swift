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

// MARK : - Define Layout Constant

// MARK : - Define Segue Identifier

class EJBaseViewController: UIViewController, MFMailComposeViewControllerDelegate, CLLocationManagerDelegate {
    
    // MARK : - Public Instance
    let composeVC = MFMailComposeViewController()
    static var currentLocation : String!
    
    lazy var locationManager: CLLocationManager = {
        let m = CLLocationManager()
        m.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        m.delegate = self as CLLocationManagerDelegate
        return m
    }()
    
    
    // MARK : - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    // MARK : - CLLocationMAnagerDelegate
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
    
    
    // 얘 정보를 어떻게 넘겨줄까....?
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let current = locations.last {
            // current.coordinate = 위도와 경도 정보 저장
            
            let geoCoder = CLGeocoder()
            geoCoder.reverseGeocodeLocation(current) { (list, error) in
                if let error = error {
                    print(error)
                } else {
                    if let first = list?.first {
                        if let gu = first.locality, let dong = first.subLocality {
//                            self.currentLocation = ("\(gu) \(dong)")
                        } else {
                            print("알 수 없는 지역")
                        }
                    }
                }
            }
        }
        
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            updateLocation()
        default:
            print("error")
        }
    }
    
    // MARK : - MFMailComposeViewControllerDelegate
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        // 보류...
//        if result == MFMailComposeResult.sent {
//            print("sent")
//            popAlertVC(controller, with: "메일 전송 완료", "소중한 의견 감사합니다.\n 앱 발전에 반영하겠습니다 ^^")
//        } else if result == MFMailComposeResult.saved {
//            print("saved")
//            popAlertVC(controller, with: "저장 완료", "메일을 저장하였습니다")
//        } else if result == MFMailComposeResult.cancelled {
//            print("canceled")
//            popAlertVC(controller, with: "작성 취소", "메일 작성을 취소하였습니다")
//        }
        
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
