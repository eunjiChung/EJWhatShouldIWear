//
//  DevInfoViewController.swift
//  EJWhatShouldIWear
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 16/07/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

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
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return LocalizedString(with: "app_name")
        default:
            return LocalizedString(with: "developer_info")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 2
        case 1:
            return 3
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "DeveloperTableViewCell") as! EJDeveloperTableViewCell
                cell.InfoTitleLabel.text = LocalizedString(with: "app_version")
                cell.infoDescriptionLabel.text = Library.appVersion()
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionTableViewCell") as! EJDescriptionTableViewCell
                cell.descriptionCell.text = LocalizedString(with: "app_description")
                return cell
            default:
                return UITableViewCell()
            }
        case 1:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "DeveloperTableViewCell") as! EJDeveloperTableViewCell
                cell.InfoTitleLabel.text = "EunjiChung"
                cell.infoDescriptionLabel.text = ""
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "BlogTableViewCell") as! EJBlogTableViewCell
                cell.cellTitleLabel.text = LocalizedString(with: "blog")
                cell.blogButton.setTitle(LocalizedString(with: "goto_blog"), for: .normal)
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "InstagramTableViewCell") as! EJInstagramTableViewCell
                cell.infoTitleLabel.text = LocalizedString(with: "instagram")
                cell.tableButton.setTitle(LocalizedString(with: "goto_instagram"), for: .normal)
                return cell
            default:
                return UITableViewCell()
            }
        default:
            return UITableViewCell()
        }
    }
}
