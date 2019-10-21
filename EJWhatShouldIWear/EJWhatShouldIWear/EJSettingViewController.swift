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
    var cellOpened = false
    
    // MARK: - Layout constraints
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewTitlelabel: UILabel!
    @IBOutlet weak var alcTopOfBackIcon: NSLayoutConstraint!
    @IBOutlet weak var alcLeadingOfBackIcon: NSLayoutConstraint!
    @IBOutlet weak var alcBottomOfBackButton: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewTitlelabel.text = LocalizedString(with: "setting")
        
        alcTopOfBackIcon.constant = EJSizeHeight(46.0)
        alcLeadingOfBackIcon.constant = EJSize(18.0)
        alcBottomOfBackButton.constant = EJSizeHeight(18.0)
    }
    
    
    // MARK: - IBOutlet Action
    @IBAction func didTouchBackButton(_ sender: Any) {
        Library.selectionHapticFeedback()
        self.navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - TableView Data Source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 && cellOpened == true {
            return 2
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if cellOpened && indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: AlarmDetailTableViewCell.identifier, for: indexPath) as! AlarmDetailTableViewCell
                return cell
            }
        } else {
            switch indexPath.section {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "AlarmTableViewCell", for: indexPath) as! AlarmTableViewCell
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "LocationTableViewCell", for: indexPath) as! LocationTableViewCell
                
                cell.myLocationLabel.text = curLocation
                
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "LocationTableViewCell", for: indexPath) as! LocationTableViewCell
                cell.titleLabel.text = LocalizedString(with: "setting_notice") // TODO: - 공지사항 지역화하기
                cell.myLocationLabel.text = ""
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "InfoTableViewCell", for: indexPath) as! InfoTableViewCell
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return EJSizeHeight(70.0)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Library.selectionHapticFeedback()
        
        switch indexPath.row {
        case 0:
            self.performSegue(withIdentifier: "showLocationSegue", sender: self)
        case 1:
            self.performSegue(withIdentifier: "go_notice_segue", sender: self)
        default:
            self.performSegue(withIdentifier: "set_info_segue", sender: self)
        }
    }
    
}
