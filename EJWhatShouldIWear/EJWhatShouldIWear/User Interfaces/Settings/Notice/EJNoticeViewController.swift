//
//  EJNoticeViewController.swift
//  EJWhatShouldIWear
//
//  Created by CHUNGEUNJI on 16/04/2020.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class EJNoticeViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewTitleLabel: UILabel!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }
    
    private func initView() {
        viewTitleLabel.text = LocalizedString(with: "Notice")
    }
}

extension EJNoticeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension EJNoticeViewController: UITableViewDelegate {
    
}

// MARK: - Table View Cell
