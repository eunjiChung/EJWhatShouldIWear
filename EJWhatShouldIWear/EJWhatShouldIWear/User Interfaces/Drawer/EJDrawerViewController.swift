//
//  EJDrawerViewController.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2020/07/08.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class EJDrawerViewController: UIViewController {

    @IBOutlet weak var backView: UIView!
    var didTapBackground: (()->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }
    
    func initView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.view.addGestureRecognizer(tap)
        
        backView.layer.cornerRadius = 10
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        didTapBackground?()
        self.dismiss(animated: true, completion: nil)
    }


}
