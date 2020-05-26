//
//  EJLocalSettingViewController.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/04/30.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

enum EJMyLocalListIndexType: Int, CaseIterable {
    case current = 0
    case other
    case notKorea
}

struct EJMyLocalListNotification {
    static let isNotKoreaLocation = NSNotification.Name(rawValue: "isNotKoreaLocation")
}

class EJMyLocalListViewController: EJBaseViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    
    // MARK: - Properties
    var locations: [String] = []
    var previousMainLocation: String {
        return EJLocationManager.shared.currentLocation
    }
    var selectedIndex: Int = 0
    var shouldShowCurrent: Bool = false
    
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
    // TODO: - 고치고 싶어...! 그냥 locations가 computed array가 되도록!
    private func getMyCurrentLocations() {
        if let array = myUserDefaults.array(forKey: UserDefaultKey.myLocations.rawValue) as? [String], array.count != 0 {
            locations = array
            
            for (index, location) in array.enumerated() where location == previousMainLocation {
                selectedIndex = index
            }
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
        
        guard locations.count != 0 else {
            dismissViewController()
            return
        }
        
        if shouldShowCurrent {
            EJLocationManager.shared.updateMainLocation(nil)
        } else {
            if locations[selectedIndex] != previousMainLocation {
                EJLocationManager.shared.updateMainLocation(locations[selectedIndex])
            }
        }
        
        dismissViewController()
    }
    
    func dismissViewController() {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
}

extension EJMyLocalListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return EJMyLocalListIndexType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionType = EJMyLocalListIndexType(rawValue: section) else { return 0 }
        switch sectionType {
        case .current:
            return 1
        case .other:
            return locations.count
        case .notKorea:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sectionType = EJMyLocalListIndexType(rawValue: indexPath.section) else { return UITableViewCell() }
        switch sectionType {
        case .current:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EJNameTableViewCell.identifier) as? EJNameTableViewCell else { return UITableViewCell() }
            cell.locationLabel.text = "Show current location weather".localized
            return cell
        case .other:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EJNameTableViewCell.identifier) as? EJNameTableViewCell else { return UITableViewCell() }
            
            cell.locationLabel.text = locations[indexPath.row]
            if locations[indexPath.row] == EJLocationManager.shared.currentLocation {
                cell.checkImageview.isHidden = false
            }
            
            return cell
        case .notKorea:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EJNameTableViewCell.identifier) as? EJNameTableViewCell else { return UITableViewCell() }
            cell.locationLabel.text = "Not Korea".localized
            return cell
        }
    }
}

extension EJMyLocalListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectionHapticFeedback()
        
        guard let selectedSection = EJMyLocalListIndexType(rawValue: indexPath.section) else { return }
        switch selectedSection {
        case .current:
            shouldShowCurrent = true
            
            switch EJLocationManager.shared.authStatus {
            case .authorizedAlways, .authorizedWhenInUse:
                guard let cell = tableView.cellForRow(at: indexPath) as? EJNameTableViewCell else { return }
                cell.checkImageview.isHidden = false
            default:
            self.popAlertVC(self, title: "Alert".localized, message: "Allow location access".localized)
            }
        case .other:
            tableView.visibleCells.forEach { cell in
                guard let nameCell = cell as? EJNameTableViewCell else { return }
                nameCell.checkImageview.isHidden = true
            }
            selectedIndex = indexPath.row
            
            guard let cell = tableView.cellForRow(at: indexPath) as? EJNameTableViewCell else { return }
            cell.checkImageview.isHidden = false
        case .notKorea:
            EJLocationManager.shared.setForeignDefault()
            dismissViewController()
            NotificationCenter.default.post(name: EJMyLocalListNotification.isNotKoreaLocation, object: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        guard let sectionType = EJMyLocalListIndexType(rawValue: indexPath.section), sectionType != .current, sectionType != .notKorea else { return false }
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        guard let sectionType = EJMyLocalListIndexType(rawValue: indexPath.section), sectionType != .current, sectionType != .notKorea else { return .none }
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let sectionType = EJMyLocalListIndexType(rawValue: indexPath.section), sectionType != .current, sectionType != .notKorea else { return }
        
        if editingStyle == .delete {
            locations.remove(at: indexPath.row)
            EJUserDefaultsManager.shared.updateLocationList(locations)
            tableView.reloadData()
        }
    }
}
