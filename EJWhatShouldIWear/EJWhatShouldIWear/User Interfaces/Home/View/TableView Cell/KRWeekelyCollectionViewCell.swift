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
    let today = Date()
    let dateFormatter = DateFormatter()
    let calendar = Calendar(identifier: .gregorian)
    
    var weekDay = ["sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday"]
    
    var item: Int = 0
    var sixdaysSkyModel: EJSixdaysSkyModel?
    var sixdaysTemperatureModel: EJSixdaysTemperatureModel? {
        didSet {
            setKoreaWeekelyInfo(item)
        }
    }
    
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
        // Initialization code
        dateFormatter.dateFormat = "YYYY-MM-dd 12:00:00"
        
        alcTopOfDateLabel.constant = EJSizeHeight(11.0)
        alcTopOfTempLabel.constant = EJSizeHeight(10.0)
        alcTopOfmintempLabel.constant = EJSizeHeight(5.0)
        alcBottomOfDescriptionLabel.constant = EJSizeHeight(10.0)
    }
    
    // MARK: - Kisang
    private func setDate() {
        guard let time = baseTime else { return }
        let component = calendar.dateComponents([.weekday], from: time.extractWeekDate())
        let day = (component.weekday! + item) % 7
        dateLabel.text = weekDay[day].localized
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
    func setKoreaWeekelyInfo(_ index: Int) {
        guard let skyModel = sixdaysSkyModel, let tempModel = sixdaysTemperatureModel else { return }
        let skyList = skyModel.dictionaryRepresentation()
        let tempList = tempModel.dictionaryRepresentation()

        let minTemp = tempList["tmin\(index+2)day"]!
        let maxTemp = tempList["tmax\(index+2)day"]!
        let pmCondition = skyList["pmCode\(index+2)day"]!
        let amCondition = skyList["amCode\(index+2)day"]!
        let condition = skyList["pmName\(index+2)day"]!

        dateLabel.text = "\(getKRWeekday(of: index))"
        maxTempLabel.text = maxTemp + "도"
        minTempLabel.text = minTemp + "도"
        generateValidCondition(pmCondition, amCondition, Int(minTemp)!)
        descriptionLabel.text = condition
    }
    
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
    
    private func getKRWeekday(of index: Int) -> String {
        let component = calendar.dateComponents([.weekday], from: today)
        let day = (component.weekday! + index + 1) % 7
        return weekDay[day].localized
    }

}
