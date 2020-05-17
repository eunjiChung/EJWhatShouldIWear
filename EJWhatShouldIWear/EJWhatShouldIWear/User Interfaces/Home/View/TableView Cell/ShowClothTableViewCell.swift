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
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var firstClothImageView: UIImageView!
    @IBOutlet weak var secondClothImageview: UIImageView!
    @IBOutlet weak var thirdClothImageView: UIImageView!
    @IBOutlet weak var suggestLabel: UILabel!
    @IBOutlet weak var firstClothLabel: UILabel!
    @IBOutlet weak var secondClothLabel: UILabel!
    @IBOutlet weak var thirdClothLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var averageLabel: UILabel!
    
    // MARK: - Animation Constraints
    var firstImageCenterY: CGFloat = 0.0
    var secondImageCenterY: CGFloat = 0.0
    var thirdImageCenterY: CGFloat = 0.0
    
    // MARK: - Layout Constraints
    @IBOutlet weak var alcTopOfUnitLabel: NSLayoutConstraint!
    @IBOutlet weak var alcTopOfClothImageView: NSLayoutConstraint!
    @IBOutlet weak var alcTopOfClothNameLabel: NSLayoutConstraint!
    @IBOutlet weak var alcBottomOfClothesView: NSLayoutConstraint!
    @IBOutlet weak var alcTopOfClothesView: NSLayoutConstraint!
    
    // MARK: - Properties
    var model: [EJThreedaysForecastModel]? {
        didSet {
            generateKoreaMain()
        }
    }
    
    // MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        firstImageCenterY = firstClothImageView.center.y - 7
        secondImageCenterY = secondClothImageview.center.y - 8
        thirdImageCenterY = thirdClothImageView.center.y - 10
        
        titleLabel.text = "show_cloth_title".localized
        averageLabel.text = "average_label".localized
        
        setlayoutConstraints()
    }

    // MARK: - Public Method
    public func generateKoreaMain() {
        guard let model = model, let forecast = model.first else {
            return
        }
        let fcst3hour = forecast.fcst3hour
        let timeRelease = forecast.timeRelease
        
        // 1. 원하는 날짜 받아오기
        let date = Date()
        // TODO: 한국 타임존...
        let today = date.todayDateKRString()
        dateLabel.text = today
       
        let weather = EJWeatherManager.shared.generateNewWeatherConditionKR(fcst3hour, timeRelease)
        currentTempLabel.text = "\(weather.mainTemp)"
        unitLabel.text = EJWeatherManager.shared.getValidUnit()
        generateClothRecommendation(weather)
    }
    
    public func generateMain(by model: EJFiveDaysWeatherModel) {
        guard let city = model.city, let timezone = city.timezone else { return }
        guard let list = model.list else { return }
        
        // 1. 원하는 날짜 받아오기
        let date = Date()
        let today = date.todayDate()
        dateLabel.text = date.todayDateString()
        
        // 2. 날짜에 해당하는 날씨 가져오기
        let todayWeatherList = list.filter {
            if let date = $0.dtTxt { return today == date.onlyDate() }
            return false
        }
        
        let weather = EJWeatherManager.shared.generateWeatherCondition(by: todayWeatherList)
        
        currentTempLabel.text = "\(weather.mainTemp)"
        unitLabel.text = EJWeatherManager.shared.getValidUnit()
        generateClothRecommendation(weather)
    }
    
}

private extension ShowClothTableViewCell {
    func addAnimation() {
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [.curveEaseInOut, .repeat, .autoreverse], animations: {
            self.firstClothImageView.center.y = self.firstImageCenterY + 14
            self.secondClothImageview.center.y = self.secondImageCenterY + 16
            self.thirdClothImageView.center.y = self.thirdImageCenterY + 20
        }, completion: nil)
    }
    
    func generateClothRecommendation(_ weather: EJWeatherMainModel) {
        suggestLabel.text = weather.weatherDescription
        
        firstClothImageView.image = UIImage(named: weather.criticCloth)
        firstClothLabel.text = weather.criticCloth.localized
        secondClothImageview.image = UIImage(named: weather.maxCloth)
        secondClothLabel.text = weather.maxCloth.localized
        thirdClothImageView.image = UIImage(named: weather.minCloth)
        thirdClothLabel.text = weather.minCloth.localized
        
        addAnimation()
    }
    
    func addShadow() {
        self.layer.shadowOpacity = 0.1 // 투명 효과
        self.layer.shadowColor = UIColor.gray.cgColor // 그림자 색깔
        self.layer.shadowRadius = 10 // 블러효과
        self.layer.masksToBounds = false
        self.layer.shadowOffset = .zero // 뷰로부터 얼마나 멀어질건지
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath // 그림자의 모양 (뷰에 맞추는 정도)
    }
    
    func setlayoutConstraints() {
        alcTopOfUnitLabel.constant = EJSizeHeight(15.0)
        alcTopOfClothImageView.constant = EJSizeHeight(15.0)
        alcTopOfClothNameLabel.constant = EJSizeHeight(10.0)
        alcBottomOfClothesView.constant = EJSizeHeight(10.0)
        alcTopOfClothesView.constant = EJSizeHeight(5.0)
    }
}
