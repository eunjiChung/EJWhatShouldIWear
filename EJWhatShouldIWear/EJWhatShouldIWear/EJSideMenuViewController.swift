//
//  EJSideMenuViewController.swift
//  EJWhatShouldIWear
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 13/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class EJSideMenuViewController: EJBaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet weak var sideMenuTableView: UITableView!
    var curLocation: String?
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - TableView Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            return tableView.dequeueReusableCell(withIdentifier: SideMenuLogoTableViewCell.identifier, for: indexPath)
        case 1:
            return tableView.dequeueReusableCell(withIdentifier: SideMenuShareTableViewCell.identifier, for: indexPath)
        case 2:
            return tableView.dequeueReusableCell(withIdentifier: SideMenuFeedbackTableViewCell.identifier, for: indexPath)
        case 3:
            return tableView.dequeueReusableCell(withIdentifier: SideMenuSettingTableViewCell.identifier, for: indexPath)
        default:
            return tableView.dequeueReusableCell(withIdentifier: SideMenuLogoTableViewCell.identifier, for: indexPath)
        }
    
    }
    
    
    // MARK: - TableView Delegate
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        switch indexPath.row {
//        case 0:
//            return EJSizeHeight(258.0)
//        case 1:
//            return EJSizeHeight(30.0)
//        default:
//            return EJSizeHeight(60.0)
//        }
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            let shareVC = self.storyboard?.instantiateViewController(withIdentifier: "EJShareViewController")
            self.navigationController?.pushViewController(shareVC!, animated: true)
        case 2:
            sendEmailWithCompose()
        case 3:
            self.performSegue(withIdentifier: "sidemenu_setting_segue", sender: self)
        default:
            print("Nothing")
        }
    }
    
    // MARK: - Private Method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "sidemenu_setting_segue" {
            let settingVC = segue.destination as! EJSettingViewController
            settingVC.curLocation = self.curLocation
        }
    }

}
