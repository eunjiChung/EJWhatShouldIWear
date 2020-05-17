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

class EJMyLocalListViewController: EJBaseViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    
    // MARK: - Properties
    var locations: [String]?
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
        } else {
            locations = []
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
        
        if shouldShowCurrent {
            EJLocationManager.shared.updateMainLocation(nil)
        } else {
            print("❤️ selected location:", locations?[selectedIndex])
            print("❤️ previous location:", previousMainLocation)
            if locations?[selectedIndex] != previousMainLocation {
                EJLocationManager.shared.updateMainLocation(locations?[selectedIndex] ?? "")
            }
        }
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
            guard let count = locations?.count, (locations?.count) != 0 else { return 1 }
            return count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sectionType = EJMyLocalListIndexType(rawValue: indexPath.section) else { return UITableViewCell() }
        switch sectionType {
        case .current:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EJNameTableViewCell.identifier) as? EJNameTableViewCell else { return UITableViewCell() }
            cell.locationLabel.text = "현재 위치 날씨보기"
            cell.backgroundColor = .cyan
            return cell
        case .other:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EJNameTableViewCell.identifier) as? EJNameTableViewCell else { return UITableViewCell() }
            guard let name = locations?[indexPath.row] else { return UITableViewCell() }
            cell.locationLabel.text = name
            if name == EJLocationManager.shared.currentLocation {
                cell.checkImageview.isHidden = false
            }
            return cell
        }
    }
}

extension EJMyLocalListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectionHapticFeedback()
        
        guard let selectedSection = EJMyLocalListIndexType(rawValue: indexPath.section) else { return }
        if selectedSection == .current {
            shouldShowCurrent = true
            
            switch EJLocationManager.shared.authStatus {
            case .authorizedAlways, .authorizedWhenInUse:
                guard let cell = tableView.cellForRow(at: indexPath) as? EJNameTableViewCell else { return }
                cell.checkImageview.isHidden = false
            default:
                popAlertVC(self, title: "알림", message: "현재 위치 날씨를 보려면 위치 접근을 허용해주세요!\n설정>개인 정보 보호>위치 서비스>오늘모입지? 에서 설정 가능합니다:)")
            }
        } else {
            tableView.visibleCells.forEach { cell in
                guard let nameCell = cell as? EJNameTableViewCell else { return }
                nameCell.checkImageview.isHidden = true
            }
            selectedIndex = indexPath.row

            guard let cell = tableView.cellForRow(at: indexPath) as? EJNameTableViewCell else { return }
            cell.checkImageview.isHidden = false
        }
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
            locations?.remove(at: indexPath.row)
            if let locations = locations { EJUserDefaultsManager.shared.updateLocationList(locations) }
            tableView.reloadData()
        }
    }
}
