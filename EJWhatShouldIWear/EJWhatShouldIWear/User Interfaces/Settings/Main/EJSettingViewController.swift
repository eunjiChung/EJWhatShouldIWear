//
//  EJSettingViewController.swift
//  EJWhatShouldIWear
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 16/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

enum EJSettingListType: Int, CaseIterable {
    case notice = 0
    case country
    case developerInfo
}

final class EJSettingViewController: EJBaseViewController {
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
        dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Tableview Data Source
extension EJSettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EJSettingListType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let rowType = EJSettingListType(rawValue: indexPath.row) else { return UITableViewCell() }
        switch rowType {
        case .notice:
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoTableViewCell", for: indexPath) as! EJInfoTableViewCell
            cell.titleLabel.text = "Notice".localized
            return cell
        case .country:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoTableViewCell", for: indexPath) as? EJInfoTableViewCell else { return UITableViewCell() }
            cell.titleLabel.text = "setting_country".localized
            return cell
        case .developerInfo:
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoTableViewCell", for: indexPath) as! EJInfoTableViewCell
            return cell
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
        
        guard let rowType = EJSettingListType(rawValue: indexPath.row) else { return }
        switch rowType {
        case .notice:
            self.performSegue(withIdentifier: "show_notice", sender: self)
        case .country:
            guard let introVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EJIntroViewController") as? EJIntroViewController else { return }
            introVC.modalPresentationStyle = .fullScreen
            present(introVC, animated: true, completion: nil)
        case .developerInfo:
            self.performSegue(withIdentifier: "set_info_segue", sender: self)
        }
    }
    
}
