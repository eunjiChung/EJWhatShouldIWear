//
//  EJDrawerBackgroundViewController.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/07/08.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class EJDrawerBackgroundViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        performSegue(withIdentifier: "showDrawer", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? EJDrawerViewController {
            dest.didTapBackground = {
                self.navigationController?.dismiss(animated: true, completion: nil)
                self.navigationController?.popViewController(animated: true)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}
