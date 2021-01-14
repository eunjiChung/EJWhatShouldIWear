//
//  UIViewController+.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/12/23.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

extension UIViewController {
    func showKoreaLocationSelectionViewController(completion: (() -> Void)? = nil) {
        guard let vc = UIStoryboard(name: "Local", bundle: nil).instantiateViewController(withIdentifier: "EJMyLocalListViewController") as? EJMyLocalListViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        vc.dismissMyLocalListClosure = {
            completion?()
        }
        present(vc, animated: true) {
            vc.performSegue(withIdentifier: "showLocalList", sender: vc)
        }
    }
}
