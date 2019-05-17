//
//  EJSideMenuViewController.swift
//  EJWhatShouldIWear
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 13/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class EJSideMenuViewController: EJBaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var sideMenuTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    // MARK : - TableView Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return EJSize(305.0)
        default:
            return EJSize(80.0)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 3 {
            // 이 방법은 틀렸어....ㅠㅠ
            DispatchQueue.main.async {
                self.present(EJSettingViewController(), animated: true, completion: nil)
            }
        }
    }

}
