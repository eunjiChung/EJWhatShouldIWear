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
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }
    
    private func initView() {
        alcTopOfStackView.constant = EJSizeHeight(414.0)
        
        startLoading()
        selectInitialLocalization()
        
        EJAppStoreReviewManager.requestReviewIfAppropriate()     // 3회 방문시 스토어 리뷰 요청
    }
    
    // MARK: - Extra Functions
    private func dismissSplash() {
        requestAppVersionInfo()

        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.8) {
                guard let indicator = self.loadingIndicator else { return }
                self.view.alpha = 0.0
                indicator.alpha = 0.0

                guard let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EJNewHomeViewController") as? EJNewHomeViewController, let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
                appDelegate.window?.rootViewController = homeVC
            }
        }
    }
    
    private func startLoading() {
        loadingIndicator.startAnimating()
    }
    
    private func selectInitialLocalization() {
        guard !myUserDefaults.bool(forKey: UserDefaultKey.isExistingUser) else {
            dismissSplash()
            return
        }

        guard let introVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EJIntroViewController") as? EJIntroViewController else { return }
        introVC.modalPresentationStyle = .fullScreen
        introVC.didSelectCountryClosure = { [weak self] in
            guard let self = self else { return }
            self.dismissSplash()
        }

        DispatchQueue.main.async {
            self.present(introVC, animated: true, completion: nil)
        }
    }
}
