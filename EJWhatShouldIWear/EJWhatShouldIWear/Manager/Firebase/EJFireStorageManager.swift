//
//  EJFireStorageManager.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2021/01/14.
//  Copyright © 2021 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Foundation
import FirebaseStorage

final class EJFireStorageManager: NSObject {

    static let shared = EJFireStorageManager()
    var storage: Storage

    private override init() {
        storage = Storage.storage()
        super.init()
    }

    func downloadImage(url: String, success: ((UIImage?) -> Void)?) {
        storage.reference(forURL: url).downloadURL { (url, err) in
            if let error = err {
                print("❤️", error.localizedDescription)
            } else if let url = url {
                let data = NSData(contentsOf: url)
                success?(UIImage(data: data! as Data))
            }
        }
    }
}
