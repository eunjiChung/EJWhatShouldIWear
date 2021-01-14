//
//  EJStoreModel.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2021/01/14.
//  Copyright © 2021 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Foundation

class EJStoreModel {
    var id: String
    var name: String
    var type: String
    var url: String

    var items: [EJItemModel]?

    init(id: String, name: String, type: String, url: String) {
        self.id = id
        self.name = name
        self.type = type
        self.url = url
    }
}

struct EJItemModel {
    var id: String
    var name: String
    var type: EJClothCategory
    var subtype: String?
    var url: String
    var imageUrl: String
}
