//
//  LocationViewController.swift
//  EJWhatShouldIWear
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 28/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class EJLocationViewController: EJBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTouchBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
