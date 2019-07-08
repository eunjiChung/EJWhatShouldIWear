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
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UINib(nibName: "WeekelyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: WeekelyCollectionViewCell.identifier)
    }

    
    func setWeekelyTimeTable(by info: [EJFiveDaysList]) {
        weatherInfo = info
        collectionView.reloadData()
    }
    
    // MARK: - UICollectionView DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeekelyCollectionViewCell.identifier, for:indexPath) as! WeekelyCollectionViewCell
        
        let item = indexPath.item
        
        if let info = weatherInfo {
            cell.setWeekelyInfo(by: info, to: item)
        }
        
        
        return cell
    }
    
    // MARK: - UICollectionView Delegate FlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: EJSize(65.0), height: EJSize(97.0))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: EJSize(0.0), left: EJSize(22.0), bottom: EJSize(0.0), right: EJSize(0.0))
    }
    
}
