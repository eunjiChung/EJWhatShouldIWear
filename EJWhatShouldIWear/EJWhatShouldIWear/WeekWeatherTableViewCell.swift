//
//  WeekWeatherTableViewCell.swift
//  EJWhatShouldIWear
//
//  Created by CHUNGEUNJI on 08/07/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class WeekWeatherTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    static let identifier = "WeekWeatherTableViewCell"
    var weatherInfo: [EJFiveDaysList]?
    var krTempList: SKSixTemperature?
    var krSkyList: SKSixSky?
    
    // MARK: - Layout Constraints
    @IBOutlet weak var alcTopOfTitleLabel: NSLayoutConstraint!
    @IBOutlet weak var alcLeadingOfTitleLabel: NSLayoutConstraint!
    @IBOutlet weak var alcBottomOfCollectionView: NSLayoutConstraint!
    @IBOutlet weak var alcTopOfCollectionView: NSLayoutConstraint!
    
    
    // MARK: - IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        alcTopOfTitleLabel.constant = EJSizeHeight(38.0)
        alcLeadingOfTitleLabel.constant = EJSize(20.0)
        alcBottomOfCollectionView.constant = EJSizeHeight(30.0)
        alcTopOfCollectionView.constant = EJSizeHeight(16.0)
        
        titleLabel.text = LocalizedString(with: "main_weekely")

        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UINib(nibName: "WeekelyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: WeekelyCollectionViewCell.identifier)
        collectionView.register(UINib(nibName: "KRWeekelyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: KRWeekelyCollectionViewCell.identifier)
    }

    func setKoreaWeekelyTimeTable(by info: SKSixSixdaysBase) {
        guard let weather = info.weather else { return }
        guard let model = weather.forecast6days, let fcst6days = model.first else { return }
        guard let temp = fcst6days.temperature, let sky = fcst6days.sky else { return }
        krTempList = temp
        krSkyList = sky
        
        collectionView.reloadData()
    }
    
    func setWeekelyTimeTable(by info: [EJFiveDaysList]) {
        weatherInfo = info
        collectionView.reloadData()
    }
    
    // MARK: - UICollectionView DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let temp = krTempList {
            return 7
        }
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let temp = krTempList {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KRWeekelyCollectionViewCell.identifier, for: indexPath) as! KRWeekelyCollectionViewCell
            
            let item = indexPath.item
            if let temp = krTempList, let sky = krSkyList {
                cell.setKoreaWeekelyInfo(sky, temp, to: item)
            }
            
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeekelyCollectionViewCell.identifier, for:indexPath) as! WeekelyCollectionViewCell
        
        let item = indexPath.item
        if let info = weatherInfo {
            cell.setWeekelyInfo(by: info, to: item)
        }
        
        return cell
    }
    
    // MARK: - UICollectionView Delegate FlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width:CGFloat = EJSize(100.0)
        var height: CGFloat = EJSizeHeight(80.0)
        
        if WeatherManager.isLocationKorea() {
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
