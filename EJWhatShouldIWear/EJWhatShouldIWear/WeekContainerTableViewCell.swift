//
//  WeekContainerTableViewCell.swift
//  EJWhatShouldIWear
//
//  Created by CHUNGEUNJI on 07/07/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class WeekContainerTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    // MARK: - Instances
    static let identifier = "WeekContainerTableViewCell"
    var weatherInfo: [EJFiveDaysList]?
    var timeRelease: String?
    var timeArray: [String]?
    var tempArray: [String]?
    
    // MARK: - IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.dataSource = self as UICollectionViewDataSource
        collectionView.delegate = self as UICollectionViewDelegate
        
        collectionView.register(UINib.init(nibName: "WeekelyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: WeekelyCollectionViewCell.identifier)
    }
    
    // MARK: - CollectionView DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeekelyCollectionViewCell.identifier, for: indexPath) as! WeekelyCollectionViewCell
        
        let item = indexPath.item
        
        if let info = weatherInfo {
            cell.setWeekelyInfo(by: info, to: item)
        }
        
        return cell
    }
    
    
    // MARK: - CollectionView FlowLayout Delegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: EJSize(65.0), height: EJSize(97.0))
    }
    
    // 22pt...
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: EJSize(0.0), left: EJSize(22.0), bottom: EJSize(0.0), right: EJSize(0.0))
    }
    
}
