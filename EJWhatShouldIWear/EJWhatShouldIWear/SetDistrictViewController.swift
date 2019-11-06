//
//  SetDistrictViewController.swift
//  EJWhatShouldIWear
//
//  Created by CHUNGEUNJI on 06/11/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class SetDistrictViewController: UIViewController {

    // MARK: - Global Instance
    let decoder = JSONDecoder()
    var districtData: [String: [String]] = [:]
    var isOpened = false
    var openedSection: Int? = nil
    var districtSi = ""
    var districtGu = ""
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDistrict()
    }
    
    // MARK: - IBAction
    @IBAction func didTouchButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Private Method
    private func setDistrict() {
        if let path = Bundle.main.path(forResource: "korea-district", ofType: "json"), let contents = try? String(contentsOfFile: path) {
            if let data = contents.data(using: .utf8), let myDistrict = try? decoder.decode(MyDistrict.self, from: data) {
                districtData = myDistrict.data
            }
        }
    }
    
    
}

extension SetDistrictViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK: - UITableView DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let opened = openedSection {
            if section == opened { return 2 }
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SiGunGuCell", for: indexPath)
        
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                cell.textLabel?.text = "시"
                cell.detailTextLabel?.text = "지역을 먼저 선택해주세요"
            } else {
                let districtCell = tableView.dequeueReusableCell(withIdentifier: PickDistrictTableViewCell.identifier, for: indexPath) as! PickDistrictTableViewCell
                
                if districtCell.data.isEmpty {
                    districtData.keys.forEach { (si) in
                        districtCell.data.append(si)
                    }
                    districtCell.data.sort()
                    // 서울특별시에서 시작하도록 설정
                    districtCell.districtPickerView.selectRow(8, inComponent: 0, animated: false)
                }
                
                return districtCell
            }
        case 1:
            // TODO: - 구를 먼저 선택하면 오류가 난다! & 두 개의 셀을 모두 열면 오류!
            if indexPath.row == 0 {
                cell.textLabel?.text = "구"
                cell.detailTextLabel?.text = "지역을 먼저 선택해주세요"
            } else {
                let districtCell = tableView.dequeueReusableCell(withIdentifier: PickDistrictTableViewCell.identifier, for: indexPath) as! PickDistrictTableViewCell
                
                if let array = districtData[districtSi] {
                    districtCell.data = array
                }
                
                return districtCell
            }
        default:
            if indexPath.row == 0 {
                cell.textLabel?.text = "동"
            } else {
                
            }
        }
        
        return cell
    }
    
    // MARK: - UITableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isOpened == true {
            isOpened = false
            openedSection = nil
            tableView.beginUpdates()
            tableView.deleteRows(at: [IndexPath(row: 1, section: indexPath.section)], with: .fade)
            tableView.endUpdates()
        } else {
            isOpened = true
            openedSection = indexPath.section
            tableView.beginUpdates()
            tableView.insertRows(at: [IndexPath(row: 1, section: indexPath.section)], with: .fade)
            tableView.endUpdates()
        }
    }
    
}
