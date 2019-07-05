//
//  EJSettingViewController.swift
//  EJWhatShouldIWear
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 16/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit
import CoreLocation

class EJSettingViewController: EJBaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Instance
    var curLocation : String? = nil
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - IBOutlet Action
    @IBAction func didTouchBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - TableView Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "LocationTableViewCell", for: indexPath) as! LocationTableViewCell
            
            cell.myLocationLabel.text = curLocation
            
            return cell
        default:
            return tableView.dequeueReusableCell(withIdentifier: "AlarmTableViewCell", for: indexPath)
        }
    }
    
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return EJSize(70.0)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            self.performSegue(withIdentifier: "showLocationSegue", sender: self)
        default:
            print("Nothing...")
        }
    }
 
}
