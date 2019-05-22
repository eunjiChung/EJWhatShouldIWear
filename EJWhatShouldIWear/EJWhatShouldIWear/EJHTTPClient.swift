//
//  EJHTTPClient.swift
//  EJWhatShouldIWear
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 21/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class EJHTTPClient: NSObject {

    fileprivate let latitude: Double
    fileprivate let longitude: Double
    
    // MARK : - init
    public init(_ latitude:Double, _ longitude:Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    // MARK : - Alamofire
    func basicRequest(to type:String,
                      success: @escaping (Any) -> (),
                      failure: @escaping (Error) -> ()) {
        
        let url = "https://api2.sktelecom.com/weather/\(type)?version=1&lat=\(self.latitude)&lon=\(self.longitude)&appKey=\(tDeveloperKey)"
        
        guard let result = URL(string: url) else {
            fatalError()
        }
        
        Alamofire.request(result).responseJSON { (response) in
            
            if response.result.isSuccess
            {
                if let data = response.result.value
                {
                    success(data)
                }
                
            } else {
                if let error = response.result.error
                {
                    failure(error)
                }
            }
        }
    }

}
