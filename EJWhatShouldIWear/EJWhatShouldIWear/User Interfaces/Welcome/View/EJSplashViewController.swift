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
            let transition: CATransition = CATransition()
            transition.duration = 2.5
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType.fade
            transition.subtype = CATransitionSubtype.fromBottom
            self.view.window?.layer.add(transition, forKey: "kCATransition")
            self.dismiss(animated: false) {
                guard let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EJHomeViewController") as? EJHomeViewController, let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
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

extension CATransition {
    func fadeTransition() -> CATransition {
        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromRight

        return transition
    }
}
