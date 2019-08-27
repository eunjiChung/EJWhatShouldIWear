//
//  InstagramTableViewCell.swift
//  EJWhatShouldIWear
//
//  Created by eunji on 23/08/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class InstagramTableViewCell: UITableViewCell {
    
    @IBOutlet weak var infoTitleLabel: UILabel!
    @IBOutlet weak var tableButton: UIButton!
    
    var typeOfButton: String?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    @IBAction func didTouchButton(_ sender: Any) {
        
        let instagramHooks = "instagram://user?username=ios_code_her"
        guard let instagramUrl = URL(string: instagramHooks) else { return }
        
        if UIApplication.shared.canOpenURL(instagramUrl) {
            print("11111111111111")
            UIApplication.shared.open(instagramUrl, options: [:], completionHandler: nil)
        } else {
            print("2222222222222222")
            UIApplication.shared.open(URL(string: "https://www.instagram.com/ios_code_her/")!, options: [:], completionHandler: nil)
        }
    }
    
}
