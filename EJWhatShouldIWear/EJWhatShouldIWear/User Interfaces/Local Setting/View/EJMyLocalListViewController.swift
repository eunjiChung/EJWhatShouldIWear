//
//  EJLocalSettingViewController.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/04/30.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class EJMyLocalListViewController: EJBaseViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Properties
    var locations: [String]?
    
    // MARK: - View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        getMyCurrentLocations()
    }
    
    // MARK: - Initialize
    private func initView() {
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    // MARK: - Private Methods
    private func getMyCurrentLocations() {
        // TODO: - 나중에는 더 추가하기
//        guard let array = myUserDefaults.array(forKey: UserDefaultKey.myLocations.rawValue) as? [String] else { return }
//        locations = array
        locations = ["서울시 강남구 도곡동", "서울시 송파구 가락동", "경기도 광명시", "어쩌구 저쩌구"]
    }
    
    // MARK: - IBActions
    @IBAction func didTouchEdit(_ sender: Any) {
        selectionHapticFeedback()
    }
    
    @IBAction func didTouchDismiss(_ sender: Any) {
        selectionHapticFeedback()
        navigationController?.popViewController(animated: true)
    }
}

extension EJMyLocalListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = locations?.count, (locations?.count) != 0 else { return 1 }
        return count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let count = locations?.count else { return UITableViewCell() }
        if indexPath.row == count {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "EJAddLocationCell") as? EJAddLocationCell else { return UITableViewCell() }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else { return UITableViewCell() }
            if let name = locations?[indexPath.row] {
                cell.textLabel?.text = name
            }
            return cell
        }
    }
}

extension EJMyLocalListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectionHapticFeedback()
    }
}
