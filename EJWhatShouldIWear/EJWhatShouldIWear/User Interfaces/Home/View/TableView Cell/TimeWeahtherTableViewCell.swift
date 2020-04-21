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
    
    // MARK: - Properties
    var weatherModel: EJFiveDaysWeatherModel?    // Other Country Weather Model
    var timeRelease: String?
    var timeArray: [String]?
    var tempArray: [String]?
    
    var model: [EJThreedaysForecastModel]? {
        didSet {
            setKRTimelyTable()
        }
    }
    
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
        alcBottomConstraintOfCollectionView.constant = EJSizeHeight(30.0)
        
        collectionView.dataSource = self as UICollectionViewDataSource
        collectionView.delegate = self as UICollectionViewDelegate
        
        collectionView.register(UINib.init(nibName: "TimeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: TimeCollectionViewCell.identifier)
    }
    
    // MARK: - Setting WeatherInfo Method
    func setTimelyTable(of model: EJFiveDaysWeatherModel) {
        weatherModel = model
        collectionView.reloadData()
    }
    
    func setKRTimelyTable() {
        collectionView.reloadData()
    }
    
    
    // MARK: - CollectionView Data Source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let model = model {
            guard let fcst3hour = model.first?.fcst3hour else { return 6 }
            guard let temp = fcst3hour.temperature else { return 6 }
            return 20
            // TODO: - 다시 셀 수 있는 방법 찾자
//            return temp.dictionaryRepresentation().count-2
        }
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimeCollectionViewCell.identifier, for: indexPath) as! TimeCollectionViewCell
        let index = indexPath.item
        
        if let model = model {
            cell.index = index
            cell.model = model
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
