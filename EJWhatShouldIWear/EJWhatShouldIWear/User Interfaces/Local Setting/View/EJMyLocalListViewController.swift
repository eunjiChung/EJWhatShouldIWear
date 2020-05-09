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
    @IBOutlet weak var addButton: UIButton!
    
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
        addButton.layer.cornerRadius = 6
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(UINib(nibName: "EJNameTableViewCell", bundle: nil), forCellReuseIdentifier: EJNameTableViewCell.identifier)
    }
    
    private func initNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(didCompleteChoosingLocation(_:)), name: EJKoreaCityNotification.didDismissViewController, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: EJKoreaCityNotification.didDismissViewController, object: nil)
    }
    
    // MARK: - Private Methods
    private func getMyCurrentLocations() {
        if let array = myUserDefaults.array(forKey: UserDefaultKey.myLocations.rawValue) as? [String], array.count != 0 {
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
    @IBAction func didTouchDismiss(_ sender: Any) {
        selectionHapticFeedback()
        navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)

        // TODO: - 새로운 지역을 선택했다면 post를 해주고, 아니면 필요X
        NotificationCenter.default.post(name: EJMyLocalListNotification.didSelectMainLocation, object: nil)
    }
}

extension EJMyLocalListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = locations?.count, (locations?.count) != 0 else { return 1 }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EJNameTableViewCell.identifier) as? EJNameTableViewCell else { return UITableViewCell() }
        guard let name = locations?[indexPath.row] else { return UITableViewCell() }
        cell.locationLabel.text = name
        if name == EJLocationManager.shared.locationString {
            cell.checkImageview.isHidden = false
        }
        return cell
    }
}

extension EJMyLocalListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectionHapticFeedback()
        
        if let name = locations?[indexPath.row] {
            EJLocationManager.shared.updateMainLocation(name)
        }
        
        guard let cell = tableView.cellForRow(at: indexPath) as? EJNameTableViewCell else { return }
        cell.checkImageview.isHidden = false
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? EJNameTableViewCell else { return }
        cell.checkImageview.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            locations?.remove(at: indexPath.row)
            if let locations = locations {
                EJUserDefaultsManager.shared.updateLocationList(locations)
            }
            tableView.reloadData()
        }
    }
}
