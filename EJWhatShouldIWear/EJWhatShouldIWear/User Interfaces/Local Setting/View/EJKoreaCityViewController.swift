//
//  EJKoreaCityViewController.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/04/30.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

struct EJKoreaCityNotification {
    static let didDismissViewController = NSNotification.Name(rawValue: "didDismissViewController")
}

class EJKoreaCityViewController: EJBaseViewController {
    // MARK: - Properties
    var citiesModel: [String]?
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
     
        initView()
        initNotification()
        generateCities()
    }
    
    // MARK: - Initialize
    private func initView() {
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1921568627, green: 0.1921568627, blue: 0.1921568627, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    private func initNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didCompleteChoosingLocation(_:)),
                                               name: EJKoreaNeighborNotificationName.didCompleteChoosingLocation,
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: EJKoreaNeighborNotificationName.didCompleteChoosingLocation, object: nil)
    }
    
    // MARK: - Private Methods
    private func generateCities() {
        guard let cities = EJLocationManager.shared.koreaCities else { return }
        citiesModel = []
        cities.forEach { citiesModel?.append($0.cityName) }
    }
    
    @objc func didCompleteChoosingLocation(_ notification: Notification) {
        NotificationCenter.default.post(name: EJKoreaCityNotification.didDismissViewController, object: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - IBActions
    @IBAction func didTouchDismissButton(_ sender: Any) {
        selectionHapticFeedback()
        self.dismiss(animated: true, completion: nil)
    }
}

extension EJKoreaCityViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesModel?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else { return UITableViewCell() }
        if let cityName = citiesModel?[indexPath.row] {
            cell.textLabel?.text = cityName
        }
        return cell
    }
}

extension EJKoreaCityViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectionHapticFeedback()
        
        if citiesModel?[indexPath.row] == "세종특별자치시" {
            performSegue(withIdentifier: "showExceptionSegue", sender: indexPath.row)
        } else {
            performSegue(withIdentifier: "showDistrictSegue", sender: indexPath.row)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showExceptionSegue":
            guard let destination = segue.destination as? EJKoreaNeighborViewController else { return }
            guard let selectedIndexRow = sender as? Int else { return }
            destination.locationNameStack = EJLocationManager.shared.koreaCities?[selectedIndexRow].cityName
            destination.districtName = EJLocationManager.shared.koreaCities?[selectedIndexRow].cityName
            destination.neighborhoods = EJLocationManager.shared.koreaCities?[selectedIndexRow].districts.first?.neighborhoods
        default:
            guard let destination = segue.destination as? EJKoreaDistrictViewController else { return }
            guard let selectedIndexRow = sender as? Int else { return }
            destination.cityModel = EJLocationManager.shared.koreaCities?[selectedIndexRow]
            destination.locationNameStack =  EJLocationManager.shared.koreaCities?[selectedIndexRow].cityName
        }
    }
}
