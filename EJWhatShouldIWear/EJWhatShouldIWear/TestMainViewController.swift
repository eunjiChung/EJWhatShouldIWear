//
//  TestMainViewController.swift
//  EJWhatShouldIWear
//
//  Created by CHUNGEUNJI on 02/09/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class TestMainViewController: UIViewController, UICollectionViewDataSource {

    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var locationCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case locationCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LocationCollectionViewCell", for: indexPath) as! LocationCollectionViewCell
            cell.locationLabel.text = "OH"
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainLocationCollectionViewCell", for: indexPath) as! MainLocationCollectionViewCell
            return cell
        }
        
    }

}
