//
//  MySideMenuNavigationController.swift
//  EJWhatShouldIWear
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 10/06/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit
import SideMenu

class MySideMenuNavigationController: UISideMenuNavigationController {

    let customSideMenuManager = SideMenuManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        sideMenuManager = customSideMenuManager
    }
    
    // MARK: - Custom SideMenu Navigation Controller
    // 다른 destination으로 가도록 custom 설정...
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let sideMenuNavigationController = segue.destination as? UISideMenuNavigationController {
            sideMenuNavigationController.sideMenuManager = customSideMenuManager
        }
    }

}
