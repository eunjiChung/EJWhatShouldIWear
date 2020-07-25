//
//  EJSplashViewController.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/07/25.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

final class EJSplashViewController: EJBaseViewController {
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    lazy var viewModel: EJSplashViewModel = {
        return EJSplashViewModel()
    }()
    
    // MARK: View Controller Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        KMUserDefaultsManager.shared.defaultSetting()
        initView()
        initViewModel()
        initNotification()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    private func initView() {
        // 최초에 지역 선택
        if !myUserDefaults.bool(forKey: UserDefaultKey.isExistingUser) {
            guard let introVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EJIntroViewController") as? EJIntroViewController else { return }
            introVC.modalPresentationStyle = .fullScreen
            present(introVC, animated: false) { }
        }
        
        var timer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(UIMenuController.update), userInfo: nil, repeats: true)
    }

    func update() {
        var count = 10
        if(count > 0) {
            count -= 1
        }
    }
    
    private func initViewModel() {
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
        guard let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EJNewHomeViewController") as? EJNewHomeViewController, let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        appDelegate.window?.rootViewController = self
    }
    
    
}
