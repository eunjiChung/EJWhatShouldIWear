//
//  EJFireStoreManager.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2021/01/14.
//  Copyright © 2021 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Foundation
import Firebase

typealias Dictionary = [String: Any]

final class EJFireStoreManager: NSObject {

    static let shared = EJFireStoreManager()
    var db: Firestore

    private override init() {
        db = Firestore.firestore()
        super.init()
    }

    func getStoreID(success: (([EJStoreModel]) -> Void)?) {
        db.collection(EJMallCollection.store).getDocuments { (snapshot, error) in
            guard error == nil else {
                EJLogger.e(error?.localizedDescription ?? "")
                return
            }

            // TODO: - 위치 고민..
            guard let documents = snapshot?.documents else { return }
            var stores: [EJStoreModel] = []
            for document in documents {
                let dictionary = document.data()
                if let name = dictionary[EJMallModelKey.name] as? String,
                   let type = dictionary[EJMallModelKey.type] as? String,
                   let url = dictionary[EJMallModelKey.url] as? String {
                    stores.append(EJStoreModel(id: document.documentID, name: name, type: type, url: url))
                }
            }
            success?(stores)
        }
    }

    func getItems(document id: String, _ level: Int, success: ((QuerySnapshot?) -> Void)?) {

        let items = db.collection(EJMallCollection.store).document(id).collection(EJMallCollection.items)

        items.whereField(EJMallField.level, arrayContains: level).getDocuments { (snapShot, error) in
            if let error = error {
                EJLogger.e(error.localizedDescription)
            } else {
                success?(snapShot)
            }
        }
    }

    func create(collection name: String, param: Dictionary) {
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil
        ref = db.collection(name).addDocument(data: param) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }

    func read(collection name: String, success: ((QuerySnapshot?) -> Void)?) {
        db.collection(name).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                success?(querySnapshot)
            }
        }
    }
    
    func add(collection name: String, param: Dictionary) {
        var ref: DocumentReference? = nil
        // Add a second document with a generated ID.
        ref = db.collection(name).addDocument(data: param) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
}
