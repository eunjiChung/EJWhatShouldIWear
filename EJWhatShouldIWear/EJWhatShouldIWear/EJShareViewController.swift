//
//  EJShareViewController.swift
//  EJWhatShouldIWear
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 29/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class EJShareViewController: EJBaseViewController, UITextFieldDelegate {
    
    // MARK : - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var alcBottomOfSendBtn: NSLayoutConstraint!
    
    // MARK : - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textField.placeholder = "데일리룩은 <오늘모입지?>와 함께하세요!"
        registerKeyboardNotification()
    }
    
    // MARK : - KeyBoard Related Method
    func registerKeyboardNotification () {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        alcBottomOfSendBtn.constant = EJSize(290.0)
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        alcBottomOfSendBtn.constant = EJSize(10.0)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    // MARK : - Action Method
    @IBAction func didTouchBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK : - Kakao Share Link Method
    @IBAction func didTouchShareBtn(_ sender: Any) {
        
        let template = KMTFeedTemplate { (feedTemplateBuilder) in
            
            feedTemplateBuilder.content = KMTContentObject(builderBlock: { (contentBuilder) in
                contentBuilder.title = self.titleLabel.text ?? "오늘모입지?"
                contentBuilder.desc = self.textField.text ?? self.textField.placeholder
                contentBuilder.imageURL = URL(string: "file:///Users/ios-junior/Documents/TEST/KakaoTest/KakaoTest/Assets.xcassets/RoundedIcon.imageset/RoundedIcon.png")! // ...?
                contentBuilder.link = KMTLinkObject(builderBlock: { (linkeBuilder) in
                    linkeBuilder.iosExecutionParams = "com.eunji.EJWhatShouldIWear" // App Store URL이 들어가야 함
                })
            })
            
            feedTemplateBuilder.addButton(KMTButtonObject.init(builderBlock: { (buttonBuilder) in
                buttonBuilder.title = "앱에서 보기"
                buttonBuilder.link = KMTLinkObject(builderBlock: { (linkeBuilder) in
                    linkeBuilder.iosExecutionParams = "com.eunji.EJWhatShouldIWear" // App Store URL이 들어가야 함
                })
            }))
            
        }
        
        KLKTalkLinkCenter.shared().sendDefault(with: template, success: { (warningMsg, argumentMsg) in
            
            // 성공
            print("warning message: \(String(describing: warningMsg))")
            print("argument message: \(String(describing: argumentMsg))")
            
        }) { (error) in
            // 실패
            print("error \(error)")
        }
        
        
    }
    
}
