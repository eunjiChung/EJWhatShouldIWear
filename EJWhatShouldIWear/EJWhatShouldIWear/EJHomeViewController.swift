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

protocol ControlTableDelegate {
    func reloadTableView()
    func stopPullToRefreshTable()
}

class EJHomeViewController: EJBaseViewController, CLLocationManagerDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, LocationDelegate  {
    
    // MARK: - Properties
    var locations = ["송파", "강동", "성동"]
    var myPickerView: UIPickerView!
    
    var tableDelegate: ControlTableDelegate?
    var FiveDaysWeatherList: [EJFiveDaysList]?
    var FiveDaysWeatherModel: EJFiveDaysWeatherModel?
    var SK3daysWeatherModel: SKThreeThreedays?
    var SK6daysWeatherModel: SKSixSixdaysBase?
    var weatherInfo: Any?
    var currentTemp: String?
    
    // MARK: IBOutlet
    @IBOutlet weak var backgroundView: UIImageView!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var myLocationField: UITextField!
    
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
        
        locationManager.delegate = self as CLLocationManagerDelegate
        
        // 3회 방문시 스토어 리뷰 요청
        AppStoreReviewManager.requestReviewIfAppropriate()
    }
    
    
    // MARK: - CollectionView Data Source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! MainCollectionViewCell
        
        // Delegate
        self.tableDelegate = cell
        cell.locationDelegate = self
        
        // Weather Info
        cell.FiveDaysWeatherList = self.FiveDaysWeatherList
        cell.FiveDaysWeatherModel = self.FiveDaysWeatherModel
        cell.ThreeDaysWeatherModel = self.SK3daysWeatherModel
        cell.WeekelyWeatherModel = self.SK6daysWeatherModel
        cell.currentTemp = self.currentTemp
        cell.location = self.location
        cell.weatherInfo = weatherInfo
        
        // Admob
        cell.admobViewController = self
        
        return cell
    }
    
    // MARK: - Location Delegate
    func updateLocation() {
        checkLocationStatus()
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
        tableDelegate?.stopPullToRefreshTable()
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
        
        tableDelegate?.stopPullToRefreshTable()
    }
    
    func generateInfo(from location: CLLocation) {
        setCurrentLocation(from: location.coordinate)
        setWeatherInfo(of: location)
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
    
    private func setWeatherInfo(of currentLocation: CLLocation) {
        WeatherManager.getLocationInfo(of: currentLocation, success: { country, result in
            
            if result != "" {
                self.location = result
                self.myLocationField.text = self.location
            } else {
                self.popAlertVC(self, title: LocalizedString(with: "unknown_error"), message: "Unknown locality. Please refresh the view.")
            }
            
            if WeatherManager.isLocationKorea() {
                self.requestSKWPWeekWeatherList()
            } else {
                self.requestFiveDaysWeatherList(of: currentLocation)
            }
        }) { (error) in
            self.popAlertVC(self, title: LocalizedString(with: "network_error"), message: error.localizedDescription)
        }
    }
    
    private func requestSKWPWeekWeatherList() {
        WeatherManager.callWeatherInfo(success: { (hourlyWeather, weekelyWeather) in
            self.SK3daysWeatherModel = hourlyWeather
            self.SK6daysWeatherModel = weekelyWeather
            
            self.backgroundView.image = WeatherManager.generateKoreaBackgroundView(by: self.SK3daysWeatherModel)
            self.mainCollectionView.reloadData()
            self.tableDelegate?.reloadTableView()
            self.removeSplashScene()
        }) { (error) in
            self.popAlertVC(self, title: LocalizedString(with: "network_error"), message: error.localizedDescription)
            self.removeSplashScene()
        }
    }
    
    private func requestFiveDaysWeatherList(of current: CLLocation) {
        WeatherManager.owmFiveDaysWeatherInfo(success: { (result) in
            let fivedaysWeather = EJFiveDaysWeatherModel.init(object: result)
            self.FiveDaysWeatherModel = fivedaysWeather
            self.FiveDaysWeatherList = fivedaysWeather.list
            
            // TODO: 다른나라 배경도 설정하기
            self.backgroundView.image = WeatherManager.generateBackgroundView()
            self.mainCollectionView.reloadData()
            self.tableDelegate?.reloadTableView()
            self.removeSplashScene()
        }) { (error) in
            self.popAlertVC(self, title: LocalizedString(with: "network_error"), message: error.localizedDescription)
            self.removeSplashScene()
        }
    }
    
    // MARK: - Private Method
    private func pickUpLocation(_ myTextField: UITextField) {
        // 1. PickerView 정의
        myPickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: EJSizeHeight(216.0)))
        myPickerView.delegate = self
        myPickerView.dataSource = self
        myTextField.inputView = myPickerView
        
        // 2. ToolBar() 정의
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        // 3. 툴바에 버튼 추가
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClick))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        myTextField.inputAccessoryView = toolBar
    }
    
    @objc private func doneClick() {
        myLocationField.resignFirstResponder()
    }
    
    @objc private func cancelClick() {
        myLocationField.resignFirstResponder()
    }
    
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
}

extension EJHomeViewController: UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    // MARK: - PickerView Delegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return locations.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return locations[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.myLocationField.text = locations[row]
    }

    // MARK: - TextField Delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        pickUpLocation(myLocationField)
    }
}
