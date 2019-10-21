//
//  NoticeViewController.swift
//  EJWhatShouldIWear
//
//  Created by eunji on 21/10/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit
import Firebase

class NoticeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    static let identifier = "NoticeViewController"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - View Control
    @IBAction func didTouchBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    // MARK: - TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NoticeTitleTableViewCell.identifier, for: indexPath) as! NoticeTitleTableViewCell
        cell.textLabel?.text = "THIS IS TILE"
        return cell
    }
    
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Library.selectionHapticFeedback()
    }

}
