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
    
    // MARK : - Initialize
    override init() {
        super.init()
    }
    
    // MARK : - Alamofire
    func weatherRequest(lat:Double, lon:Double, to type:String,
                      success: @escaping ([String: Any]) -> (),
                      failure: @escaping (Error) -> ()) {
    
        let url = owmAPIPath + type + "?lat=\(lat)&lon=\(lon)&apiKey=\(owmAppKey)"
        
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
