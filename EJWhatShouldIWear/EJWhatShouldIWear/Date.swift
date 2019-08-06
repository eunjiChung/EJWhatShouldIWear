//
//  Date.swift
//  EJWhatShouldIWear
//
//  Created by eunji on 06/08/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Foundation


extension String {
    func toDate(_ timezone: Int) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:00:00"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: -timezone)
        return dateFormatter.date(from: self)!
    }
}

extension Date {
    func toHourString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return dateFormatter.string(from: self)
    }
}
