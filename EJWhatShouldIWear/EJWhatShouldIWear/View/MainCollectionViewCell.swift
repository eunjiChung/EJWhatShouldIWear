//
//  MainCollectionViewCell.swift
//  EJWhatShouldIWear
//
//  Created by eunji on 05/09/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

protocol LocationDelegate {
    func updateLocation()
}

class MainCollectionViewCell: UICollectionViewCell, UITableViewDataSource, UITableViewDelegate, ControlTableDelegate {
    
    // MARK: - Variables
    var FiveDaysWeatherList: [EJFiveDaysList]?
    var FiveDaysWeatherModel: EJFiveDaysWeatherModel?
    var HourlyWeatherModel: SKHourlyHourlyBase?
    var currentTemp: String?
    var admobViewController: UIViewController?
    var weatherInfo: Any?
    
    var locationDelegate: LocationDelegate?
    
    // MARK: Global instance
    var location: String = LocalizedString(with: "unknown")
    
    // MARK: IBOutlets
    @IBOutlet weak var mainTableView: UITableView!
    
    // MARK: View Life Cycle
    override func awakeFromNib() {
        
        mainTableView.dataSource = self as UITableViewDataSource
        mainTableView.delegate = self as UITableViewDelegate
        
        registerNibs()
        
        Library.addPullToRefreshControl(toScrollView: self.mainTableView) {
            self.locationDelegate?.updateLocation()
            self.mainTableView.reloadData()
        }
    }
    
    // MARK: Control TableView delegate
    func reloadTableView() {
        self.mainTableView.reloadData()
    }
    
    func stopPullToRefreshTable() {
        Library.stopPullToRefresh(toScrollView: self.mainTableView)
    }
    
    // MARK: TableView Data Source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section
        {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: ShowClothTableViewCell.identifier, for: indexPath) as! ShowClothTableViewCell
            
            if WeatherManager.isLocationKorea() {
                if let model = HourlyWeatherModel {
                    cell.generateKoreaMain(by: model)
                }
            } else {
                if let model = FiveDaysWeatherModel {
                    cell.generateMain(by: model)
                }
            }
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: TimeWeahtherTableViewCell.identifier, for: indexPath) as! TimeWeahtherTableViewCell
            
            if let model = FiveDaysWeatherModel {
                cell.setTimelyTable(of: model)
            }
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: WeekWeatherTableViewCell.identifier, for: indexPath) as! WeekWeatherTableViewCell
            
            if let info = FiveDaysWeatherList {
                cell.setWeekelyTimeTable(by:info)
            }
            
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: AdmobTableViewCell.identifier, for: indexPath) as! AdmobTableViewCell
            
            if let viewController = admobViewController {
                cell.createAdmob(viewController)
            }
            
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: DummyTableViewCell.identifier, for: indexPath) as! DummyTableViewCell
            return cell
        }
        
    }
    
    
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            return EJSizeHeight(350.0)
        case 1:
            return EJSizeHeight(131.0+50.0+18.0+43.0+18.67)
        case 2:
            return EJSizeHeight(38.0+16.0+20.0+97.0+50.0+13.0)
        case 3:
            return EJSizeHeight(60.0)
        default:
            return EJSizeHeight(80.0)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: HeaderTableViewCell.identifier) as! HeaderTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section
        {
        case 1, 2, 3:
            return EJSizeHeight(0.5)
        default:
            return 0
        }
    }
    
    
    // MARK: Private method
    private func registerNibs() {
        mainTableView.register(UINib.init(nibName: "ShowClothTableViewCell", bundle: nil), forCellReuseIdentifier: ShowClothTableViewCell.identifier)
        mainTableView.register(UINib.init(nibName: "TimeWeahtherTableViewCell", bundle: nil), forCellReuseIdentifier: TimeWeahtherTableViewCell.identifier)
        mainTableView.register(UINib.init(nibName: "WeekWeatherTableViewCell", bundle: nil), forCellReuseIdentifier: WeekWeatherTableViewCell.identifier)
        mainTableView.register(UINib.init(nibName: "AdmobTableViewCell", bundle: nil), forCellReuseIdentifier: AdmobTableViewCell.identifier)
        mainTableView.register(UINib.init(nibName: "DummyTableViewCell", bundle: nil), forCellReuseIdentifier: DummyTableViewCell.identifier)
        mainTableView.register(UINib.init(nibName: "HeaderTableViewCell", bundle: nil), forCellReuseIdentifier: HeaderTableViewCell.identifier)
    }
    
}
