//
//  DevInfoViewController.swift
//  EJWhatShouldIWear
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 16/07/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class DevInfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func didTouchBackBtn(_ sender: Any) {
        Library.selectionHapticFeedback()
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: TableView DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return LocalizedString(with: "app_name")
        default:
            return "개발자 정보"
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
                let cell = tableView.dequeueReusableCell(withIdentifier: "DeveloperTableViewCell") as! DeveloperTableViewCell
                cell.InfoTitleLabel.text = "App Version"
                cell.infoDescriptionLabel.text = Library.appVersion()
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionTableViewCell") as! DescriptionTableViewCell
                cell.descriptionCell.text = "'오늘모입지?'는 OpenWeatherMap에서 제공하는 데이터로 각종 기상 정보를 표시합니다. 때문에 해당 사이트의 서버 사정에 따라 정보가 표시되지 않을 수 있습니다. 또한 모든 예보가 100% 일치하지 않는다는 점을 이해해 주시기 바랍니다. 어플리케이션에 대한 보다 자세한 사용방법 및 개발 이야기는 블로그에 수록되어 있습니다."
                return cell
            default:
                print("Nothing...")
            }
        case 1:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "DeveloperTableViewCell") as! DeveloperTableViewCell
                cell.InfoTitleLabel.text = "EunjiChung"
                cell.infoDescriptionLabel.text = ""
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "InstagramTableViewCell") as! InstagramTableViewCell
                cell.infoTitleLabel.text = "Blog"
                cell.typeOfButton = "Blog"
                cell.tableButton.titleLabel?.text = "Blog"
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "InstagramTableViewCell") as! InstagramTableViewCell
                cell.infoTitleLabel.text = "Instagram"
                cell.typeOfButton = "Instagram"
                cell.tableButton.titleLabel?.text = "Instagram"
                return cell
            default:
                print("Nothing...")
            }
        default:
            print("Nothing...")
        }
        
        return UITableViewCell()
    }

}
