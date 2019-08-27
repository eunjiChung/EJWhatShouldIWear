//
//  BlogTableViewCell.swift
//  EJWhatShouldIWear
//
//  Created by eunji on 27/08/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class BlogTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellTitleLabel: UILabel!
    @IBOutlet weak var blogButton: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func didTouchBlogBtn(_ sender: Any) {
        let blogString = "https://klala1203.tistory.com/"
        guard let blogUrl = URL(string: blogString) else { return }
        
        if UIApplication.shared.canOpenURL(blogUrl) {
            UIApplication.shared.open(blogUrl, options: [:], completionHandler: nil)
        }
    }
    
}
