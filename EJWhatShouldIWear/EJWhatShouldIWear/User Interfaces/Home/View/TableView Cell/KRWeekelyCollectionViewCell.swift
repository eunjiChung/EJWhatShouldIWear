//
//  KRWeekelyCollectionViewCell.swift
//  EJWhatShouldIWear
//
//  Created by CHUNGEUNJI on 29/09/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

final class KRWeekelyCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "KRWeekelyCollectionViewCell"

    // MARK: - Properties
    var item: Int = 0    
    var baseTime: String?
    var weekelyModel: EJWeekelyCellModel? {
        didSet {
            setDate()
            setTemperature()
            setDress()
        }
    }
    
    // MARK: - IBOutlet
    @IBOutlet weak var backView: BackView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var clothImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: - Layout Constraints
    @IBOutlet weak var alcTopOfDateLabel: NSLayoutConstraint!
    @IBOutlet weak var alcTopOfTempLabel: NSLayoutConstraint!
    @IBOutlet weak var alcTopOfmintempLabel: NSLayoutConstraint!
    @IBOutlet weak var alcBottomOfDescriptionLabel: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        alcTopOfDateLabel.constant = EJSizeHeight(11.0)
        alcTopOfTempLabel.constant = EJSizeHeight(10.0)
        alcTopOfmintempLabel.constant = EJSizeHeight(5.0)
        alcBottomOfDescriptionLabel.constant = EJSizeHeight(10.0)
    }
    
    // MARK: - Kisang
    private func setDate() {
        guard let time = baseTime else { return }
        let component = Calendar(identifier: .gregorian).dateComponents([.weekday], from: time.extractWeekDate())
        // TODO: - 3일 후 날씨부터 나온다...내일 날씨부터 알려줄 수 있도록 한다
        let day = (component.weekday! + item + 2) % 7
        dateLabel.text = EJDateManager.weekDay[day].localized
    }
    
    private func setTemperature() {
        guard let weekModel = weekelyModel else { return }
        maxTempLabel.text = "\(weekModel.maxTemp)도"
        minTempLabel.text = "\(weekModel.minTemp)도"
    }
    
    private func setDress() {
        guard let weekModel = weekelyModel else { return }
        let dressString = EJClothManager.shared.setOuterCloth(by: weekModel.minTemp)
        clothImageView.image = UIImage(named: dressString)
        descriptionLabel.text = ""
    }
    
    // MARK: - Private Method    
    private func generateValidCondition(_ pm: String, _ am: String, _ temp: Int) {
        let codeNumber = am.components(separatedBy: ["S", "K", "Y", "_", "W"]).joined()
        let amCode = Int(codeNumber)!
        let code = EJWeatherManager.shared.compareKRWeatherCode(pm, amCode)
        let condition = EJWeatherManager.shared.generateKRWeatherCondition(of: code)
        var clothName = ""
        
        if condition != .clear && condition != .cloud {
            clothName = EJClothManager.shared.setClothByCondition(condition)
        } else {
            clothName = EJClothManager.shared.setOuterCloth(by: temp)
        }
        
        clothImageView.image = UIImage(named: clothName)
    }
}
