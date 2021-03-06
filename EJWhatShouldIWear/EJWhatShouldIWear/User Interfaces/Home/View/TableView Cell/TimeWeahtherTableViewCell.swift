//
//  TimeWeahtherTableViewCell.swift
//  EJWhatShouldIWear
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 16/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit
import SkeletonView

class TimeWeahtherTableViewCell: UITableViewCell {
    
    static let identifier = "TimeWeahtherTableViewCell"
    
    // MARK: - Properties
    var weatherModel: EJFiveDaysWeatherModel?    // Other Country Weather Model
    var timeRelease: String?
    var timeArray: [String]?
    var tempArray: [String]?
    
    var models: [EJKisangTimeModel]? {
        didSet {
            titleLabel.textColor = titleColor.withAlphaComponent(0.8)
            setKisangTimely()
        }
    }
    var tempModels: [EJKisangTimelyModel] = []
    var skyModels: [EJKisangTimelyModel] = []
    var rainyModels: [EJKisangTimelyModel] = []
    
    // MARK: - IBOutlets
    @IBOutlet weak var alcTopConstraintOfTextLabel: NSLayoutConstraint!
    @IBOutlet weak var alcLeadingConstraintOfTextLabel: NSLayoutConstraint!
    @IBOutlet weak var alcTopConstraintOfCollectionView: NSLayoutConstraint!
    @IBOutlet weak var alcBottomConstraintOfCollectionView: NSLayoutConstraint!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Initialize
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.text = "main_timely".localized
        
        alcTopConstraintOfTextLabel.constant = EJSizeHeight(38.0)
        alcLeadingConstraintOfTextLabel.constant = EJSize(20.0)
        alcTopConstraintOfCollectionView.constant = EJSizeHeight(18.0)
        alcBottomConstraintOfCollectionView.constant = EJSizeHeight(30.0)
        
        collectionView.dataSource = self as UICollectionViewDataSource
        collectionView.delegate = self as UICollectionViewDelegate
        
        collectionView.register(UINib.init(nibName: "TimeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: TimeCollectionViewCell.identifier)
        collectionView.isSkeletonable = true
        collectionView.showSkeleton()
    }
    
    // MARK: - Kisang Methods
    func setKisangTimely() {
        collectionView.reloadData()
    }
    
    // MARK: - Setting WeatherInfo Method
    func setTimelyTable(of model: EJFiveDaysWeatherModel) {
        weatherModel = model
        collectionView.reloadData()
    }
    
    func setKRTimelyTable() {
        collectionView.reloadData()
    }
}


// MARK: - CollectionView Data Source
extension TimeWeahtherTableViewCell: SkeletonCollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let models = models { return models.count }
        return 6
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimeCollectionViewCell.identifier, for: indexPath) as! TimeCollectionViewCell
        let index = indexPath.item

        if let model = weatherModel {
            cell.setHourlyWeather(of: model, at: index)
        }

        if let models = models {
            cell.model = models[indexPath.item]
        }

        return cell
    }

    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 14
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return TimeCollectionViewCell.identifier
    }
}

// MARK: - CollectionView FlowLayout Delegate
extension TimeWeahtherTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: EJSize(80.0), height: EJSizeHeight(160.0))
    }
}
