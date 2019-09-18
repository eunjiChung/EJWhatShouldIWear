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
    
    var weatherModel: EJFiveDaysWeatherModel?    // Other Country Weather Model
    var ThreeDaysWeatherModel: SKThreeThreedays? // Korea Weather Model
    var timeRelease: String?
    var timeArray: [String]?
    var tempArray: [String]?
    
    
    // MARK: - Constraints
    @IBOutlet weak var alcTopConstraintOfTextLabel: NSLayoutConstraint!
    @IBOutlet weak var alcLeadingConstraintOfTextLabel: NSLayoutConstraint!
    @IBOutlet weak var alcTopConstraintOfCollectionView: NSLayoutConstraint!
    @IBOutlet weak var alcBottomConstraintOfCollectionView: NSLayoutConstraint!
    @IBOutlet weak var alcHeightOfCollectionView: NSLayoutConstraint!
    
    
    
    // MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.text = LocalizedString(with: "main_timely")
        
        alcTopConstraintOfTextLabel.constant = EJSizeHeight(20.0)
        alcLeadingConstraintOfTextLabel.constant = EJSize(20.0)
        alcTopConstraintOfCollectionView.constant = EJSizeHeight(18.0)
        alcBottomConstraintOfCollectionView.constant = EJSizeHeight(50.0)
        alcHeightOfCollectionView.constant = EJSizeHeight(131.0)
        
        
        collectionView.dataSource = self as UICollectionViewDataSource
        collectionView.delegate = self as UICollectionViewDelegate
        
        collectionView.register(UINib.init(nibName: "TimeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: TimeCollectionViewCell.identifier)
    }
    
    // MARK: - Setting WeatherInfo Method
    func setTimelyTable(of model: EJFiveDaysWeatherModel) {
        weatherModel = model
        collectionView.reloadData()
    }
    
    func setKRTimelyTable(of model: SKThreeThreedays) {
        ThreeDaysWeatherModel = model
        collectionView.reloadData()
    }
    
    
    // MARK: - CollectionView Data Source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimeCollectionViewCell.identifier, for: indexPath) as! TimeCollectionViewCell
        
        let index = indexPath.item
        
        if WeatherManager.isLocationKorea() {
            if let model = ThreeDaysWeatherModel {
                cell.setKRHourlyWeather(of: model, at: index)
            }
        } else {
            if let model = weatherModel {
                cell.setHourlyWeather(of: model, at: index)
            }
        }
        
        return cell
    }
    
    // MARK: - CollectionView FlowLayout Delegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: EJSize((375-44)/6), height: EJSizeHeight(131.0))
    }
    
    // 22pt...
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: EJSizeHeight(0.0), left: EJSize(22.0), bottom: EJSizeHeight(0.0), right: EJSize(22.0))
    }
    
}
