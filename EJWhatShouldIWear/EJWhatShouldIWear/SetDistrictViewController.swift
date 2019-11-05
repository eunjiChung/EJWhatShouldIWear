//
//  SetDistrictViewController.swift
//  EJWhatShouldIWear
//
//  Created by CHUNGEUNJI on 06/11/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class SetDistrictViewController: UIViewController {

    // MARK: - Global Instance
    let decoder = JSONDecoder()

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDistrict()
    }
    
    // MARK: - Private Method
    private func getDistrict() {
        if let path = Bundle.main.path(forResource: "korea-district", ofType: "json") {
            if let contents = try? String(contentsOfFile: path) {
                if let data = contents.data(using: .utf8) {
                    if let myDistrict = try? decoder.decode(MyDistrict.self, from: data) {
                        print(myDistrict.data)
                    }
                }
            }
        }
    }
}

extension SetDistrictViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - UITableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
    
}
