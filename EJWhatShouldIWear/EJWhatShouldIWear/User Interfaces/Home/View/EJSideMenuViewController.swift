//
//  EJSideMenuViewController.swift
//  EJWhatShouldIWear
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 13/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

enum EJSideMenuSectionType: Int, CaseIterable {
    case logo
    case location
    case share
    case review
    case setting
}

enum EJForeignSideMenuType: Int, CaseIterable {
    case logo
    case share
    case review
    case setting
}

final class EJSideMenuViewController: EJBaseViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var sideMenuTableView: UITableView!
    var curLocation: String?
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Private Method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sidemenu_setting_segue" {
            guard let navVC = segue.destination as? UINavigationController, let settingVC = navVC.topViewController as? EJSettingViewController else { return }
            settingVC.curLocation = self.curLocation
        }
    }
    
    private func writeReview() {
        guard let productURL = URL(string: AppStoreURL) else { return }
        var components = URLComponents(url: productURL, resolvingAgainstBaseURL: false)
        components?.queryItems = [
          URLQueryItem(name: "action", value: "write-review")
        ]
        
        guard let writeReviewURL = components?.url else { return }
        UIApplication.shared.open(writeReviewURL)
    }
}

// MARK: - TableView Data Source
extension EJSideMenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if EJLocationManager.shared.isKorea() {
            return EJSideMenuSectionType.allCases.count
        } else {
            return EJForeignSideMenuType.allCases.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if EJLocationManager.shared.isKorea() {
            guard let sectionType = EJSideMenuSectionType(rawValue: indexPath.row) else { return UITableViewCell() }
            switch sectionType {
            case .logo:
                return tableView.dequeueReusableCell(withIdentifier: SideMenuLogoTableViewCell.identifier, for: indexPath)
            case .location:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuShareTableViewCell.identifier) as? SideMenuShareTableViewCell else { return UITableViewCell() }
                cell.imageView?.tintColor = #colorLiteral(red: 0.1921568627, green: 0.1921568627, blue: 0.1921568627, alpha: 1)
                cell.imageView?.image = #imageLiteral(resourceName: "menu_icon")
                cell.shareLabel.text = "즐겨찾는 위치"
                return cell
            case .share:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuShareTableViewCell.identifier, for: indexPath) as? SideMenuShareTableViewCell else { return UITableViewCell() }
                cell.imageView?.image = #imageLiteral(resourceName: "share_black_icon")
                return cell
            case .review:
                return tableView.dequeueReusableCell(withIdentifier: SideMenuFeedbackTableViewCell.identifier, for: indexPath)
            case .setting:
                return tableView.dequeueReusableCell(withIdentifier: SideMenuSettingTableViewCell.identifier, for: indexPath)
            }
        } else {
            guard let sectionType = EJForeignSideMenuType(rawValue: indexPath.row) else { return UITableViewCell() }
            switch sectionType {
            case .logo:
                return tableView.dequeueReusableCell(withIdentifier: SideMenuLogoTableViewCell.identifier, for: indexPath)
            case .share:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuShareTableViewCell.identifier, for: indexPath) as? SideMenuShareTableViewCell else { return UITableViewCell() }
                cell.imageView?.image = #imageLiteral(resourceName: "share_black_icon")
                return cell
            case .review:
                return tableView.dequeueReusableCell(withIdentifier: SideMenuFeedbackTableViewCell.identifier, for: indexPath)
            case .setting:
                return tableView.dequeueReusableCell(withIdentifier: SideMenuSettingTableViewCell.identifier, for: indexPath)
            }
        }
    }
}

// MARK: - UITableView Delegate
extension EJSideMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectionHapticFeedback()
        
        if EJLocationManager.shared.isKorea() {
            guard let sectionType = EJSideMenuSectionType(rawValue: indexPath.row) else { return }
            switch sectionType {
            case .location:
                self.performSegue(withIdentifier: "showLocationSegue", sender: self)
            case .share:
                let shareVC = self.storyboard?.instantiateViewController(withIdentifier: "EJShareViewController")
                self.navigationController?.pushViewController(shareVC!, animated: true)
            case .review:
                writeReview()
            case .setting:
                self.performSegue(withIdentifier: "sidemenu_setting_segue", sender: self)
            case .logo:
                EJLogger.d("")
            }
        } else {
            guard let sectionType = EJForeignSideMenuType(rawValue: indexPath.row) else { return }
            switch sectionType {
            case .share:
                let shareVC = self.storyboard?.instantiateViewController(withIdentifier: "EJShareViewController")
                self.navigationController?.pushViewController(shareVC!, animated: true)
            case .review:
                writeReview()
            case .setting:
                self.performSegue(withIdentifier: "sidemenu_setting_segue", sender: self)
            case .logo:
                EJLogger.d("")
            }
        }
    }
}
