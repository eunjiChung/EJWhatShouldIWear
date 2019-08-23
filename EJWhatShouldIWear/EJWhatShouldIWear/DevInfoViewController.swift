//
//  DevInfoViewController.swift
//  EJWhatShouldIWear
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 16/07/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class DevInfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func didTouchBackBtn(_ sender: Any) {
        Library.selectionHapticFeedback()
        self.dismiss(animated: true, completion: nil)
    }
}
