//
//  ClothsCollectionTableViewCell.swift
//  EJWhatShouldIWear
//
//  Created by eunji on 25/09/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class ClothsCollectionTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    static let identifier = "ClothsCollectionTableViewCell"
    // 날씨 모델 가져오기
    var ThreeDaysWeatherModel: SKThreeThreedays?
    var clothesList = [String]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UINib(nibName: ClothCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ClothCollectionViewCell.identifier)
    }
    
    // MARK: - Public Method
    public func clothList(by model: SKThreeThreedays) {
        if let weather = model.weather {
            if let fcst = weather.forecast3days?.first, let fcst3hour = fcst.fcst3hour, let timeRelease = fcst.timeRelease {
                
                let weather = WeatherManager.generateWeatherConditionKR(fcst3hour, timeRelease)
                self.clothesList = WeatherManager.getClothList(weather.minTemp, weather.maxTemp)
            }
        }
    }
    
    
    // MARK: - CollectionView DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return clothesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ClothCollectionViewCell.identifier, for: indexPath) as! ClothCollectionViewCell
        
        let index = indexPath.item
        cell.setCloth(clothesList[index])
        
        return cell
    }

    // MARK: - UICollectionView Delegate FlowLayout
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
