//
//  EJFirebaseDBManager.swift
//  EJWhatShouldIWear
//
//  Created by CHUNGEUNJI on 16/04/2020.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Foundation
import FirebaseDatabase

final class EJFirebaseDBManager {
    // MARK: - Shared
    static let shared = EJFirebaseDBManager()
    
    // MARK: - Property
    var ref = Database.database().reference()
    var noticeData = [[String: Any]]()

    // MARK: - Function
    func getNoticeDB(completion: @escaping ([[String: Any]]) -> Void) {
        if !noticeData.isEmpty {
            completion(self.noticeData)
            return
        }
        
        self.ref.child("notices").queryOrdered(byChild: "timeRelease").observeSingleEvent(of: .value) { (datasnapshot) in
            for item in datasnapshot.children.allObjects as! [DataSnapshot] {
                let notice = item.value as! [String: Any]
                self.noticeData.append(notice)
            }
            
            self.noticeData.reverse()   // 최신순으로 하기 위해 reverse해줌
            completion(self.noticeData)
        }
    }
}
