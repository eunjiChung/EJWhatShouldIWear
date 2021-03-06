//
//  EJIntroViewController.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/05/30.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

final class EJIntroViewController: EJBaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    
    // MARK: - Property
    var didSelectCountryClosure: (()->Void)?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = "setting_country".localized
        closeButton.setTitle("complete".localized, for: .normal)
        tableView.tableFooterView = UIView(frame: .zero)
        
        if !myUserDefaults.bool(forKey: UserDefaultKey.isExistingUser) {
            closeButton.isHidden = true
        }
    }
    
    @IBAction func didTouchCloseButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}


// MARK: - TableView Data Source
extension EJIntroViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EJCountryType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell") else { return UITableViewCell() }
        cell.textLabel?.text = EJCountryType.allCases[indexPath.row].rawValue.localized
        return cell
    }
}

// MARK: - TableView Delegate
extension EJIntroViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectionHapticFeedback()
        
        EJLocationManager.shared.selectedCountry = EJCountryType.allCases[indexPath.row]
        myUserDefaults.set(EJCountryType.allCases[indexPath.row].rawValue.localized, forKey: UserDefaultKey.countryType)

        didSelectCountryClosure?()
        dismiss(animated: true) {
            if !myUserDefaults.bool(forKey: UserDefaultKey.isExistingUser) {
                myUserDefaults.set(true, forKey: UserDefaultKey.isExistingUser)
                
                switch EJCountryType.allCases[indexPath.row] {
                case .korea:
                    EJLocationManager.shared.checkAuthorization(nil)
                case .foreign:
                    EJLocationManager.shared.checkAbroadAuthorization()
                }
            }
        }
    }
}
