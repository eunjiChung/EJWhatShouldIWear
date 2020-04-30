//
//  EJKoreaNeighborViewController.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/04/30.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

struct EJKoreaNeighborNotificationName {
    static let didCompleteChoosingLocation = NSNotification.Name(rawValue: "didCompleteChoosingLocation")
}

class EJKoreaNeighborViewController: EJBaseViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var locationNameStack: String!
    var originalNameStack = ""
    var districtName : String?
    var neighborhoods: [String]?
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }
    
    // MARK: - Initialize
    private func initView() {
        self.title = districtName ?? "군・구"
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1921568627, green: 0.1921568627, blue: 0.1921568627, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(UINib(nibName: "EJNameTableViewCell", bundle: nil), forCellReuseIdentifier: EJNameTableViewCell.identifier)
    }
    
    // MARK: - IBAction
    @IBAction func didTouchComplete(_ sender: Any) {
        // TODO: - 나중에 clear해주기
        EJUserDefaultsManager.shared.locationAddNew(locationNameStack)
        NotificationCenter.default.post(name: EJKoreaNeighborNotificationName.didCompleteChoosingLocation, object: nil, userInfo: nil)
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func didTouchDismiss(_ sender: Any) {
        selectionHapticFeedback()
        navigationController?.popViewController(animated: true)
    }
    
}

extension EJKoreaNeighborViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return neighborhoods?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EJNameTableViewCell.identifier) as? EJNameTableViewCell else { return UITableViewCell() }
        if let neighborName = neighborhoods?[indexPath.row] {
            cell.locationLabel.text = neighborName
        }
        return cell
    }
}

extension EJKoreaNeighborViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectionHapticFeedback()
    
        if originalNameStack == "" { originalNameStack = locationNameStack }
        if let name = neighborhoods?[indexPath.row] { locationNameStack += (" " + name) }
        
        guard let cell = tableView.cellForRow(at: indexPath) as? EJNameTableViewCell else { return }
        cell.checkImageview.isHidden = false
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        selectionHapticFeedback()
        locationNameStack = originalNameStack
        
        guard let cell = tableView.cellForRow(at: indexPath) as? EJNameTableViewCell else { return }
        cell.checkImageview.isHidden = true
    }
}
