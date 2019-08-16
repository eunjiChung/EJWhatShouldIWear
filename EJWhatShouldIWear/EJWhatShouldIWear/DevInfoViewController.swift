//
//  DevInfoViewController.swift
//  EJWhatShouldIWear
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 16/07/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class DevInfoViewController: UIViewController {

    
    @IBOutlet weak var alcTopOfStackView: NSLayoutConstraint!
    @IBOutlet weak var alcTopOfTextLabel: NSLayoutConstraint!
    @IBOutlet weak var alcTopOfCopyRight: NSLayoutConstraint!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        alcTopOfStackView.constant = EJSizeHeight(277.0)
        alcTopOfTextLabel.constant = EJSizeHeight(130.0)
        alcTopOfCopyRight.constant = EJSizeHeight(56.0)
    }
    
    @IBAction func didTouchBackBtn(_ sender: Any) {
        Library.selectionHapticFeedback()
        self.dismiss(animated: true, completion: nil)
    }
}
