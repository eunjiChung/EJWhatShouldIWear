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

extension Int {
    var level: EJWeatherLevel {
        switch self {
        case TempRange.temp_28:         return ._28
        case TempRange.temp_23_27:      return ._23_27
        case TempRange.temp_20_22:      return ._20_22
        case TempRange.temp_17_19:      return ._17_19
        case TempRange.temp_12_16:      return ._12_16
        case TempRange.temp_9_11:       return ._9_11
        case TempRange.temp_5_8:        return ._5_8
        case TempRange.temp_4:          return ._4
        default:                        return ._12_16
        }
    }
}

extension Array {
    /// Picks `n` random elements (partial Fisher-Yates shuffle approach)
    subscript (randomPick n: Int) -> [Element] {
        var copy = self
        for i in stride(from: count - 1, to: count - n - 1, by: -1) {
            copy.swapAt(i, Int(arc4random_uniform(UInt32(i + 1))))
        }
        return Array(copy.suffix(n))
    }
}
