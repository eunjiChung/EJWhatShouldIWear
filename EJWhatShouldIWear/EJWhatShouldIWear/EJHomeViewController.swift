//
//  HomeViewController.swift
//  EJWhatShouldIWear
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 13/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit
import SideMenu
import GoogleMobileAds
import CoreLocation

class EJHomeViewController: EJBaseViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate  {
    
    // MARK : - Data
    var WeatherDescript: EJWeather?
    var WeatherInfo: EJMain?
    var FiveDaysWeatherList: [EJFiveDaysList]?
    var currentTemp: String?

    
    // MARK : - IBOutlet
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    
    // MARK : - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureSideMenu()
        registerNibs()
        
        addPullToRefreshControl(toScrollView: self.mainTableView) {
            self.updateLocation()
        }
        
        locationManager.delegate = self as CLLocationManagerDelegate
        checkLocationStatus()
    }
    
    
    
    // MARK: - UITableView Data Source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 2:
            return 7
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section
        {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: ShowClothTableViewCell.identifier, for: indexPath) as! ShowClothTableViewCell
            
            
            if let info = WeatherInfo, let description = WeatherDescript {
                cell.setCurrentLocality(by: self.location)
                cell.setWeatherInfo(by: info, with: description)
            }
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: TimeWeahtherTableViewCell.identifier, for: indexPath) as! TimeWeahtherTableViewCell
            
            if let list = FiveDaysWeatherList {
                cell.setTimelyTable(info:list)
            }
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: WeekelyWeatherTableViewCell.identifier, for: indexPath) as! WeekelyWeatherTableViewCell
            
            let item = indexPath.item
//            cell.setWeekelyInfo(to: item)
            
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: AdmobTableViewCell.identifier, for: indexPath) as! AdmobTableViewCell
            cell.createAdmob(self)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: DummyTableViewCell.identifier, for: indexPath) as! DummyTableViewCell
            return cell
        }
        
    }
    
    
    // MARK : - TableView Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            return EJSize(540.0)
        case 1:
            return EJSize(200.0)
        case 2:
            return EJSize(50.0)
        case 3:
            return EJSize(50.0)
        default:
            return EJSize(80.0)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: HeaderTableViewCell.identifier) as! HeaderTableViewCell
        
        switch section {
        case 1:
            cell.headerLabel.text = "오늘 시간대별 날씨"
        case 2:
            cell.headerLabel.text = "요번주 날씨"
        case 3:
            cell.headerLabel.text = "광고"
        default:
            cell.headerLabel.text = ""
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        switch section {
        case 1, 2, 3:
            return EJSize(40.0)
        default:
            return 0
        }
    }
    
    
    
    // MARK : - Prepare for Segue
    @IBAction func didTouchMenuBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "home_sidemenu_segue", sender: self)
    }
    
    func setSettingsLocation() {
        self.performSegue(withIdentifier: "home_setting_segue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "home_setting_segue":
            let settingVC = segue.destination as! EJSettingViewController
            settingVC.curLocation = self.location
        case "home_sidemenu_segue":
            //******NavigationController가 끼어있으면 통해서 전달하면 된다!!!
            let navVC = segue.destination as! UISideMenuNavigationController
            let tableVC = navVC.viewControllers.first as! EJSideMenuViewController
            tableVC.curLocation = self.location
        default:
            print("Nothing...")
        }
        
    }
    
    
    
    // MARK : - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let current = locations.last {
            setCurrentLocation(from: current.coordinate)
            requestCurrentWeather(of: current)
            requestFiveDaysWeatherList(of: current)
        }
        
        locationManager.stopUpdatingLocation()
        
        self.stopPullToRefresh(toScrollView: self.mainTableView)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            updateLocation()
        default:
            print("error")
        }
    }
    
    
    
    // MARK : - Private Method
    private func configureSideMenu() {
        SideMenuManager.default.menuPresentMode = .menuSlideIn
        SideMenuManager.default.menuWidth = EJSize(300.0)
        SideMenuManager.default.menuAnimationFadeStrength = 0.7
        SideMenuManager.default.menuAnimationBackgroundColor = UIColor.clear
        SideMenuManager.default.menuShadowColor = UIColor.clear
    }
    
    private func registerNibs() {
        mainTableView.register(UINib.init(nibName: "ShowClothTableViewCell", bundle: nil), forCellReuseIdentifier: ShowClothTableViewCell.identifier)
        mainTableView.register(UINib.init(nibName: "TimeWeahtherTableViewCell", bundle: nil), forCellReuseIdentifier: TimeWeahtherTableViewCell.identifier)
        mainTableView.register(UINib.init(nibName: "WeekelyWeatherTableViewCell", bundle: nil), forCellReuseIdentifier: WeekelyWeatherTableViewCell.identifier)
        mainTableView.register(UINib.init(nibName: "AdmobTableViewCell", bundle: nil), forCellReuseIdentifier: AdmobTableViewCell.identifier)
        mainTableView.register(UINib.init(nibName: "DummyTableViewCell", bundle: nil), forCellReuseIdentifier: DummyTableViewCell.identifier)
        mainTableView.register(UINib.init(nibName: "HeaderTableViewCell", bundle: nil), forCellReuseIdentifier: HeaderTableViewCell.identifier)
    }
    
    
    // MARK : - Request Weather Info
    private func setCurrentLocation(from coordinate:CLLocationCoordinate2D) {
        WeatherManager.latitude = coordinate.latitude
        WeatherManager.longitude = coordinate.longitude
    }
    
    private func requestCurrentWeather(of location: CLLocation) {
        WeatherManager.CurrentWeatherInfo(success: { (result) in
            let currentWeatherInfo = EJCurrentWeather.init(object: result)
            self.WeatherInfo = currentWeatherInfo.main
            self.WeatherDescript = currentWeatherInfo.weather?.first
        }) { (error) in
            print(error)
        }
    }
    
    private func requestFiveDaysWeatherList(of current: CLLocation) {
        WeatherManager.FiveDaysWeatherInfo(success: { (result) in
            let fivedaysWeather = EJFiveDaysWeatherModel.init(object: result)
            self.FiveDaysWeatherList = fivedaysWeather.list
            self.setLocationText(of: current)
        }) { (error) in
            print(error)
        }
    }
    
    private func setLocationText(of current: CLLocation) {
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(current) { (list, error) in
            if let error = error {
                print(error)
            } else {
                if let first = list?.first {
                    if let gu = first.locality, let dong = first.subLocality {
                        self.location = "\(gu) \(dong)"
                        self.mainTableView.reloadData()
                    } else {
                        print("알 수 없는 지역")
                    }
                }
            }
        }
    }

}
