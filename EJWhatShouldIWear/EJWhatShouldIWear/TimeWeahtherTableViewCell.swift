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
    
    
    // MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.text = LocalizedString(with: "main_timely")
        
        alcTopConstraintOfTextLabel.constant = EJSizeHeight(38.0)
        alcLeadingConstraintOfTextLabel.constant = EJSize(20.0)
        alcTopConstraintOfCollectionView.constant = EJSizeHeight(18.0)
        alcBottomConstraintOfCollectionView.constant = EJSizeHeight(50.0)
        
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
        if let model = ThreeDaysWeatherModel {
            guard let weather = model.weather, let fcst3days = weather.forecast3days, let fcst3hour = fcst3days.first?.fcst3hour else { return 6 }
            guard let temp = fcst3hour.temperature else { return 6 }
            return temp.dictionaryRepresentation().count-2
        }
        
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimeCollectionViewCell.identifier, for: indexPath) as! TimeCollectionViewCell
        
        let index = indexPath.item
        
        if let model = ThreeDaysWeatherModel {
            cell.setKRHourlyWeather(of: model, at: index)
        }
        
        if let model = weatherModel {
            cell.setHourlyWeather(of: model, at: index)
        }
        
        return cell
    }
    
    // MARK: - CollectionView FlowLayout Delegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: EJSize(80.0), height: EJSizeHeight(160.0))
    }
    
}
