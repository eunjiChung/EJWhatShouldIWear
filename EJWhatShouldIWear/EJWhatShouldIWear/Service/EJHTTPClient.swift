//
//  EJHTTPClient.swift
//  EJWhatShouldIWear
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 21/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Alamofire

final class EJHTTPClient: NSObject {
    
    func weatherRequest(url: String,
                        success: @escaping (Data?) -> (),
                        failure: @escaping (Error) -> ()) {
        guard let result = URL(string: url) else { fatalError() }
        AF.request(result).responseJSON { response in
            switch response.result {
            case .success(let model):
                let jsonModel = model as! [String: Any]
                if let error = jsonModel["error"] {
                    let errorJSON = error as! [String: Any]
                    let code = errorJSON["code"] as! String
                    if code == "8102" {
                        success(nil)
                    }
                } else {
                    if let data = response.data {
                        success(data)
                    } else {
                        success(nil)
                    }
                }
            case .failure(let error):
                failure(error)
            }
        }
    }
}
