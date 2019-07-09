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
    
    // MARK: - Data
    var WeatherDescript: EJWeather?
    var WeatherInfo: EJMain?
    var FiveDaysWeatherList: [EJFiveDaysList]?
    var currentTemp: String?

    
    // MARK: - IBOutlet
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var splashContainer: UIView!
    @IBOutlet weak var alcTopOfStackView: NSLayoutConstraint!
    @IBOutlet weak var alcHeightOfNavigationBar: NSLayoutConstraint!
    @IBOutlet weak var alcLeadingOfSideBackButton: NSLayoutConstraint!
    @IBOutlet weak var alcTopOfSideBackButton: NSLayoutConstraint!
    @IBOutlet weak var alcTopOfSettingButton: NSLayoutConstraint!
    @IBOutlet weak var alcTrailingOfSettingButton: NSLayoutConstraint!
    
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        alcTopOfStackView.constant = EJSizeHeight(414.0)
        alcHeightOfNavigationBar.constant = EJSizeHeight(76.0)
        alcLeadingOfSideBackButton.constant = EJSize(18.0)
        alcTopOfSideBackButton.constant = EJSizeHeight(46.0)
        alcTopOfSettingButton.constant = EJSizeHeight(46.0)
        alcTrailingOfSettingButton.constant = EJSize(20.0)
        
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
        return 1
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
            
            if let info = FiveDaysWeatherList {
                cell.setTimelyTable(by:info)
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
            cell.createAdmob(self)
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
            return EJSizeHeight(424.0)
        case 1:
            return EJSizeHeight(261.0)
        case 2:
            return EJSizeHeight(220.0)
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
        
        switch section {
        case 2, 3:
            return EJSizeHeight(7.0)
        default:
            return 0
        }
    }
    
    
    // MARK: - Splash Method
    func removeSplashScene() {
        if self.splashContainer != nil {
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.8, delay: 0.0, options: .curveEaseInOut, animations: {
                    if self.splashContainer != nil {
                        if let splash = self.splashContainer {
                            splash.alpha = 0.0
                            print("THIS ", splash)
                            splash.removeFromSuperview()
                        }
                    } else {
                        self.popAlertVC(self, with: LocalizedString(with: "unknown_error"), "")
                    }
                }, completion: { (success) in
                })
            }
        }
    }
    
    
    // MARK: - Prepare for Segue
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
    
    
    
    // MARK: - CLLocationManagerDelegate
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
    
    
    
    // MARK: - Private Method
    private func configureSideMenu() {
        SideMenuManager.default.menuPresentMode = .menuSlideIn
        SideMenuManager.default.menuWidth = EJSize(263.0)
        SideMenuManager.default.menuAnimationFadeStrength = 0.7
        SideMenuManager.default.menuAnimationBackgroundColor = UIColor.clear
        SideMenuManager.default.menuShadowColor = UIColor.clear
    }
    
    private func registerNibs() {
        mainTableView.register(UINib.init(nibName: "ShowClothTableViewCell", bundle: nil), forCellReuseIdentifier: ShowClothTableViewCell.identifier)
        mainTableView.register(UINib.init(nibName: "TimeWeahtherTableViewCell", bundle: nil), forCellReuseIdentifier: TimeWeahtherTableViewCell.identifier)
        mainTableView.register(UINib.init(nibName: "WeekWeatherTableViewCell", bundle: nil), forCellReuseIdentifier: WeekWeatherTableViewCell.identifier)
        mainTableView.register(UINib.init(nibName: "AdmobTableViewCell", bundle: nil), forCellReuseIdentifier: AdmobTableViewCell.identifier)
        mainTableView.register(UINib.init(nibName: "DummyTableViewCell", bundle: nil), forCellReuseIdentifier: DummyTableViewCell.identifier)
        mainTableView.register(UINib.init(nibName: "HeaderTableViewCell", bundle: nil), forCellReuseIdentifier: HeaderTableViewCell.identifier)
    }
    
    
    // MARK: - Request Weather Info
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
                self.removeSplashScene()
                print(error)
            } else {
                if let first = list?.first {
                    if let gu = first.locality, let dong = first.subLocality {
                        self.location = "\(gu) \(dong)"
                        self.mainTableView.reloadData()
                        self.removeSplashScene()
                    } else {
                        print("알 수 없는 지역")
                        self.popAlertVC(self, with: LocalizedString(with: "network_error"), "Please try again")
                    }
                }
            }
        }
    }

}
