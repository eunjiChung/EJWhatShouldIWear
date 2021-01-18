//
//  EJMallManager.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2021/01/14.
//  Copyright © 2021 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Foundation

struct EJMallCollection {
    static let store = "store"
    static let items = "items"
}

struct EJMallField {
    static let level = "level"
}

struct EJMallModelKey {
    static let name = "name"
    static let type = "type"
    static let url = "url"
    static let subtype = "subtype"
    static let imageUrl = "image_url"
    static let level = "level"
}

final class EJMallManager {

    static let shared = EJMallManager()

    let networkQueue = DispatchQueue(label: "mall request", qos: .background, attributes: .concurrent)
    let networkGroup = DispatchGroup()

    var stores: [EJStoreModel] = []

    func requestLook(_ level: EJWeatherLevel, completion: (() -> Void)?) {
        EJFireStoreManager.shared.getStoreID { stores in
            self.stores = stores

            for store in stores {
                self.networkGroup.enter()
                self.requestItems(store.id, level)
            }

            self.networkGroup.notify(queue: self.networkQueue) {
                EJLogger.d(self.stores)
                completion?()
            }
        }
    }

    private func requestItems(_ id: String, _ level: EJWeatherLevel) {
        EJFireStoreManager.shared.getItems(document: id, level.rawValue) { (snapshot) in
            guard let documents = snapshot?.documents else { return }

            var items: [EJItemModel] = []
            for document in documents {
                if let name = document[EJMallModelKey.name] as? String,
                   let type = document[EJMallModelKey.type] as? String,
                   let category = EJClothCategory(rawValue: type),
                   let url = document[EJMallModelKey.url] as? String,
                   let imageUrl = document[EJMallModelKey.imageUrl] as? String {
                    items.append(EJItemModel(id: document.documentID, name: name, type: category, subtype: nil, url: url, imageUrl: imageUrl))
                }
            }

            let store = self.stores.first(where: { $0.id == id })
            store?.items = items
            self.finishRequest()
        }
    }

    private func finishRequest() {
        networkQueue.async(group: networkGroup) {
            self.networkGroup.leave()
        }
    }

    enum EJMall: String {
        case ainiu
        case deeplyin = "deeply-in"
        case inyourmind
        case none
    }

    func mallType(_ urlString: String) -> EJMall {
        if urlString.contains(EJMall.ainiu.rawValue) {
            return .ainiu
        } else if urlString.contains(EJMall.deeplyin.rawValue) {
            return .deeplyin
        } else if urlString.contains(EJMall.inyourmind.rawValue) {
            return .inyourmind
        } else {
            return .none
        }
    }
}
