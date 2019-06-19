//
//  EJShareViewController.swift
//  EJWhatShouldIWear
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 29/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class EJShareViewController: EJBaseViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainLabel: UILabel!
    

    // MARK : - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        titleLabel.text = "사랑하는 오빠에게"
        mainLabel.text = "옷 따뜻하게 입고다녀~!"
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
                contentBuilder.desc = self.mainLabel.text ?? "오늘모입지 앱을 사용해보세요:)"
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
