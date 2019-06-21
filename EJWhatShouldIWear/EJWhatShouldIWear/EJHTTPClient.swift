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
                      success: @escaping ([String: Any]) -> (),
                      failure: @escaping (Error) -> ()) {
    
        let url = owmAPIPath + "lat=\(latitude)&lon=\(longitude)&apiKey=\(owmAppKey)"
        
        guard let result = URL(string: url) else {
            fatalError()
        }
        
        Alamofire.request(result).responseJSON { (response) in
            
            if response.result.isSuccess
            {
                if let result = response.result.value as? [String: Any]
                {
                    success(result)
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
