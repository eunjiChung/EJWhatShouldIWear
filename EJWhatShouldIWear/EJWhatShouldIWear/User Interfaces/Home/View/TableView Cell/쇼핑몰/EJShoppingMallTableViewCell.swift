//
//  EJShoppingMallTableViewCell.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2021/01/12.
//  Copyright © 2021 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

final class EJShoppingMallTableViewCell: UITableViewCell {

    static let id = "EJShoppingMallTableViewCell"

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(UINib(nibName: EJProductCollectionViewCell.id, bundle: nil), forCellWithReuseIdentifier: EJProductCollectionViewCell.id)

        titleLabel.textColor = titleColor
        subTitleLabel.textColor = titleColor
    }
}

extension EJShoppingMallTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EJProductCollectionViewCell.id, for: indexPath) as? EJProductCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
}

extension EJShoppingMallTableViewCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100.0, height: collectionView.bounds.height)
    }
}
