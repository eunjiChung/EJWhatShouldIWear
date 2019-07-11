//
//  AlarmTableViewCell.swift
//  EJWhatShouldIWear
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 17/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class AlarmTableViewCell: UITableViewCell {
    
    @IBOutlet weak var notiSetLabel: UILabel!
    @IBOutlet weak var descriptLabel: UILabel!
    @IBOutlet weak var notificationSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        notiSetLabel.text = LocalizedString(with: "setting_noti")
        descriptLabel.text = LocalizedString(with: "alarm_message")
        
        notificationSwitch.isOn = myUserDefaults.bool(forKey:SWITCH_ID)
    }

    @IBAction func didChangeNotificationState(_ sender: Any) {
        if notificationSwitch.isOn {
            notificationSwitch.setOn(false, animated: true)
            Library.deniedNotification()
        } else {
            notificationSwitch.setOn(true, animated: true)
            Library.allowNotification()
        }
    }
    
    
}
