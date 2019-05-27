//
//  BaseViewController.swift
//  EJWhatShouldIWear
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 13/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit
import MessageUI

// MARK : - Define Layout Constant

// MARK : - Define Segue Identifier

class EJBaseViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    let composeVC = MFMailComposeViewController()
    
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
//    func addPullToRefreshControl(toScrollView: UIScrollView, completionHandler: @escaping () -> ()) {
//        YHGCDMainAsync {
//            toScrollView.es.addPullToRefresh {
//                YHGCDMainAsync {
//                    completionHandler()
//                }
//            }
//        }
//    }
//
//    // @param toScrollView : TableView or Collection View
//    func stopPullToRefresh(toScrollView: UIScrollView) {
//        YHGCDMainAsync {
//            toScrollView.es.stopPullToRefresh()
//        }
//    }

}
