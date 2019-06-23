//
//  TimeWeahtherTableViewCell.swift
//  EJWhatShouldIWear
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 16/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class TimeWeahtherTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    static let identifier = "TimeWeahtherTableViewCell"
    var weatherInfo: [EJFiveDaysList]?
    var timeRelease: String?
    var timeArray: [String]?
    var tempArray: [String]?
    
    @IBOutlet weak var collectionView: UICollectionView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.dataSource = self as UICollectionViewDataSource
        collectionView.delegate = self as UICollectionViewDelegate
        
        collectionView.register(UINib.init(nibName: "TimeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: TimeCollectionViewCell.identifier)
    }
    
    // MARK : - Setting WeatherInfo Method
    func setTimelyTable(by info: [EJFiveDaysList]) {
        weatherInfo = info
        collectionView.reloadData()
    }
    
    
    // MARK : - CollectionView Data Source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimeCollectionViewCell.identifier, for: indexPath) as! TimeCollectionViewCell
        
        let item = indexPath.item
        
        if let info = weatherInfo {
            let indexWeatherInfo = info[item]
            cell.setHourlyWeather(by: indexWeatherInfo)
        }
        
        return cell
    }
    
    // MARK : - CollectionView FlowLayout Delegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: EJSize(100.0), height: EJSize(160.0))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: EJSize(5.0), left: EJSize(5.0), bottom: EJSize(5.0), right: EJSize(5.0))
    }
    
}
