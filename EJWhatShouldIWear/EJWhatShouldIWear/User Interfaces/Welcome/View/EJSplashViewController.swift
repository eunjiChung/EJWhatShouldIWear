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
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        startLoading()
        initLocation()
        EJAppStoreReviewManager.requestReviewIfAppropriate()     // 3회 방문시 스토어 리뷰 요청
    }
    
    // MARK: - Extra Functions
    private func startLoading() {
        loadingIndicator.startAnimating()
    }

    /// 첫 설치 시,
    /// 1. 위치 설정 허용 요청
    /// 2-1. 허용일 경우
    ///     3. location update
    ///             3-1. 외국인지 한국인지 구분 후 저장
    /// 2-2. 비허용일 경우
    ///     3. 선택화면 노출
    ///             3-1. 지역선택 창 노출
    /// 기존 진입 시,
    /// 1. UserDefaults가 있는지 확인
    private func initLocation() {
        EJLocationManager.shared.didSuccessUpdateLocationsClosure = { [weak self] in
            guard let self = self else { return }
            self.dismissSplash()
        }

        EJLocationManager.shared.didFailUpdateLocationClosure = { error in
            // TODO: - 토스트 메시지 띄우기
        }

        EJLocationManager.shared.didRestrictLocationAuthorizationClosure = { [weak self] in
            guard let self = self else { return }
            self.selectCountry()
        }
    }

    private func selectCountry() {
        guard let introVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EJIntroViewController") as? EJIntroViewController else { return }
        introVC.modalPresentationStyle = .fullScreen
        introVC.didSelectCountryClosure = { [weak self] in
            guard let self = self else { return }
            self.showKoreaLocationSelectionViewController {
                self.dismissSplash()
            }
        }
        present(introVC, animated: true, completion: nil)
    }

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
