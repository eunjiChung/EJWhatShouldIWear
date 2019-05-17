//
//  EJSettingViewController.swift
//  EJWhatShouldIWear
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 16/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class EJSettingViewController: EJBaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK : - IBOutlet Action
    @IBAction func didTouchBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    

    // MARK : - TableView Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            return tableView.dequeueReusableCell(withIdentifier: "LocationTableViewCell", for: indexPath)
        default:
            return tableView.dequeueReusableCell(withIdentifier: "AlarmTableViewCell", for: indexPath)
        }
    }
    
    // MARK : - TableView Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return EJSize(70.0)
    }
 
}
