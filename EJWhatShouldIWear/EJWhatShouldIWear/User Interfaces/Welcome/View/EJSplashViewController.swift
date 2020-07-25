//
//  EJSplashViewController.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/07/25.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

final class EJSplashViewController: EJBaseViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var alcTopOfStackView: NSLayoutConstraint!
    
    // MARK: - ViewModel
    lazy var viewModel: EJSplashViewModel = {
        return EJSplashViewModel()
    }()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        initViewModel()
        initNotification()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    private func initView() {
        alcTopOfStackView.constant = EJSizeHeight(414.0)
        
        startLoading()
        selectInitialLocalization()
        EJAppStoreReviewManager.requestReviewIfAppropriate()     // 3회 방문시 스토어 리뷰 요청
    }
    
    private func initViewModel() {
        dismissSplash()
//        viewModel.didUpdateSplashStatus = { [weak self] status in
//            guard let self = self else { return }
//
//            DispatchQueue.main.async {
//                switch status {
//                case .none:
//                    self.loadingIndicator.isHidden = true
//                    self.loadingIndicator.stopAnimating()
//
//                case let .requesting(message):
//                    self.loadingIndicator.isHidden = false
//                    self.loadingIndicator.startAnimating()
//
//                case let .downloading(message, progress):
//                    self.loadingIndicator.isHidden = true
//                    self.loadingIndicator.stopAnimating()
//
//                case let .needUpdate(message):
//                    self.loadingIndicator.isHidden = true
//                    self.loadingIndicator.stopAnimating()
//
//                case let .errorOccured(message):
//                    self.loadingIndicator.isHidden = true
//                    self.loadingIndicator.stopAnimating()
//
//                case .finished:
//                    self.loadingIndicator.isHidden = true
//                    self.loadingIndicator.stopAnimating()
//                    self.dismissSplash()
//                }
//            }
//        }
    }
    
    private func initNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    // MARK: - Notification
    @objc func willEnterForeground() {
//        if case .errorOccured = viewModel.status {
//            viewModel.requestCheckVersion()
//        }
    }
    
    // MARK: - Extra Functions
    private func dismissSplash() {
        requestAppVersionInfo()
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.8) {
                if let indicator = self.loadingIndicator {
                    self.view.alpha = 0.0
                    indicator.alpha = 0.0
                    
                    guard let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EJNewHomeViewController") as? EJNewHomeViewController, let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
                    appDelegate.window?.rootViewController = homeVC
                }
            }
        }
    }
    
}

// MARK: - Private Methods
extension EJSplashViewController {
    
    private func startLoading() {
        loadingIndicator.startAnimating()
    }
    
    private func selectInitialLocalization() {
        if !myUserDefaults.bool(forKey: UserDefaultKey.isExistingUser) {
            guard let introVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EJIntroViewController") as? EJIntroViewController else { return }
            introVC.modalPresentationStyle = .fullScreen
            present(introVC, animated: false) { }
        }
    }
}
