//
//  PickDistrictTableViewCell.swift
//  EJWhatShouldIWear
//
//  Created by eunji on 06/11/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class PickDistrictTableViewCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK: - Identifier
    static let identifier = "PickDistrictTableViewCell"

    // MARK: - Instance
    var data: [String] = []
    
    // MARK: - IBOutlets
    @IBOutlet weak var districtPickerView: UIPickerView!
    
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        print("Pickerview Data: \(data)")
        
        // Initialization code
        districtPickerView.delegate = self as UIPickerViewDelegate
        districtPickerView.dataSource = self as UIPickerViewDataSource
    }
    
    // MARK: - PickerView Delegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
}
