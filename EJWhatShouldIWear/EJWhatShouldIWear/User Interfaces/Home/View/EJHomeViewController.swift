//
//  EJHomeViewController.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/04/19.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit
import FirebaseAnalytics
import SideMenu
import CoreLocation
import SkeletonView

class EJHomeViewController: EJBaseViewController {
    // MARK: IBOutlets
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var backgroundView: UIImageView!
    @IBOutlet weak var myLocationField: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var alcLeadingOfSideBackButton: NSLayoutConstraint!
    @IBOutlet weak var alcTopOfSideBackButton: NSLayoutConstraint!
    @IBOutlet weak var alcBottomOfMenuButton: NSLayoutConstraint!
    @IBOutlet weak var pulldownImage: UIImageView!
    
    // MARK: Properties
    var cellOpened = false
    var didUsedSkeleton = false
    
    lazy var viewModel: EJHomeViewModel = {
        return EJHomeViewModel()
    }()
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        initViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        myLocationField.isUserInteractionEnabled = EJLocationManager.shared.isKorea
        addButton.isHidden = !EJLocationManager.shared.isKorea
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if !didUsedSkeleton {
            mainTableView.isSkeletonable = true
            mainTableView.visibleCells.forEach({ $0.showAnimatedGradientSkeleton() })
            didUsedSkeleton = true
        }
    }
    
    // MARK: Initialize
    private func initView() {
        layout()
        registerNibs()
        configureSideMenu()

        myLocationField.setTitle(EJLocationManager.shared.currentLocation, for: .normal)
        
        addPullToRefreshControl(toScrollView: self.mainTableView) {
            EJLocationManager.shared.checkAuth()
            self.mainTableView.reloadData()
        }
    }
    
    private func initViewModel() {
        EJLocationManager.shared.didSuccessUpdateLocationsClosure = {
            self.myLocationField.setTitle(EJLocationManager.shared.currentLocation, for: .normal)
//            self.viewModel.requestWeather()
            self.viewModel.requestKoreaWeather()
        }
        
        EJLocationManager.shared.didRestrictLocationAuthorizationClosure = {
            // TODO: - 여기서는 이제 뭘해주지?
            print("Do nothing...")

            if EJLocationManager.shared.hasMainLocations {
                EJLocationManager.shared.updateMainLocation(EJLocationManager.shared.currentLocation)
            }
        }
        
        viewModel.didrequestForeignWeatherInfoSuccessClosure = {
            guard let model = self.viewModel.FiveDaysWeatherModel else { return }
            self.backgroundView.changeBackGround(with: EJWeatherManager.generateBackgroundView(by: model))
            
            self.stopPullToRefresh(toScrollView: self.mainTableView)

            self.mainTableView.stopSkeletonAnimation()
            self.view.hideSkeleton()

            self.mainTableView.reloadData()
        }
        
        viewModel.didrequestForeignWeatherInfoFailureClosure = { error in
            self.popAlertVC(self, title: "network_error".localized, message: error.localizedDescription)
            self.stopPullToRefresh(toScrollView: self.mainTableView)
        }
        
        // MARK: - Kisang Weather
        viewModel.didRequestKisangWeatherInfoSuccessClosure = {
            self.backgroundView.changeBackGround(with: EJWeatherManager.koreaBackgroundImage(by: self.viewModel.kisangTimeModel))
            self.menuButton.tintColor = titleColor
            self.addButton.tintColor = titleColor
            self.myLocationField.setTitleColor(titleColor, for: .normal)
            self.pulldownImage.tintColor = titleColor

            self.mainTableView.stopSkeletonAnimation()
            self.view.hideSkeleton()

            self.mainTableView.reloadData()

            self.stopPullToRefresh(toScrollView: self.mainTableView)
        }
        
        viewModel.didRequestKisangWeatherInfoFailureClosure = { error in
            self.popAlertVC(self, title: "network_error".localized, message: error)
            self.stopPullToRefresh(toScrollView: self.mainTableView)
        }

//        self.viewModel.requestWeather()
        self.viewModel.requestKoreaWeather()
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
        selectionHapticFeedback()
        performSegue(withIdentifier: "showDrawer", sender: nil)
    }
}

// MARK: - Tableview Data Source
extension EJHomeViewController: SkeletonTableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return EJHomeSectionType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if EJLocationManager.shared.isKorea && cellOpened && section == EJHomeSectionType.showClothSection.rawValue { return 2 }
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
                
                if EJLocationManager.shared.isKorea {
                    cell.timeModels = viewModel.kisangTimeModel
                }
                
                if let model = viewModel.FiveDaysWeatherModel {
                    cell.generateMain(by: model)
                }
                
                return cell
            case .showClothsCell:
                let cell = tableView.dequeueReusableCell(withIdentifier: ClothsCollectionTableViewCell.identifier, for: indexPath) as! ClothsCollectionTableViewCell
                
                if let model = viewModel.kisangTimeModel {
                    cell.models = model
                }

                return cell
            }
        case .timelyWeatherSection:
            let cell = tableView.dequeueReusableCell(withIdentifier: TimeWeahtherTableViewCell.identifier, for: indexPath) as! TimeWeahtherTableViewCell

            if EJLocationManager.shared.isKorea {
                cell.models = viewModel.kisangTimeModel
            }
            
            if let model = viewModel.FiveDaysWeatherModel {
                cell.setTimelyTable(of: model)
            }
            
            return cell
        case .weekelyWeatherSection:
            let cell = tableView.dequeueReusableCell(withIdentifier: WeekWeatherTableViewCell.identifier, for: indexPath) as! WeekWeatherTableViewCell
            
            if EJLocationManager.shared.isKorea {
                cell.baseTime = viewModel.kisangWeekelyModel.date
                cell.models = viewModel.kisangWeekelyModel.model
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

    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        guard let sectionType = EJHomeSectionType(rawValue: indexPath.section) else { return "" }
        switch sectionType {
        case .showClothSection:     return ShowClothTableViewCell.identifier
        case .timelyWeatherSection: return TimeWeahtherTableViewCell.identifier
        case .weekelyWeatherSection:return WeekWeatherTableViewCell.identifier
        case .admobSection:         return AdmobTableViewCell.identifier
        case .dummySection:         return DummyTableViewCell.identifier
        }
    }
}

// MARK: - TableView Delegate
extension EJHomeViewController: UITableViewDelegate {
    // TODO: - automation tableview row로 없애기
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
            if EJLocationManager.shared.isKorea {
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard EJLocationManager.shared.isKorea else { return }
        
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

// MARK: - Segue Handler
extension EJHomeViewController {
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
            tableVC.didSelectBookmarkedLocationRow = {
                guard let vc = UIStoryboard(name: "Local", bundle: nil).instantiateViewController(withIdentifier: "EJMyLocalListViewController") as? EJMyLocalListViewController else { return }
                self.show(vc, sender: self)
                vc.performSegue(withIdentifier: "showLocalList", sender: vc)
            }
            tableVC.didSelectShareRow = {
                guard let shareVC = self.storyboard?.instantiateViewController(withIdentifier: "EJShareViewController") as? EJShareViewController else { return }
                self.show(shareVC, sender: self)
            }
            tableVC.didSelectSatelliteRow = {
                guard let satelliteVC = UIStoryboard(name: "WebView", bundle: nil).instantiateViewController(withIdentifier: "EJWebViewController") as? EJWebViewController else { return }
                self.show(satelliteVC, sender: nil)
            }
        }
    }
}

// MARK: - Private Methods
private extension EJHomeViewController {
    
    private func registerNibs() {
        mainTableView.register(UINib.init(nibName: "ShowClothTableViewCell", bundle: nil), forCellReuseIdentifier: ShowClothTableViewCell.identifier)
        mainTableView.register(UINib.init(nibName: "TimeWeahtherTableViewCell", bundle: nil), forCellReuseIdentifier: TimeWeahtherTableViewCell.identifier)
        mainTableView.register(UINib.init(nibName: "WeekWeatherTableViewCell", bundle: nil), forCellReuseIdentifier: WeekWeatherTableViewCell.identifier)
        mainTableView.register(UINib.init(nibName: "AdmobTableViewCell", bundle: nil), forCellReuseIdentifier: AdmobTableViewCell.identifier)
        mainTableView.register(UINib.init(nibName: "DummyTableViewCell", bundle: nil), forCellReuseIdentifier: DummyTableViewCell.identifier)
        mainTableView.register(UINib.init(nibName: "HeaderTableViewCell", bundle: nil), forCellReuseIdentifier: HeaderTableViewCell.identifier)
        mainTableView.register(UINib.init(nibName: ClothsCollectionTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ClothsCollectionTableViewCell.identifier)
    }
    
    private func layout() {
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
