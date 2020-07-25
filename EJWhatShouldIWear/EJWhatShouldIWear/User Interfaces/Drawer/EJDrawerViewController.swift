//
//  EJDrawerViewController.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/07/08.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class EJDrawerViewController: EJBaseViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var dimView: UIView!
    @IBOutlet weak var backView: UIView!
    
    // MARK: - Property
    var locations: [String] = ["현재 위치 날씨보기"]
    var didTapBackground: (()->Void)?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        initLocation()
    }
    
    // MARK: - Initialize
    func initView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        dimView.addGestureRecognizer(tap)
        
        backView.layer.cornerRadius = 10
    }
    
    private func initLocation() {
        if let array = myUserDefaults.array(forKey: UserDefaultKey.myLocations) as? [String], array.count != 0 {
            array.forEach({ locations.append($0) })
        }
    }
    
    @objc func handleTap() {
        didTapBackground?()
        self.dismiss(animated: true, completion: nil)
    }

}

extension EJDrawerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell") else { return UITableViewCell() }
        cell.textLabel?.text = locations[indexPath.row]
        return cell
    }
}

extension EJDrawerViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectionHapticFeedback()
        
        guard let selected = EJMyLocalListIndexType(rawValue: indexPath.row) else { return }
        switch selected {
        case .current:
            switch EJLocationManager.shared.authStatus {
            case .authorizedAlways, .authorizedWhenInUse:
                EJLocationManager.shared.updateMainLocation(nil)
            default:
                popAlertVC(self, title: "Alert".localized, message: "Allow location access".localized)
            }
        case .other:
            EJLocationManager.shared.updateMainLocation(locations[indexPath.row])
        }
        
        handleTap()
    }
}
