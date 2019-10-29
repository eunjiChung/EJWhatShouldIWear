//
//  ImageView.swift
//  EJWhatShouldIWear
//
//  Created by eunji on 25/09/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//
import UIKit

extension UIImageView {
    func changeBackGround(with image: UIImage) {
        // TODO: - 이렇게 메인 스레드에서 실행되지 않은 문제인가?
        DispatchQueue.main.async {
            UIView.transition(with: self,
                              duration: 0.5,
                              options: [],
                              animations: { self.image = image },
                              completion: nil)
        }
    }
}
