//
//  EJKoreaDistrictViewController.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/04/30.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class EJKoreaDistrictViewController: EJBaseViewController {

    // MARK: - Properties
    var cityModel: EJKoreaCityModel?
    var districts: [String]?
    var locationNameStack: String!
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        generateDistricts()
    }
    
    // MARK: - Private Methods
    private func initView() {
        self.title = cityModel?.cityName
        
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1921568627, green: 0.1921568627, blue: 0.1921568627, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]

        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    private func generateDistricts() {
        guard let model = cityModel else { return }
        districts = []
        model.districts.forEach { district in
            districts?.append(district.districtName)
        }
    }
    
    // MARK: - IBActions
    @IBAction func didTouchDismiss(_ sender: Any) {
        selectionHapticFeedback()
        navigationController?.popViewController(animated: true)
    }
}

// MARk: - TableView Data Source
extension EJKoreaDistrictViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return districts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else { return UITableViewCell() }
        if let districtName = districts?[indexPath.row] {
            cell.textLabel?.text = districtName
        }
        return cell
    }
}

extension EJKoreaDistrictViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectionHapticFeedback()
        performSegue(withIdentifier: "showNeighborSegue", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? EJKoreaNeighborViewController else { return }
        guard let selectedRowIndex = sender as? Int, let districtName = cityModel?.districts[selectedRowIndex].districtName else { return }
        destination.neighborhoods = cityModel?.districts[selectedRowIndex].neighborhoods
        destination.districtName = districtName
        destination.locationNameStack = locationNameStack + " " + districtName
    }
}
