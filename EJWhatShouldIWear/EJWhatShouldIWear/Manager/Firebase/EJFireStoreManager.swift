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

    /*
     새 컬렉션과 문서 만듦
     [
         "first": "Ada",
         "last": "Lovelace",
         "born": 1815
     ]
     */
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
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }

    /*
     컬렉션에 다른 문서 추가
     [
        "first": "Alan",
        "middle": "Mathison",
        "last": "Turing",
        "born": 1912
     ]
     */
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
