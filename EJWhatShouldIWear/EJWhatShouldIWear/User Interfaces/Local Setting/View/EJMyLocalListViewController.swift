//
//  EJLocalSettingViewController.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/04/30.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class EJMyLocalListViewController: EJBaseViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Properties
    var locations: [String]?
    
    // MARK: - View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        initNotification()
        getMyCurrentLocations()
    }
    
    // MARK: - Initialize
    private func initView() {
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    private func initNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(didCompleteChoosingLocation(_:)), name: EJKoreaCityNotification.didDismissViewController, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: EJKoreaCityNotification.didDismissViewController, object: nil)
    }
    
    // MARK: - Private Methods
    private func getMyCurrentLocations() {
        if let array = myUserDefaults.array(forKey: UserDefaultKey.myLocations.rawValue) as? [String] {
            locations = array
        } else {
            locations = [EJLocationManager.shared.locationString]
        }
    }
    
    @objc func didCompleteChoosingLocation(_ notificaion: Notification) {
        guard let array = myUserDefaults.array(forKey: UserDefaultKey.myLocations.rawValue) as? [String] else { return }
        locations = array
        tableView.reloadData()
    }
    
    // MARK: - IBActions
    @IBAction func didTouchEdit(_ sender: Any) {
        selectionHapticFeedback()
        // TODO: - 편집 기능 추가
        // TODO: - 삭제 기능 추가 (이건 셀 안에)
    }
    
    @IBAction func didTouchDismiss(_ sender: Any) {
        selectionHapticFeedback()
        navigationController?.popViewController(animated: true)
    }
}

extension EJMyLocalListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = locations?.count, (locations?.count) != 0 else { return 1 }
        return count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let count = locations?.count else { return UITableViewCell() }
        if indexPath.row == count {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "EJAddLocationCell") as? EJAddLocationCell else { return UITableViewCell() }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EJLocationNameTableViewCell.identifier) as? EJLocationNameTableViewCell else { return UITableViewCell() }
            if let name = locations?[indexPath.row] {
                cell.locationLabel.text = name
            }
            return cell
        }
    }
}

extension EJMyLocalListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectionHapticFeedback()
        
        EJLocationManager.shared.updateMainLocation()
        
        guard let cell = tableView.cellForRow(at: indexPath) as? EJLocationNameTableViewCell else { return }
        cell.checkImageView.isHidden = false
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        // TODO: - 머야 이거 왜 안돼....
        guard let count = locations?.count, indexPath.row != count else { return }
        
        guard let cell = tableView.cellForRow(at: indexPath) as? EJLocationNameTableViewCell else { return }
        cell.checkImageView.isHidden = true
    }
}
