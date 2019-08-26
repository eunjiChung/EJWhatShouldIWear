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
import UserNotifications
import FirebaseAnalytics

class EJHomeViewController: EJBaseViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate  {
    
    // MARK: - Data
    var FiveDaysWeatherList: [EJFiveDaysList]?
    var FiveDaysWeatherModel: EJFiveDaysWeatherModel?
    var currentTemp: String?
    
    
    // MARK: IBOutlet
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var splashContainer: UIView!
    @IBOutlet weak var alcTopOfStackView: NSLayoutConstraint!
    @IBOutlet weak var alcLeadingOfSideBackButton: NSLayoutConstraint!
    @IBOutlet weak var alcTopOfSideBackButton: NSLayoutConstraint!
    @IBOutlet weak var alcTopOfSettingButton: NSLayoutConstraint!
    @IBOutlet weak var alcTrailingOfSettingButton: NSLayoutConstraint!
    @IBOutlet weak var alcBottomOfMenuButton: NSLayoutConstraint!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    
    // MARK: Global instance
    var location: String = LocalizedString(with: "unknown")
    
    lazy var locationManager: CLLocationManager = {
        let m = CLLocationManager()
        m.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        return m
    }()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startLoadingIndicator()
        layout()
        configureSideMenu()
        registerNibs()
        
        locationManager.delegate = self as CLLocationManagerDelegate
        
        addPullToRefreshControl(toScrollView: self.mainTableView) {
            self.checkLocationStatus()
        }
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
            
            if let model = FiveDaysWeatherModel {
                cell.setCurrentLocality(by: self.location)
                cell.generateMain(by: model)
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
            return EJSizeHeight(146.0+62.0+179.67+34.0)
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
        case 2, 3:
            return EJSizeHeight(7.0)
        default:
            return 0
        }
    }
    
    // MARK: - Splash Method
    func removeSplashScene() {
        if self.splashContainer != nil {
            
            // I put this method here...But this is not proper location 
            self.requestAppVersionInfo()
            
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.8, delay: 0.0, options: .curveEaseInOut, animations: {
                    if self.splashContainer != nil {
                        if let splash = self.splashContainer, let indicator = self.loadingIndicator {
                            splash.alpha = 0.0
                            indicator.alpha = 0.0
                            
                            indicator.removeFromSuperview()
                            splash.removeFromSuperview()
                        }
                    } else {
                        print("Splash screen already missed")
                    }
                }, completion: nil)
            }
        }
    }
    
    
    // MARK: - Prepare for Segue
    @IBAction func didTouchMenuBtn(_ sender: Any) {
        Library.selectionHapticFeedback()
        self.performSegue(withIdentifier: "home_sidemenu_segue", sender: self)
        
        let title = "didTouchMenuBtn"
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "id-\(title)",
            AnalyticsParameterItemName: title,
            AnalyticsParameterContentType: "cont"
            ])
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
    
    // 시작할 때 자동적으로 이 메소드가 실행된다
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            self.popAlertVC(self, title: LocalizedString(with: "localizing_error"), message: LocalizedString(with: "localizing_error_msg"))
            updateDefaultLocation()
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let current = locations.last
        {
            let lat = current.coordinate.latitude
            let lon = current.coordinate.longitude
            let newCoordinate = ["latitude": lat, "longitude": lon]
            myUserDefaults.set(newCoordinate, forKey: LOCATION_KEY)
            generateInfo(from: current)
        }
        
        locationManager.stopUpdatingLocation()
        self.stopPullToRefresh(toScrollView: self.mainTableView)
    }
    
    // MARK: Location Method
    func updateDefaultLocation() {
        if myUserDefaults.dictionary(forKey: LOCATION_KEY) == nil {
            let dictionary = ["latitude" : 37.50587, "longitude" : 127.11246]
            myUserDefaults.set(dictionary, forKey: LOCATION_KEY)
        }
        
        if let location = myUserDefaults.dictionary(forKey: LOCATION_KEY)
        {
            let lat = location["latitude"] as! Double
            let lon = location["longitude"] as! Double
            let defaultLocation = CLLocation(latitude: lat, longitude: lon)
            generateInfo(from: defaultLocation)
        }
        
        self.stopPullToRefresh(toScrollView: self.mainTableView)
    }
    
    func generateInfo(from location: CLLocation) {
        setCurrentLocation(from: location.coordinate)
        requestFiveDaysWeatherList(of: location)
    }
    
    // 얘가 굳이 필요할까?
    func checkLocationStatus() {
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .notDetermined:
            // 설정이 안돼있으면 request하기
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            updateDefaultLocation()
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        }
    }
    
    // MARK: - Request Weather Info
    private func setCurrentLocation(from coordinate:CLLocationCoordinate2D) {
        WeatherManager.latitude = coordinate.latitude
        WeatherManager.longitude = coordinate.longitude
    }
    
    private func requestFiveDaysWeatherList(of current: CLLocation) {
        WeatherManager.FiveDaysWeatherInfo(success: { (result) in
            let fivedaysWeather = EJFiveDaysWeatherModel.init(object: result)
            self.FiveDaysWeatherModel = fivedaysWeather
            self.FiveDaysWeatherList = fivedaysWeather.list
            self.setLocationText(of: current)
        }) { (error) in
            print(error)
        }
    }
    
    private func setLocationText(of current: CLLocation) {
        WeatherManager.getLocationInfo(of: current,
                                       success: { result in
                                        
                                        if result != "" {
                                            self.location = result
                                            self.mainTableView.reloadData()
                                        } else {
                                            self.popAlertVC(self, title: LocalizedString(with: "unknown_error"), message: "Unknown locality. Please refresh the view.")
                                        }
                                        
                                        self.removeSplashScene()
        }) { error in
            self.popAlertVC(self, title: LocalizedString(with: "network_error"), message: error.localizedDescription)
            self.removeSplashScene()
        }
    }
    
    
    // MARK: - Private Method
    private func startLoadingIndicator() {
        // 얘는 없으면 자동적으로 동작하지 않는가...?
        if loadingIndicator == nil { return }
        loadingIndicator.startAnimating()
    }
    
    
    private func layout() {
        alcTopOfStackView.constant = EJSizeHeight(414.0)
        alcLeadingOfSideBackButton.constant = EJSize(18.0)
        alcTopOfSideBackButton.constant = EJSizeHeight(46.0)
        alcTopOfSettingButton.constant = EJSizeHeight(46.0)
        alcTrailingOfSettingButton.constant = EJSize(20.0)
        alcBottomOfMenuButton.constant = EJSizeHeight(8.0)
    }
    
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
    
}
