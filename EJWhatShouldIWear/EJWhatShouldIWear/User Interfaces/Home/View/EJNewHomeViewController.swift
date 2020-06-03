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
import CoreLocation

class EJNewHomeViewController: EJBaseViewController {
    // MARK: IBOutlets
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var backgroundView: UIImageView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var myLocationField: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var splashContainer: UIView!
    @IBOutlet weak var alcTopOfStackView: NSLayoutConstraint!
    @IBOutlet weak var alcLeadingOfSideBackButton: NSLayoutConstraint!
    @IBOutlet weak var alcTopOfSideBackButton: NSLayoutConstraint!
    @IBOutlet weak var alcBottomOfMenuButton: NSLayoutConstraint!
    
    @IBOutlet weak var pulldownImage: UIImageView!
    
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
        
        // TODO: - EJNewHomeViewController의 closure가 미리 컴파일(?)되지 않아 작동하지 않으므로...
        EJLocationManager.shared.checkAuthorization(nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let country = EJLocationManager.shared.selectedCountry else { return }
        switch country {
        case .korea:
            myLocationField.isUserInteractionEnabled = true
            addButton.isHidden = false
        case .foreign:
            myLocationField.isUserInteractionEnabled = false
            addButton.isHidden = true
        }
    }
    
    // MARK: Initialize
    private func initView() {
        registerNibs()
        layout()
        startLoadingIndicator()
        configureSideMenu()
        EJAppStoreReviewManager.requestReviewIfAppropriate()     // 3회 방문시 스토어 리뷰 요청
        
        if !myUserDefaults.bool(forKey: UserDefaultKey.isExistingUser) {
            guard let introVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EJIntroViewController") as? EJIntroViewController else { return }
            introVC.modalPresentationStyle = .fullScreen
            present(introVC, animated: false) { }
        }
        
        addPullToRefreshControl(toScrollView: self.mainTableView) {
            EJLocationManager.shared.checkAuthorization(nil)
            self.mainTableView.reloadData()
        }
    }
    
    private func initViewModel() {
        EJLocationManager.shared.didSuccessUpdateLocationsClosure = {
            self.myLocationField.setTitle(EJLocationManager.shared.currentLocation, for: .normal)
            
            if EJLocationManager.shared.isKorea() {
                self.viewModel.requestKoreaWeather(0)
            } else {
                self.viewModel.requestFiveDaysWeatherList()
            }
            
            EJLocationManager.shared.stopUpdatingLocation()
        }
        
        EJLocationManager.shared.didRestrictLocationAuthorizationClosure = {
            guard myUserDefaults.bool(forKey: UserDefaultKey.isExistingUser) else { return }
            
            guard let vc = UIStoryboard(name: "Local", bundle: nil).instantiateViewController(withIdentifier: "EJMyLocalListViewController") as? EJMyLocalListViewController else { return }
            self.show(vc, sender: self)
            vc.performSegue(withIdentifier: "showLocalList", sender: vc)
        }
        
        EJLocationManager.shared.didRestrictAbroadAuthorizationClosure = {
            self.popAlertVC(self, title: "Alert".localized, message: "Allow location access".localized)
            self.viewModel.requestFiveDaysWeatherList()
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
            
            self.stopPullToRefresh(toScrollView: self.mainTableView)
            self.removeSplashScene()
        }
        
        viewModel.didRequestKoreaWeatherInfoFailureClosure = { error in
            // TODO: - 에러 메시지 띄우기 (어떤 코드 문제인지)
            self.popAlertVC(self, title: "network_error".localized, message: error.localizedDescription)
            
            self.stopPullToRefresh(toScrollView: self.mainTableView)
            self.removeSplashScene()
        }
        
        viewModel.didrequestForeignWeatherInfoSuccessClosure = {
            guard let model = self.viewModel.FiveDaysWeatherModel else { return }
            self.backgroundView.changeBackGround(with: EJWeatherManager.shared.generateBackgroundView(by: model))
            
            self.stopPullToRefresh(toScrollView: self.mainTableView)
            self.mainTableView.reloadData()
            self.removeSplashScene()
        }
        
        viewModel.didrequestForeignWeatherInfoFailureClosure = { error in
            self.popAlertVC(self, title: "network_error".localized, message: error.localizedDescription)
            
            self.stopPullToRefresh(toScrollView: self.mainTableView)
            self.removeSplashScene()
        }
        
        // MARK: - Kisang Weather
        viewModel.didRequestKisangWeatherInfoSuccessClosure = {
            // TODO: - 배경화면 넣기 테스트
            self.backgroundView.changeBackGround(with: EJWeatherManager.shared.koreaBackgroundImage(by: self.viewModel.kisangTimelyModel))
            self.mainTableView.reloadData()
            self.stopPullToRefresh(toScrollView: self.mainTableView)
            self.removeSplashScene()
        }
        
        viewModel.didRequestKisangWeatherInfoFailureClosure = { error in
            // TODO: - 에러 메시지 띄우기 (어떤 코드 문제인지)
            self.popAlertVC(self, title: "network_error".localized, message: error.localizedDescription)
            
            self.stopPullToRefresh(toScrollView: self.mainTableView)
            self.removeSplashScene()
        }
        
    }
    
    private func initNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(isNotKoeraLocation(_:)), name: EJMyLocalListNotification.isNotKoreaLocation, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: EJMyLocalListNotification.isNotKoreaLocation, object: nil)
    }
    
    @objc func isNotKoeraLocation(_ notification: Notification) {
        EJLocationManager.shared.checkAbroadAuthorization()
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
        // TODO: - 하단에 bottom drawer 만들기
    }
}

// MARK: - Segue Handler
extension EJNewHomeViewController {
    enum SegueIdentifierType: String {
        case showSetting    = "home_setting_segue"
        case showSideMenu   = "home_sidemenu_segue"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueType = SegueIdentifierType(rawValue: segue.identifier ?? "") else { return }
        
        switch segueType {
        case .showSetting:
            let settingVC = segue.destination as! EJSettingViewController
            settingVC.curLocation = EJLocationManager.shared.currentLocation
        case .showSideMenu:
            let navVC = segue.destination as! UISideMenuNavigationController
            let tableVC = navVC.viewControllers.first as! EJSideMenuViewController
            tableVC.curLocation = EJLocationManager.shared.currentLocation
        }
    }
}

// MARK: - Tableview Data Source
extension EJNewHomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return EJHomeSectionType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if EJLocationManager.shared.isKorea() && cellOpened && section == EJHomeSectionType.showClothSection.rawValue { return 2 }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sectionType = EJHomeSectionType(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch sectionType {
        case .showClothSection:
            guard let rowType = EJShowClothRowType(rawValue: indexPath.row) else { return UITableViewCell() }
            switch rowType {
            case .closeClothsCell:
                let cell = tableView.dequeueReusableCell(withIdentifier: ShowClothTableViewCell.identifier, for: indexPath) as! ShowClothTableViewCell
                
                if EJLocationManager.shared.isKorea() {
                    cell.newModels = viewModel.kisangTimelyModel
                    cell.newItems = viewModel.kisangTimelyItems
                }
                
                if let model = viewModel.FiveDaysWeatherModel {
                    cell.generateMain(by: model)
                }
                
                return cell
            case .showClothsCell:
                let cell = tableView.dequeueReusableCell(withIdentifier: ClothsCollectionTableViewCell.identifier, for: indexPath) as! ClothsCollectionTableViewCell
                cell.model = viewModel.threedaysModel
                return cell
            }
        case .timelyWeatherSection:
            let cell = tableView.dequeueReusableCell(withIdentifier: TimeWeahtherTableViewCell.identifier, for: indexPath) as! TimeWeahtherTableViewCell

            if EJLocationManager.shared.isKorea() {
                cell.newModels = viewModel.kisangTimelyModel
            }
            
            if let model = viewModel.FiveDaysWeatherModel {
                cell.setTimelyTable(of: model)
            }
            
            return cell
        case .weekelyWeatherSection:
            let cell = tableView.dequeueReusableCell(withIdentifier: WeekWeatherTableViewCell.identifier, for: indexPath) as! WeekWeatherTableViewCell
            
            if EJLocationManager.shared.isKorea() {
                cell.models = viewModel.kisangWeekelyModel
            }
            
            if let info = viewModel.FiveDaysWeatherList {
                cell.setWeekelyTimeTable(by:info)
            }
            
            return cell
        case .admobSection:
            let cell = tableView.dequeueReusableCell(withIdentifier: AdmobTableViewCell.identifier, for: indexPath) as! AdmobTableViewCell
            cell.createAdmob(self)
            return cell
        case .dummySection:
            let cell = tableView.dequeueReusableCell(withIdentifier: DummyTableViewCell.identifier, for: indexPath) as! DummyTableViewCell
            return cell
        }
    }
    
}

// MARK: - TableView Delegate
extension EJNewHomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let sectionType = EJHomeSectionType(rawValue: indexPath.section) else { return 0 }
        
        switch sectionType {
        case .showClothSection:
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
        case .timelyWeatherSection:
            return EJSizeHeight(290.0)
        case .weekelyWeatherSection:
            if EJLocationManager.shared.isKorea() {
                if EJ_SCREEN_HEIGHT == EJ_SCREEN_7 {
                    return EJSizeHeight(380.0)
                } else {
                    return EJSizeHeight(350.0)
                }
            }
            return EJSizeHeight(234.0)
        case .admobSection:
            return EJSizeHeight(60.0)
        case .dummySection:
            return EJSizeHeight(80.0)
        }
    }
    
    // TODO: - 이게 왜 필요하지?
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: HeaderTableViewCell.identifier) as! HeaderTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard EJLocationManager.shared.isKorea() else { return }
        
        if indexPath.section == EJHomeSectionType.showClothSection.rawValue, indexPath.row == EJShowClothRowType.closeClothsCell.rawValue {
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
    // TODO: - SplashView 다시 만들기
    private func removeSplashScene() {
        if self.splashContainer != nil {
            // TODO: - I put this method here...But this is not proper location
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
        
        pulldownImage.transform = CGAffineTransform(rotationAngle: (3.0 * .pi) / 2.0)
    }
    
    private func configureSideMenu() {
        SideMenuManager.default.menuPresentMode = .menuSlideIn
        SideMenuManager.default.menuWidth = EJSize(263.0)
        SideMenuManager.default.menuAnimationFadeStrength = 0.7
        SideMenuManager.default.menuAnimationBackgroundColor = UIColor.clear
        SideMenuManager.default.menuShadowColor = UIColor.clear
    }
}
