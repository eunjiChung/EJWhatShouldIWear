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

typealias JSONType = [String: Any]

class EJHTTPClient: NSObject {
    
    // MARK: - Initialize
    override init() {
        super.init()
    }
    
    // MARK: - Alamofire
    func weatherRequest(url: String,
                        lat:Double,
                        lon:Double,
                      success: @escaping (JSONType) -> (),
                      failure: @escaping (Error) -> ()) {
    
        
        guard let result = URL(string: url) else {
            fatalError()
        }
        
        Alamofire.request(result).responseJSON { (response) in
            
            if response.result.isSuccess
            {
                if let result = response.result.value as? JSONType
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
