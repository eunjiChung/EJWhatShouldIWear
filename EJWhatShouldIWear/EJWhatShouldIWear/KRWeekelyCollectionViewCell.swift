//
//  KRWeekelyCollectionViewCell.swift
//  EJWhatShouldIWear
//
//  Created by CHUNGEUNJI on 29/09/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class KRWeekelyCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "KRWeekelyCollectionViewCell"

    let today = Date()
    let dateFormatter = DateFormatter()
    let calendar = Calendar(identifier: .gregorian)
    
    var weekDay = ["sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday"]
    
    // MARK: - IBOutlet
    @IBOutlet weak var backView: BackView!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var clothImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        dateFormatter.dateFormat = "YYYY-MM-dd 12:00:00"
    }
    
    public func setKoreaWeekelyInfo(_ sky: SKSixSky, _ temp: SKSixTemperature, to index: Int) {
        let skyList = sky.dictionaryRepresentation()
        let tempList = temp.dictionaryRepresentation()
        
        let minTemp = tempList["tmin\(index+2)day"] as! String
        let maxTemp = tempList["tmax\(index+2)day"] as! String
        let description = skyList["pmName\(index+2)day"] as! String
        
        dateLabel.text = "\(getKRWeekday(of: index))"
        maxTempLabel.text = maxTemp + "도"
        minTempLabel.text = minTemp + "도"
//        clothImageView.image = 
        descriptionLabel.text = description
    }
    
    private func getKRWeekday(of index: Int) -> String {
        let component = calendar.dateComponents([.weekday], from: today)
        let day = (component.weekday! + index + 1) % 7
        return LocalizedString(with: weekDay[day])
    }

}
