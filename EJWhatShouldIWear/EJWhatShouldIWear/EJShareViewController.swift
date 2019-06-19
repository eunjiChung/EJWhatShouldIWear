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
    // 카카오톡 공융하기 기능 수정...
    @IBAction func didTouchShareBtn(_ sender: Any) {
        
        // Location 타입 템플릿 오브젝트 생성
        let template = KMTLocationTemplate { (locationTemplateBuilder) in
            
            // 주소
            locationTemplateBuilder.address = "경기 성남시 분당구 판교역로 235 에이치스퀘어 N동 8층"
            locationTemplateBuilder.addressTitle = "카카오 판교오피스 카페톡"
            
            // 컨텐츠
            // KMTContentObject는 템플릿의 컨텐츠를 설정
            locationTemplateBuilder.content = KMTContentObject(builderBlock: { (contentBuilder) in
                contentBuilder.title = self.titleLabel.text ?? "오늘모입지?"
                contentBuilder.desc = self.mainLabel.text ?? "따숩게 입어~💝"
                contentBuilder.imageURL = URL(string: "http://mud-kage.kakao.co.kr/dn/bSbH9w/btqgegaEDfW/vD9KKV0hEintg6bZT4v4WK/kakaolink40_original.png")!
                contentBuilder.link = KMTLinkObject(builderBlock: { (linkBuilder) in
                    linkBuilder.mobileWebURL = URL(string: "https://developers.kakao.com")  // 등록된 도메인을 써라...
                })
            })
            
            // 소셜
            locationTemplateBuilder.social = KMTSocialObject(builderBlock: { (socialBuilder) in
                socialBuilder.likeCount = 286
                socialBuilder.commnentCount = 45
                socialBuilder.sharedCount = 845
            })
        }
        
        // 서버에서 콜백으로 받을 정보
        let serverCallbackArgs = ["user_id": "abcd",
                                  "product_id": "1234"]
        
        // 카카오링크 실행
        KLKTalkLinkCenter.shared().sendDefault(with: template, serverCallbackArgs: serverCallbackArgs, success: { (warningMsg, argumentMsg) in
            
            // 성공
            print("warning message: \(String(describing: warningMsg))")
            print("argument message: \(String(describing: argumentMsg))")
            
        }, failure: { (error) in
            
            // 실패
            print("error \(error)")
            
        })
        
    }
    
}
