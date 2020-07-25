//
//  EJWebViewController.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/07/26.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit
import WebKit

final class EJWebViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }
    
    private func initView() {
        if let url = URL(string: weatherNuri) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    @IBAction func didTouchCloseButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

