//
//  ShowClothTableViewCell.swift
//  EJWhatShouldIWear
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 16/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class ShowClothTableViewCell: UITableViewCell {
    
    static let identifier = "ShowClothTableViewCell"
    
    // MARK: - IBOutlet
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    
    @IBOutlet weak var firstClothImageView: UIImageView!
    @IBOutlet weak var secondClothImageview: UIImageView!
    @IBOutlet weak var thirdClothImageView: UIImageView!
    @IBOutlet weak var suggestLabel: UILabel!
    @IBOutlet weak var yesterdayLabel: UILabel!
    @IBOutlet weak var feelingLabel: UILabel!
    
    // MARK: - Constraints
    
    @IBOutlet weak var alcTopOfLocationLabel: NSLayoutConstraint!
    @IBOutlet weak var alcHeightOfClothImageView: NSLayoutConstraint!
    @IBOutlet weak var alcTopOfCurrentTempLabel: NSLayoutConstraint!
    @IBOutlet weak var alcHeightOfSuggestLabel: NSLayoutConstraint!
    @IBOutlet weak var alcHeightOfYesterdayLabel: NSLayoutConstraint!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        alcTopOfLocationLabel.constant = EJSize(30.0)
        alcHeightOfClothImageView.constant = EJSize(256.0)
        alcTopOfCurrentTempLabel.constant = EJSize(21.0)
        alcHeightOfSuggestLabel.constant = EJSize(45.5)
        alcHeightOfYesterdayLabel.constant = EJSize(47.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
