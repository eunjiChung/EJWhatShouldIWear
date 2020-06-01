//
//  WeekWeatherTableViewCell.swift
//  EJWhatShouldIWear
//
//  Created by CHUNGEUNJI on 08/07/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class WeekWeatherTableViewCell: UITableViewCell {
    
    static let identifier = "WeekWeatherTableViewCell"
    
    // MARK: - Properties
    var weatherInfo: [EJFiveDaysList]?
    var krTempList: EJSixdaysTemperatureModel?
    var krSkyList: EJSixdaysSkyModel?
    
    var models: [EJKisangWeekelyItemModel]? {
        didSet {
            setKoreaWeekelyTimeTable()
        }
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var alcTopOfTitleLabel: NSLayoutConstraint!
    @IBOutlet weak var alcLeadingOfTitleLabel: NSLayoutConstraint!
    @IBOutlet weak var alcBottomOfCollectionView: NSLayoutConstraint!
    @IBOutlet weak var alcTopOfCollectionView: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        alcTopOfTitleLabel.constant = EJSizeHeight(38.0)
        alcLeadingOfTitleLabel.constant = EJSize(20.0)
        alcBottomOfCollectionView.constant = EJSizeHeight(30.0)
        alcTopOfCollectionView.constant = EJSizeHeight(16.0)
        
        titleLabel.text = "main_weekely".localized

        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UINib(nibName: "WeekelyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: WeekelyCollectionViewCell.identifier)
        collectionView.register(UINib(nibName: "KRWeekelyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: KRWeekelyCollectionViewCell.identifier)
    }

    func setKoreaWeekelyTimeTable() {
        collectionView.reloadData()
    }
    
    func setWeekelyTimeTable(by info: [EJFiveDaysList]) {
        weatherInfo = info
        collectionView.reloadData()
    }
}

extension WeekWeatherTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let model = models?.first { return model.dictionaryRepresentation().count }
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let model = models?.first {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KRWeekelyCollectionViewCell.identifier, for: indexPath) as! KRWeekelyCollectionViewCell
            let dict = model.dictionaryRepresentation()
            cell.weekelyModel = dict[indexPath.item]
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeekelyCollectionViewCell.identifier, for:indexPath) as! WeekelyCollectionViewCell
        
        let item = indexPath.item
        if let info = weatherInfo {
            cell.setWeekelyInfo(by: info, to: item)
        }
        
        return cell
    }
}

// MARK: - UICollectionView Delegate FlowLayout
extension WeekWeatherTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width:CGFloat = EJSize(100.0)
        var height: CGFloat = EJSizeHeight(80.0)
        
        if EJLocationManager.shared.isKorea() {
            width = EJSize(100.0)
            
            if EJ_SCREEN_HEIGHT == EJ_SCREEN_7_PLUS {
                height = EJSizeHeight(230.0)
            } else if EJ_SCREEN_HEIGHT == EJ_SCREEN_7 {
                height = EJSizeHeight(240.0)
            } else {
                height = EJSizeHeight(212.0)
            }
        }
        
        return CGSize.init(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: EJSizeHeight(0.0), left: EJSize(22.0), bottom: EJSizeHeight(0.0), right: EJSize(22.0))
    }
    
}
