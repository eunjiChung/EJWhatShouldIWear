//
//  EJKoreaCityViewController.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/04/30.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class EJKoreaCityViewController: EJBaseViewController {
    // MARK: - Properties
    var citiesModel: [String]?
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
     
        generateCities()
    }
    
    // MARK: - Private Methods
    private func generateCities() {
        guard let cities = EJLocationManager.shared.koreaCities else { return }
        citiesModel = []
        cities.forEach { citiesModel?.append($0.cityName) }
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
        performSegue(withIdentifier: "showDistrictSegue", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? EJKoreaDistrictViewController else { return }
        guard let selectedIndexRow = sender as? Int else { return }
        destination.cityModel = EJLocationManager.shared.koreaCities?[selectedIndexRow]
        destination.locationNameStack =  EJLocationManager.shared.koreaCities?[selectedIndexRow].cityName
    }
}
