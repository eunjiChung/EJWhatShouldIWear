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
    
    func onlyKRTime() -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:00:00"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: -9)
        let dateTime = dateFormatter.date(from: self)!
        let timeInt = Int(dateTime.todayHourString())!
        return timeInt
    }
    
    func onlyDate() -> String {
        guard let date = self.components(separatedBy: " ").first else { return "" }
        return date
    }
}

extension Date {
    func generateDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:00:00"
        return dateFormatter.string(from: self)
    }
    
    func todayDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
    
    func dateCompose() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd"
        return dateFormatter.string(from: self)
    }
    
    func todayDateKRString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M월dd일 HH시 기준"
        return dateFormatter.string(from: self)
    }
    
    
    func todayDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.dd \("hour".localized)"
        return dateFormatter.string(from: self)
    }
    
    func todayHourString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return dateFormatter.string(from: self)
    }
    
    func currentHourInt() -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        return Int(dateFormatter.string(from: self))!
    }
}
