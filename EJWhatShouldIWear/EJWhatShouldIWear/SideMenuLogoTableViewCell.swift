//
//  SideMenuLogoTableViewCell.swift
//  EJWhatShouldIWear
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 17/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class SideMenuLogoTableViewCell: UITableViewCell {
    
    static let identifier = "SideMenuLogoTableViewCell"
    
    // MARK: - IBOutlets
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var logoStackView: UIStackView!
    
    // MARK: - Contraints
    @IBOutlet weak var alcWidthOfLogoImageView: NSLayoutConstraint!
    @IBOutlet weak var alcTopOfLogoImageview: NSLayoutConstraint!
    @IBOutlet weak var alcTopOfStackView: NSLayoutConstraint!
    @IBOutlet weak var alcBottomOfStackView: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addShadow()
        
        alcTopOfLogoImageview.constant = EJSizeHeight(43.0)
        alcWidthOfLogoImageView.constant = EJSize(111.0)
        alcTopOfStackView.constant = EJSizeHeight(34.0)
        alcBottomOfStackView.constant = EJSizeHeight(46.0)
    }
    
    // MARK: - Private Method
    private func addShadow() {
//        self.backgroundColor = .clear
        self.layer.shadowOpacity = 0.1 // 투명 효과
        self.layer.shadowColor = UIColor.gray.cgColor // 그림자 색깔
        self.layer.shadowRadius = 10 // 블러효과
        self.layer.masksToBounds = false
        self.layer.shadowOffset = .zero // 뷰로부터 얼마나 멀어질건지
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath // 그림자의 모양 (뷰에 맞추는 정도)
    }

}
