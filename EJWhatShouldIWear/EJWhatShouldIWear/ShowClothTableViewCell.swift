//
//  ShowClothTableViewCell.swift
//  EJWhatShouldIWear
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 16/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class ShowClothTableViewCell: UITableViewCell {
    
    static let identifier = "ShowClothTableViewCell"
    
    // MARK: - IBOutlet
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var firstClothImageView: UIImageView!
    @IBOutlet weak var secondClothImageview: UIImageView!
    @IBOutlet weak var thirdClothImageView: UIImageView!
    @IBOutlet weak var suggestLabel: UILabel!
    @IBOutlet weak var firstClothLabel: UILabel!
    @IBOutlet weak var secondClothLabel: UILabel!
    @IBOutlet weak var thirdClothLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    
    // MARK: - Constraints
    @IBOutlet weak var alcHeightOfContainerView: NSLayoutConstraint!
    @IBOutlet weak var alcLeadingOfStackView: NSLayoutConstraint!
    @IBOutlet weak var alcTrailingOfStackView: NSLayoutConstraint!
    @IBOutlet weak var alcBottomOfStackView: NSLayoutConstraint!
    @IBOutlet weak var alcHeightOfHangerImage: NSLayoutConstraint!
    @IBOutlet weak var alcTopOfFirstClothImageView: NSLayoutConstraint!
    @IBOutlet weak var alcLeadingOfFirstImageview: NSLayoutConstraint!
    @IBOutlet weak var alcLeadingOfSecondImageView: NSLayoutConstraint!
    @IBOutlet weak var alcLeadingOfThirdImageView: NSLayoutConstraint!
    @IBOutlet weak var alcTrailingOfThirdImageView: NSLayoutConstraint!
    @IBOutlet weak var alcTopOfFirstLabel: NSLayoutConstraint!
    @IBOutlet weak var alcBottomOfFirstLabel: NSLayoutConstraint!
    @IBOutlet weak var alcLeadingOfClothView: NSLayoutConstraint!
    @IBOutlet weak var alcTopOfClothView: NSLayoutConstraint!
    @IBOutlet weak var alcBottomOfClothView: NSLayoutConstraint!
    @IBOutlet weak var alcTrailingOfClothView: NSLayoutConstraint!
    
    var firstImageCenterY: CGFloat = 0.0
    var secondImageCenterY: CGFloat = 0.0
    var thirdImageCenterY: CGFloat = 0.0
    
    // MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        addShadow()
        setLayoutConstraints()
        
        firstImageCenterY = firstClothImageView.center.y - 7
        secondImageCenterY = secondClothImageview.center.y - 8
        thirdImageCenterY = thirdClothImageView.center.y - 10
    }

    
    // MARK: - Public Method
    public func setCurrentLocality(by location:String) {
        locationLabel.text = location
    }
    
    public func generateMain(by model: EJFiveDaysWeatherModel) {
        guard let city = model.city, let timezone = city.timezone else { return }
        guard let list = model.list else { return }
        
        // 1. 원하는 날짜 받아오기≈
        let date = Date()
        let today = date.todayDate()
        
        // 2. 날짜에 해당하는 날씨 가져오기
        let todayWeatherList = list.filter {
            if let date = $0.dtTxt { return today == date.onlyDate() }
            return false
        }
        
        let weather = WeatherManager.generateWeatherCondition(by: todayWeatherList)
        
        currentTempLabel.text = "\(weather.mainTemp)"
        unitLabel.text = LocalizedString(with: "temp")
        suggestLabel.text = weather.weatherDescription
        print("Description: \(weather.weatherDescription)")
        
        firstClothImageView.image = UIImage(named: weather.criticCloth)
        firstClothLabel.text = LocalizedString(with: weather.criticCloth)
        secondClothImageview.image = UIImage(named: weather.maxCloth)
        secondClothLabel.text = LocalizedString(with: weather.maxCloth)
        thirdClothImageView.image = UIImage(named: weather.minCloth)
        thirdClothLabel.text = LocalizedString(with: weather.minCloth)
        
        addAnimation()
    }
    
    
    // MARK: - Private Shadow
    private func addAnimation() {
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [.curveEaseInOut, .repeat, .autoreverse], animations: {
            self.firstClothImageView.center.y = self.firstImageCenterY + 14
            self.secondClothImageview.center.y = self.secondImageCenterY + 16
            self.thirdClothImageView.center.y = self.thirdImageCenterY + 20
        }, completion: nil)
    }
    
    // MARK: Layout
    private func addShadow() {
        //        self.backgroundColor = .clear
        self.layer.shadowOpacity = 0.1 // 투명 효과
        self.layer.shadowColor = UIColor.gray.cgColor // 그림자 색깔
        self.layer.shadowRadius = 10 // 블러효과
        self.layer.masksToBounds = false
        self.layer.shadowOffset = .zero // 뷰로부터 얼마나 멀어질건지
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath // 그림자의 모양 (뷰에 맞추는 정도)
    }
    
    private func setLayoutConstraints() {
        alcHeightOfContainerView.constant = EJSizeHeight(256.0)
        alcLeadingOfStackView.constant = EJSize(64.0)
        alcTrailingOfStackView.constant = EJSize(64.0)
        alcBottomOfStackView.constant = EJSizeHeight(56.0)
        alcHeightOfHangerImage.constant = EJSizeHeight(146.0)
        alcTopOfFirstClothImageView.constant = EJSizeHeight(15.0)
        alcLeadingOfFirstImageview.constant = EJSize(29.0)
        alcLeadingOfSecondImageView.constant = EJSize(20.0)
        alcLeadingOfThirdImageView.constant = EJSize(20.0)
        alcTrailingOfThirdImageView.constant = EJSize(29.0)
//        alcTopOfFirstLabel.constant = EJSizeHeight(12.0)
        alcBottomOfFirstLabel.constant = EJSizeHeight(15.0)
        alcLeadingOfClothView.constant = EJSize(20.0)
        alcTopOfClothView.constant = EJSizeHeight(62.0)
        alcBottomOfClothView.constant = EJSizeHeight(34.0)
        alcTrailingOfClothView.constant = EJSize(20.0)
    }
    
}
