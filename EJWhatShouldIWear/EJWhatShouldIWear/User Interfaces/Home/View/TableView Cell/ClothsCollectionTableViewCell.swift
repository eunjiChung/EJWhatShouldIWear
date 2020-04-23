//
//  ClothsCollectionTableViewCell.swift
//  EJWhatShouldIWear
//
//  Created by eunji on 25/09/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class ClothsCollectionTableViewCell: UITableViewCell {
    
    static let identifier = "ClothsCollectionTableViewCell"
    // MARK: - Properties
    var clothesList = [String]()
    var model: [EJThreedaysForecastModel]? {
        didSet {
            clothList()
        }
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Initialize
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UINib(nibName: ClothCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ClothCollectionViewCell.identifier)
    }
    
    // MARK: - Public Method
    public func clothList() {
        if let fcst = model?.first, let fcst3hour = fcst.fcst3hour, let timeRelease = fcst.timeRelease {
            let weather = EJWeatherManager.shared.generateNewWeatherConditionKR(fcst3hour, timeRelease)
            self.clothesList = EJClothManager.shared.getClothList(weather.minTemp, weather.maxTemp)
        }
    }
}

extension ClothsCollectionTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return clothesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ClothCollectionViewCell.identifier, for: indexPath) as! ClothCollectionViewCell
        
        let index = indexPath.item
        cell.setCloth(clothesList[index])
        
        return cell
    }
}

extension ClothsCollectionTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = 0.0
        
        if EJ_SCREEN_HEIGHT == EJ_SCREEN_7_PLUS {
            height = EJSizeHeight(160.0)
        } else if EJ_SCREEN_HEIGHT == EJ_SCREEN_7 {
            height = EJSizeHeight(180.0)
        } else {
            height = EJSizeHeight(130.0)
        }
        return CGSize(width: EJSize((EJ_SCREEN_WIDTH_375-32)/4), height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top:  EJSizeHeight(10.0), left: EJSize(5.0), bottom: EJSizeHeight(10.0), right: 0.0)
    }
}
