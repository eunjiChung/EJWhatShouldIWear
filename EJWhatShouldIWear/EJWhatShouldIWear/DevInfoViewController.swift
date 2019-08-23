//
//  DevInfoViewController.swift
//  EJWhatShouldIWear
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 16/07/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class DevInfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func didTouchBackBtn(_ sender: Any) {
        Library.selectionHapticFeedback()
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()

        switch indexPath.row {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionTableViewCell") as! DescriptionTableViewCell
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: "DeveloperTableViewCell") as! DeveloperTableViewCell
        case 2:
            cell = tableView.dequeueReusableCell(withIdentifier: "InstagramTableViewCell") as! InstagramTableViewCell
        default:
            print("Nothing..")
        }
        
        return cell
    }
}
