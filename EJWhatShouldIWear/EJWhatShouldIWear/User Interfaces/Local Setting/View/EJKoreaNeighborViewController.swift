//
//  EJKoreaNeighborViewController.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/04/30.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class EJKoreaNeighborViewController: EJBaseViewController {

    // MARK: - Properties
    var locationNameStack: String!
    var districtName : String?
    var neighborhoods: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }
    
    private func initView() {
        self.title = districtName ?? "군・구"
    }
    
    // MARK: - IBAction
    @IBAction func didTouchComplete(_ sender: Any) {
        EJUserDefaultsManager.shared.updateLocationList(locationNameStack)
        // TODO: - delegate나 notification을 호출하여 위치와 테이블 업데이트
        
        navigationController?.popViewController(animated: true)
    }
}

extension EJKoreaNeighborViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return neighborhoods?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else { return UITableViewCell() }
        if let neighborName = neighborhoods?[indexPath.row] {
            cell.textLabel?.text = neighborName
        }
        return cell
    }
}

extension EJKoreaNeighborViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectionHapticFeedback()
        
        if let name = neighborhoods?[indexPath.row] {
            self.locationNameStack += (" " + name)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        selectionHapticFeedback()
        
        if let name = neighborhoods?[indexPath.row] {
            // TODO: - 선택해제한 이름을 nameStack에서 제거
        }
    }
}
