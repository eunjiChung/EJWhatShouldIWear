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
    var clothesArray = [String]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UINib(nibName: ClothCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ClothCollectionViewCell.identifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ClothCollectionViewCell.identifier, for: indexPath) as! ClothCollectionViewCell
        
        
        
        return cell
    }

    // MARK: - UICollectionView Delegate FlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (EJ_SCREEN_WIDTH_375-32)/4, height: EJSizeHeight(150.0))
    }
    
}
