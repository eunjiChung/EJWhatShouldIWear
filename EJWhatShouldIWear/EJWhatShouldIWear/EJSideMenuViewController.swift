//
//  EJSideMenuViewController.swift
//  EJWhatShouldIWear
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 13/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class EJSideMenuViewController: EJBaseViewController, UITableViewDataSource {
    
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
            return tableView.dequeueReusableCell(withIdentifier: "logo", for: indexPath)
        case 1:
            return tableView.dequeueReusableCell(withIdentifier: "share", for: indexPath)
        case 2:
            return tableView.dequeueReusableCell(withIdentifier: "feedback", for: indexPath)
        case 3:
            return tableView.dequeueReusableCell(withIdentifier: "setting", for: indexPath)
        default:
            return tableView.dequeueReusableCell(withIdentifier: "logo", for: indexPath)
        }
        
    }

}
