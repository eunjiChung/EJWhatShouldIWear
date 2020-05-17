//
//  DevInfoViewController.swift
//  EJWhatShouldIWear
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 16/07/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

enum EJDevInfoSectionType: Int, CaseIterable {
    case appName = 0
    case devInfo
}

enum EJAppInfoListType: Int, CaseIterable {
    case appVersion = 0
    case appDescription
}

enum EJDeveloperInfoListType: Int, CaseIterable {
    case name = 0
    case blog
    case instagram
}

class EJDevInfoViewController: EJBaseViewController, UITableViewDelegate {
    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTouchBackBtn(_ sender: Any) {
        selectionHapticFeedback()
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: TableView DataSource
extension EJDevInfoViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return EJDevInfoSectionType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let headerType = EJDevInfoSectionType(rawValue: section) else { return nil }
        switch headerType {
        case .appName:
            return "app_name".localized
        case .devInfo:
            return "developer_info".localized
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let listType = EJDevInfoSectionType(rawValue: section) else { return 0 }
        switch listType {
        case .appName:
            return 2
        case .devInfo:
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sectionType = EJDevInfoSectionType(rawValue: indexPath.section) else { return UITableViewCell() }
        switch sectionType {
        case .appName:
            guard let rowType = EJAppInfoListType(rawValue: indexPath.row) else { return UITableViewCell() }
            switch rowType {
            case .appVersion:
                let cell = tableView.dequeueReusableCell(withIdentifier: "DeveloperTableViewCell") as! EJDeveloperTableViewCell
                cell.InfoTitleLabel.text = "app_version".localized
                cell.infoDescriptionLabel.text = Library.appVersion()
                return cell
            case .appDescription:
                let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionTableViewCell") as! EJDescriptionTableViewCell
                cell.descriptionCell.text = "app_description".localized
                return cell
            }
        case .devInfo:
            guard let rowType = EJDeveloperInfoListType(rawValue: indexPath.row) else { return UITableViewCell() }
            switch rowType {
            case .name:
                let cell = tableView.dequeueReusableCell(withIdentifier: "DeveloperTableViewCell") as! EJDeveloperTableViewCell
                cell.InfoTitleLabel.text = "EunjiChung"
                cell.infoDescriptionLabel.text = ""
                return cell
            case .blog:
                let cell = tableView.dequeueReusableCell(withIdentifier: "BlogTableViewCell") as! EJBlogTableViewCell
                cell.cellTitleLabel.text = "blog".localized
                cell.blogButton.setTitle("goto_blog".localized, for: .normal)
                return cell
            case .instagram:
                let cell = tableView.dequeueReusableCell(withIdentifier: "InstagramTableViewCell") as! EJInstagramTableViewCell
                cell.infoTitleLabel.text = "instagram".localized
                cell.tableButton.setTitle("goto_instagram".localized, for: .normal)
                return cell
            }
        }
    }
}
