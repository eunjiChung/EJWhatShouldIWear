//
//  EJSettingViewController.swift
//  EJWhatShouldIWear
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 16/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit
import CoreLocation

class EJSettingViewController: EJBaseViewController {
    
    // MARK: - Property
    var curLocation : String? = nil

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var alcTopOfBackIcon: NSLayoutConstraint!
    @IBOutlet weak var alcLeadingOfBackIcon: NSLayoutConstraint!
    @IBOutlet weak var alcBottomOfBackButton: NSLayoutConstraint!
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    // MARK: - Initialize
    private func initView() {
        alcTopOfBackIcon.constant = EJSizeHeight(46.0)
        alcLeadingOfBackIcon.constant = EJSize(18.0)
        alcBottomOfBackButton.constant = EJSizeHeight(18.0)

        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    // MARK: - IBOutlet Action
    @IBAction func didTouchBackButton(_ sender: Any) {
        selectionHapticFeedback()
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Tableview Data Source
extension EJSettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoTableViewCell", for: indexPath) as! InfoTableViewCell
            cell.titleLabel.text = LocalizedString(with: "Notice")
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "LocationTableViewCell", for: indexPath) as! LocationTableViewCell
            
            cell.myLocationLabel.text = curLocation
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoTableViewCell", for: indexPath) as! InfoTableViewCell
            return cell
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - TableView Delegate
extension EJSettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return EJSizeHeight(70.0)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectionHapticFeedback()
        
        switch indexPath.row {
        case 0:
            self.performSegue(withIdentifier: "show_notice", sender: self)
        case 1:
            self.performSegue(withIdentifier: "showLocationSegue", sender: self)
        case 2:
            self.performSegue(withIdentifier: "set_info_segue", sender: self)
        default:
            EJLogger.d("")
        }
    }
    
}
