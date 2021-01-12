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
    
    // TODO: - flag가 너무 많다
    var selectedIndex: Int = 0
    var shouldShowCurrent: Bool = false

    // MARK: - Closure
    var dismissMyLocalListClosure: (() -> Void)?
    
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
        var match = false
        if let array = myUserDefaults.array(forKey: UserDefaultKey.myLocations) as? [String], array.count != 0 {
            locations = array
            
            for (index, location) in array.enumerated() where location == previousMainLocation {
                selectedIndex = index
                match = true
            }
        }
        
        if !match, EJLocationManager.shared.authStatus != .denied, EJLocationManager.shared.authStatus != .restricted {
            shouldShowCurrent = true
        }
    }
    
    @objc func didCompleteChoosingLocation(_ notificaion: Notification) {
        guard let array = myUserDefaults.array(forKey: UserDefaultKey.myLocations) as? [String] else { return }
        locations = array
        tableView.reloadData()
    }

    func dismissViewController() {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true) {
            self.dismissMyLocalListClosure?()
        }
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
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sectionType = EJMyLocalListIndexType(rawValue: indexPath.section) else { return UITableViewCell() }
        switch sectionType {
        case .current:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EJNameTableViewCell.identifier) as? EJNameTableViewCell else { return UITableViewCell() }
            switch EJLocationManager.shared.authStatus {
            case .authorizedAlways, .authorizedWhenInUse:
                cell.locationLabel.textColor = .darkText
                if shouldShowCurrent { cell.checkImageview.isHidden = false }
            default:
                cell.locationLabel.textColor = .lightGray
            }
            return cell
        case .other:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EJNameTableViewCell.identifier) as? EJNameTableViewCell else { return UITableViewCell() }
            
            cell.locationLabel.text = locations[indexPath.row]
            if locations[indexPath.row] == EJLocationManager.shared.currentLocation {
                cell.checkImageview.isHidden = false
            }
            
            return cell
        }
    }
}

extension EJMyLocalListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectionHapticFeedback()
        
        if let selectedSection = EJMyLocalListIndexType(rawValue: indexPath.section),
           selectedSection == .current {
            switch EJLocationManager.shared.authStatus {
            case .authorizedAlways, .authorizedWhenInUse:
                EJLocationManager.shared.updateMainLocation(nil)
            default:
                popAlertVC(self, title: "Alert".localized, message: "Allow location access".localized) {
                    self.dismissViewController()
                }
            }
        } else {
            EJLocationManager.shared.updateMainLocation(locations[indexPath.row])
        }

        dismissViewController()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        guard let sectionType = EJMyLocalListIndexType(rawValue: indexPath.section), sectionType != .current else { return false }
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        guard let sectionType = EJMyLocalListIndexType(rawValue: indexPath.section), sectionType != .current else { return .none }
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let sectionType = EJMyLocalListIndexType(rawValue: indexPath.section), sectionType != .current else { return }
        
        if editingStyle == .delete {
            locations.remove(at: indexPath.row)
            EJUserDefaultsManager.shared.updateLocationList(locations)
            tableView.reloadData()
        }
    }
}
