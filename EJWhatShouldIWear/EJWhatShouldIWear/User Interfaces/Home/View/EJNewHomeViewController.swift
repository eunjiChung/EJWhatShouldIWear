//
//  EJNewHomeViewController.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/04/19.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit
import FirebaseAnalytics
import SideMenu

class EJNewHomeViewController: EJBaseViewController {
    // MARK: IBOutlets
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var backgroundView: UIImageView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var myLocationField: UIButton!
    @IBOutlet weak var splashContainer: UIView!
    @IBOutlet weak var alcTopOfStackView: NSLayoutConstraint!
    @IBOutlet weak var alcLeadingOfSideBackButton: NSLayoutConstraint!
    @IBOutlet weak var alcTopOfSideBackButton: NSLayoutConstraint!
    @IBOutlet weak var alcBottomOfMenuButton: NSLayoutConstraint!
    
    // MARK: Properties
    var cellOpened = false
    
    lazy var viewModel: EJNewHomeViewModel = {
        return EJNewHomeViewModel()
    }()
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        initViewModel()
        initNotification()
    }
    
    // MARK: Initialize
    private func initView() {
        registerNibs()
        layout()
        startLoadingIndicator()
        configureSideMenu()
        EJAppStoreReviewManager.requestReviewIfAppropriate()     // 3회 방문시 스토어 리뷰 요청
        
        addPullToRefreshControl(toScrollView: self.mainTableView) {
            EJLocationManager.shared.checkLocationStatus()
            self.mainTableView.reloadData()
        }
    }
    
    private func initViewModel() {
        EJLocationManager.shared.didSuccessUpdateLocationsClosure = {
            self.myLocationField.setTitle(EJLocationManager.shared.locationString, for: .normal)
            
            if EJLocationManager.shared.isKorea() {
                self.viewModel.requestKoreaWeather(0)
            } else {
                self.viewModel.requestFiveDaysWeatherList()
            }
            
            // TODO: - 얘가 이 타이밍에 멈춰도 되나?
            EJLocationManager.shared.stopUpdatingLocation()
            self.stopPullToRefresh(toScrollView: self.mainTableView)
        }
        
        // TODO: - 얘도 수정
        EJLocationManager.shared.didChangeLocationAuthorizationRestrictedClosure = {
            self.popAlertVC(self, title: "localizing_error".localized, message: "localizing_error_msg".localized)
            EJLocationManager.shared.updateDefaultLocation { location in
                EJLocationManager.shared.setNewDefaults(location: location)
//                self.viewModel.getCurrentLocation(nil)
                self.stopPullToRefresh(toScrollView: self.mainTableView)
            }
        }
        
        EJLocationManager.shared.didRestrictLocationAuthorizationClosure = {
            // TODO: - 위치 리스트 보여주기
            
        }
        
        viewModel.didRequestWeatherInfo = { index in
            self.viewModel.requestKoreaWeather(index)
        }
        
        viewModel.didRequestKoreaWeatherInfoSuccessClosure = {
            guard let threedaysModel = self.viewModel.threedaysModel else {
                // TODO: - 모델을 가져오지 못했을 때 에러처리를 해줘야 한다 (현재는 스플래시 뷰가 없어지지 않는 상태)
                return
            }
            self.backgroundView.changeBackGround(with: EJWeatherManager.shared.generateKRBackgroundView(by: threedaysModel))
            self.mainTableView.reloadData()
            self.removeSplashScene()
        }
        
        viewModel.didRequestKoreaWeatherInfoFailureClosure = { error in
            // TODO: - 에러 메시지 띄우기 (어떤 코드 문제인지)
            self.popAlertVC(self, title: "network_error".localized, message: error.localizedDescription)
            self.removeSplashScene()
        }
        
        viewModel.didrequestForeignWeatherInfoSuccessClosure = {
            guard let model = self.viewModel.FiveDaysWeatherModel else { return }
            self.backgroundView.changeBackGround(with: EJWeatherManager.shared.generateBackgroundView(by: model))
            self.mainTableView.reloadData()
            self.removeSplashScene()
        }
        
        viewModel.didrequestForeignWeatherInfoFailureClosure = { error in
            self.popAlertVC(self, title: "network_error".localized, message: error.localizedDescription)
            self.removeSplashScene()
        }
    }
    
    private func initNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(didSelectMainLocation(_:)), name: EJMyLocalListNotification.didSelectMainLocation, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: EJMyLocalListNotification.didSelectMainLocation, object: nil)
    }
    
    // MARK: - Button Action
    @IBAction func didTouchMenuBtn(_ sender: Any) {
        selectionHapticFeedback()
        self.performSegue(withIdentifier: "home_sidemenu_segue", sender: self)
        let title = "didTouchMenuBtn"
        
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "id-\(title)",
            AnalyticsParameterItemName: title,
            AnalyticsParameterContentType: "cont"
        ])
    }
    
    @IBAction func didTouchAddButton(_ sender: Any) {
        selectionHapticFeedback()
        guard let vc = UIStoryboard(name: "Local", bundle: nil).instantiateViewController(withIdentifier: "EJMyLocalListViewController") as? EJMyLocalListViewController else { return }
        self.show(vc, sender: self)
        vc.performSegue(withIdentifier: "showLocalList", sender: vc)
    }
    
    @IBAction func didTouchList(_ sender: Any) {
        // TODO: - 툴바로 조정? 아니면 모달창 띄워서?
    }
    
    
    // MARK: - Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "home_setting_segue":
            let settingVC = segue.destination as! EJSettingViewController
            settingVC.curLocation = EJLocationManager.shared.locationString
        case "home_sidemenu_segue":
            let navVC = segue.destination as! UISideMenuNavigationController
            let tableVC = navVC.viewControllers.first as! EJSideMenuViewController
            tableVC.curLocation = EJLocationManager.shared.locationString
        default:
            EJLogger.d("")
        }
    }
    
    @objc func didSelectMainLocation(_ notification: Notification) {
        myLocationField.setTitle(EJLocationManager.shared.locationString, for: .normal)
        mainTableView.reloadData()
    }
    
}

// MARK: - Tableview DataSource
extension EJNewHomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if EJLocationManager.shared.isKorea() && cellOpened && section == 0 { return 2 }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: ShowClothTableViewCell.identifier, for: indexPath) as! ShowClothTableViewCell
                
                if EJLocationManager.shared.isKorea() {
                    cell.model = viewModel.threedaysModel
                }
                
                if let model = viewModel.FiveDaysWeatherModel {
                    cell.generateMain(by: model)
                }
                
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: ClothsCollectionTableViewCell.identifier, for: indexPath) as! ClothsCollectionTableViewCell
                cell.model = viewModel.threedaysModel
                return cell
            }
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: TimeWeahtherTableViewCell.identifier, for: indexPath) as! TimeWeahtherTableViewCell
            
            if EJLocationManager.shared.isKorea() {
                cell.model = viewModel.threedaysModel
            }
            
            if let model = viewModel.FiveDaysWeatherModel {
                cell.setTimelyTable(of: model)
            }
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: WeekWeatherTableViewCell.identifier, for: indexPath) as! WeekWeatherTableViewCell
            
            if EJLocationManager.shared.isKorea() {
                cell.model = viewModel.sixdaysModel
            }
            
            if let info = viewModel.weatherInfo {
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
    
}

// MARK: - TableView Delegate
extension EJNewHomeViewController: UITableViewDelegate {
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
            if EJLocationManager.shared.isKorea() {
                if EJ_SCREEN_HEIGHT == EJ_SCREEN_7 {
                    return EJSizeHeight(380.0)
                } else {
                    return EJSizeHeight(350.0)
                }
            }
            return EJSizeHeight(234.0)
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
        guard EJLocationManager.shared.isKorea() else { return }
        
        if indexPath.row == 0 && indexPath.section == 0 {
            if cellOpened {
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

// MARK: - Private Methods
private extension EJNewHomeViewController {
    private func removeSplashScene() {
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
                        EJLogger.w("Splash screen already missed")
                    }
                }, completion: nil)
            }
        }
    }
    
    private func registerNibs() {
        mainTableView.register(UINib.init(nibName: "ShowClothTableViewCell", bundle: nil), forCellReuseIdentifier: ShowClothTableViewCell.identifier)
        mainTableView.register(UINib.init(nibName: "TimeWeahtherTableViewCell", bundle: nil), forCellReuseIdentifier: TimeWeahtherTableViewCell.identifier)
        mainTableView.register(UINib.init(nibName: "WeekWeatherTableViewCell", bundle: nil), forCellReuseIdentifier: WeekWeatherTableViewCell.identifier)
        mainTableView.register(UINib.init(nibName: "AdmobTableViewCell", bundle: nil), forCellReuseIdentifier: AdmobTableViewCell.identifier)
        mainTableView.register(UINib.init(nibName: "DummyTableViewCell", bundle: nil), forCellReuseIdentifier: DummyTableViewCell.identifier)
        mainTableView.register(UINib.init(nibName: "HeaderTableViewCell", bundle: nil), forCellReuseIdentifier: HeaderTableViewCell.identifier)
        mainTableView.register(UINib.init(nibName: ClothsCollectionTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ClothsCollectionTableViewCell.identifier)
    }
    
    private func startLoadingIndicator() {
        if loadingIndicator == nil { return }
        loadingIndicator.startAnimating()
    }
    
    private func layout() {
        alcTopOfStackView.constant = EJSizeHeight(414.0)
        alcLeadingOfSideBackButton.constant = EJSize(18.0)
        alcTopOfSideBackButton.constant = EJSizeHeight(46.0)
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
