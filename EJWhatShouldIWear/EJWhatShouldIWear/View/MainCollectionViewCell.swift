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
    var ThreeDaysWeatherModel: SKThreeThreedays?
    var WeekelyWeatherModel: SKSixSixdaysBase?
    var currentTemp: String?
    var admobViewController: UIViewController?
    var weatherInfo: Any?
    
    var locationDelegate: LocationDelegate?
    
    // MARK: Global instance
    var location: String = LocalizedString(with: "unknown")
    var cellOpened = false
    
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
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if WeatherManager.isLocationKorea() && cellOpened == true && section == 0 {
            return 2
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section
        {
        case 0:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: ShowClothTableViewCell.identifier, for: indexPath) as! ShowClothTableViewCell
                
                // 한국일 경우
                if let model = ThreeDaysWeatherModel {
                    cell.generateKoreaMain(by: model)
                }
                // 외국일 경우
                if let model = FiveDaysWeatherModel {
                    cell.generateMain(by: model)
                }
                
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: ClothsCollectionTableViewCell.identifier, for: indexPath) as! ClothsCollectionTableViewCell
                
                if let model = ThreeDaysWeatherModel {
                    cell.clothList(by: model)
                }
                
                return cell
            }
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: TimeWeahtherTableViewCell.identifier, for: indexPath) as! TimeWeahtherTableViewCell
            
            // 한국일 경우
            if let model = ThreeDaysWeatherModel {
                cell.setKRTimelyTable(of: model)
            }
            // 외국일 경우
            if let model = FiveDaysWeatherModel {
                cell.setTimelyTable(of: model)
            }
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: WeekWeatherTableViewCell.identifier, for: indexPath) as! WeekWeatherTableViewCell
            
            // 한국일 경우
            if let model = WeekelyWeatherModel {
                cell.setKoreaWeekelyTimeTable(by: model)
            }
            // 외국일 경우
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
            if indexPath.row == 0 {
                if EJ_SCREEN_HEIGHT == EJ_SCREEN_7_PLUS {
                    return EJSizeHeight(400.0)
                } else if EJ_SCREEN_HEIGHT == EJ_SCREEN_7 {
                    return EJSizeHeight(420.0)
                } else {
                    return EJSizeHeight(350.0)
                }
            } else {
                if EJ_SCREEN_HEIGHT == EJ_SCREEN_HEIGHT_812 {
                    return EJSizeHeight(150.0)
                } else {
                    return EJSizeHeight(180.0)
                }
            }
        case 1:
            return EJSizeHeight(290.0)
        case 2:
            if EJ_SCREEN_HEIGHT == EJ_SCREEN_7 {
                return EJSizeHeight(380.0)
            } else {
                return EJSizeHeight(350.0)
            }
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
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if WeatherManager.isLocationKorea() {
            if indexPath.row == 0 && indexPath.section == 0 {
                if cellOpened == true {
                    cellOpened = false
                    tableView.beginUpdates()
                    tableView.deleteRows(at: [IndexPath(row: 1, section: 0)], with: .fade)
                    tableView.endUpdates()
                } else {
                    cellOpened = true
                    tableView.beginUpdates()
                    tableView.insertRows(at: [IndexPath(row: 1, section: 0)], with: .fade)
                    tableView.endUpdates()
                }
            }
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
        mainTableView.register(UINib.init(nibName: ClothsCollectionTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ClothsCollectionTableViewCell.identifier)
    }
    
}
