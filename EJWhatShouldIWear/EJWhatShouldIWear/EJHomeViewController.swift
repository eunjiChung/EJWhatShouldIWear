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
    
    var currentTemp: String?

    // MARK : - IBOutlet
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    
    // MARK : - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        controlSideMenu()
        registerNibs()
        
        // Pull To Refresh
        addPullToRefreshControl(toScrollView: self.mainTableView) {
            // 새로운 Location 정보 받아오고
            // 해당 Location의 날씨 정보 받아오기
            self.updateLocation()
        }
        
        // Location
        locationManager.delegate = self as CLLocationManagerDelegate
        self.checkLocationStatus()
    }
    
    
    
    
    // MARK : - Location Func
    func checkLocationStatus() {
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse:
            updateLocation()
        default:
            print("location miss")
        }
    }
    
    func updateLocation() {
        locationManager.startUpdatingLocation()
    }
    
    
    // MARK : - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let current = locations.last {
            // current.coordinate = 위도와 경도 정보 저장
            
            let geoCoder = CLGeocoder()
            geoCoder.reverseGeocodeLocation(current) { (list, error) in
                if let error = error {
                    print(error)
                } else {
                    if let first = list?.first {
                        if let gu = first.locality, let dong = first.subLocality {
                            let newlocation = "\(gu) \(dong)"
                            self.location = newlocation
                            
                            // 근데 이걸 여기서 하는게 맞나?
                            self.mainTableView.reloadData()
                        } else {
                            print("알 수 없는 지역")
                        }
                    }
                }
            }
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
            
            cell.locationLabel.text = self.location
//            cell.setTodayTemperature()
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: TimeWeahtherTableViewCell.identifier, for: indexPath) as! TimeWeahtherTableViewCell
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: WeekelyWeatherTableViewCell.identifier, for: indexPath) as! WeekelyWeatherTableViewCell
            
            let item = indexPath.item
//            cell.setWeekelyInfo(to: item)
            
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: AdmobTableViewCell.identifier, for: indexPath) as! AdmobTableViewCell
//            cell.bannerView.adUnitID = googleAdmobUnitID
//            cell.bannerView.rootViewController = self
//            cell.bannerView.load(GADRequest())
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
    func setSettingsLocation() {
        self.performSegue(withIdentifier: "home_setting_segue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "home_setting_segue" {
            let settingVC = segue.destination as! EJSettingViewController
            settingVC.curLocation = self.location
        }
    }
    
    
    // MARK : - Private Method
    private func controlSideMenu() {
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
    
    
    

}
