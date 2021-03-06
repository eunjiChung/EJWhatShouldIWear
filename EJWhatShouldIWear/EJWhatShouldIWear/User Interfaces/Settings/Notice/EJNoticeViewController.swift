//
//  EJNoticeViewController.swift
//  EJWhatShouldIWear
//
//  Created by CHUNGEUNJI on 16/04/2020.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class EJNoticeViewController: EJBaseViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewTitleLabel: UILabel!
    
    // MARK: - Properties
    var notices = [[String: Any]]()
    var cellOpened: [Bool] = []
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()

        EJFirebaseDBManager.shared.getNoticeDB { (notices) in
            self.notices = notices
            self.initCellArray()
            self.tableView.reloadData()
        }
    }
    
    private func initView() {
        viewTitleLabel.text = "Notice".localized
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    private func initCellArray() {
        for _ in 0...notices.count {
            cellOpened.append(false)
        }
    }
    
    // MARK: - Actions
    @IBAction func didTouchBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension EJNoticeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return notices.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellOpened[section] ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath)
            
            let notice = self.notices[indexPath.section]
            cell.textLabel?.text = notice["title"] as? String
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EJContentTableViewCell", for: indexPath) as! EJContentTableViewCell
            
            let notice = self.notices[indexPath.section]
            cell.contentLabel.text = notice["detail"] as? String
            
            return cell
        }
    }
}

extension EJNoticeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectionHapticFeedback()
        
        if cellOpened[indexPath.section] {
            cellOpened[indexPath.section] = false
            tableView.beginUpdates()
            tableView.deleteRows(at: [IndexPath(row: 1, section: indexPath.section)], with: .fade)
            tableView.endUpdates()
        } else {
            cellOpened[indexPath.section] = true
            tableView.beginUpdates()
            tableView.insertRows(at: [IndexPath(row: 1, section: indexPath.section)], with: .fade)
            tableView.endUpdates()
        }
    }
}

// MARK: - TableView content cell
class EJContentTableViewCell: UITableViewCell {
    @IBOutlet weak var contentLabel: UILabel!
}
