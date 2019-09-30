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
        UIView.transition(with: self,
                          duration: 0.5,
                          options: [],
                          animations: { self.image = image },
                          completion: nil)
    }
}
