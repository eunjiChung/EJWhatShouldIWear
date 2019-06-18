//
//  EJShareViewController.swift
//  EJWhatShouldIWear
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 29/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class EJShareViewController: EJBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTouchBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // 카카오톡 공융하기 기능 추가...
    
}
