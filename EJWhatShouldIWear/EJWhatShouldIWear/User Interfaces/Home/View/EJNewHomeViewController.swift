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

enum EJHomeSectionType: Int, CaseIterable {
    case showClothSection       = 0
    case timelyWeatherSection
    case weekelyWeatherSection
    case admobSection
    case dummySection
}

enum EJShowClothRowType: Int, CaseIterable {
    case closeClothsCell = 0, showClothsCell
}

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
        
        // TODO: - 얘를 꼭 한번 더 체크 해야겠어? ㅠㅠ
        EJLocationManager.shared.checkAuthorization(nil)
    }
    
    // MARK: Initialize
    private func initView() {
        registerNibs()
        layout()
        startLoadingIndicator()
        configureSideMenu()
        EJAppStoreReviewManager.requestReviewIfAppropriate()     // 3회 방문시 스토어 리뷰 요청
        
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
            guard let vc = UIStoryboard(name: "Local", bundle: nil).instantiateViewController(withIdentifier: "EJMyLocalListViewController") as? EJMyLocalListViewController else { return }
            self.show(vc, sender: self)
            vc.performSegue(withIdentifier: "showLocalList", sender: vc)
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
    
    
    // MARK: - Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "home_setting_segue":
            let settingVC = segue.destination as! EJSettingViewController
            settingVC.curLocation = EJLocationManager.shared.currentLocation
        case "home_sidemenu_segue":
            let navVC = segue.destination as! UISideMenuNavigationController
            let tableVC = navVC.viewControllers.first as! EJSideMenuViewController
            tableVC.curLocation = EJLocationManager.shared.currentLocation
        default:
            EJLogger.d("")
        }
    }
}

// MARK: - Tableview DataSource
extension EJNewHomeViewController: UITableViewDataSource {
    // TODO: - 테이블 섹션모델 만들어서, 이름 달아주기
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
                    cell.model = viewModel.threedaysModel
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
                cell.model = viewModel.threedaysModel
            }
            
            if let model = viewModel.FiveDaysWeatherModel {
                cell.setTimelyTable(of: model)
            }
            
            return cell
        case .weekelyWeatherSection:
            let cell = tableView.dequeueReusableCell(withIdentifier: WeekWeatherTableViewCell.identifier, for: indexPath) as! WeekWeatherTableViewCell
            
            if EJLocationManager.shared.isKorea() {
                cell.model = viewModel.sixdaysModel
            }
            
            if let info = viewModel.weatherInfo {
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
    }
    
    private func configureSideMenu() {
        SideMenuManager.default.menuPresentMode = .menuSlideIn
        SideMenuManager.default.menuWidth = EJSize(263.0)
        SideMenuManager.default.menuAnimationFadeStrength = 0.7
        SideMenuManager.default.menuAnimationBackgroundColor = UIColor.clear
        SideMenuManager.default.menuShadowColor = UIColor.clear
    }
}
