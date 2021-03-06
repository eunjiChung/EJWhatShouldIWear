//
//  EJShareViewController.swift
//  EJWhatShouldIWear
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 29/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

final class EJShareViewController: EJBaseViewController, UITextViewDelegate {
    // MARK: - Global Instance
    let titleFontSize = EJSizeHeight(30.0)
    
    // MARK: - IBOutlets
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var btnLabel: UIButton!
    @IBOutlet weak var buttonView: UIButton!
    @IBOutlet weak var share1TextLabel: UILabel!
    @IBOutlet weak var share2TextLabel: UILabel!
    @IBOutlet weak var share3TextLabel: UILabel!
    
    @IBOutlet weak var alcBottomOfSendBtn: NSLayoutConstraint!
    @IBOutlet weak var alcTopOfBackIcon: NSLayoutConstraint!
    @IBOutlet weak var alcLeadingOfBackIcon: NSLayoutConstraint!
    @IBOutlet weak var alcHeightOfTitleView: NSLayoutConstraint!
    @IBOutlet weak var alcBottomOfStackView: NSLayoutConstraint!
    @IBOutlet weak var alcTopOfButtonLabel: NSLayoutConstraint!
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayoutConstraints()
        setTitleLabel()
        registerKeyboardNotification()
    }
    
    // MARK: - KeyBoard Related Method
    func registerKeyboardNotification () {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        alcBottomOfSendBtn.constant = EJSizeHeight(290.0)
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        alcBottomOfSendBtn.constant = EJSizeHeight(10.0)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "share_placeholder".localized {
            textView.text = ""
            textView.textColor = UIColor.darkGray
        }
        
        textView.textColor = UIColor.darkGray
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let text = textView.text else { return false }
        guard let stringRange = Range(range, in: text) else { return false }
        let changedText = text.replacingCharacters(in: stringRange, with: text)
        return changedText.count <= 80
    }
    
    
    
    
    // MARK: - Action Method
    @IBAction func didTouchBackBtn(_ sender: Any) {
        selectionHapticFeedback()
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Share Link Method
    @IBAction func didTouchShareBtn(_ sender: Any) {
        selectionHapticFeedback()
        
        guard let text = textView.text else { return }
        let appStoreURL = AppStoreURL
        let textToShare = [text, appStoreURL]
        
        let activityVC = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        present(activityVC, animated: true, completion: nil)
        
    }
    
    // MARK: - Private Method
    private func setTitleLabel() {
        buttonView.layer.cornerRadius = 6
        textView.text = "share_placeholder".localized
        share1TextLabel.text = "share1".localized
        share2TextLabel.text = "share2".localized
        share3TextLabel.text = "share3".localized
        share1TextLabel.font = share1TextLabel.font.withSize(titleFontSize)
        share2TextLabel.font = share2TextLabel.font.withSize(titleFontSize)
        share3TextLabel.font = share3TextLabel.font.withSize(titleFontSize)
        btnLabel.setTitle("share".localized, for: .normal)
    }
    
    private func setLayoutConstraints() {
        // Set Button Corner
        btnLabel.layer.cornerRadius = 3.0
        alcTopOfButtonLabel.constant = EJSizeHeight(10.0)
        
        // Back Icon
        alcTopOfBackIcon.constant = EJSizeHeight(46.0)
        alcLeadingOfBackIcon.constant = EJSize(18.0)
        
        // First BackgroundView
        alcHeightOfTitleView.constant = EJSizeHeight(299.0)
        
        // StackView
        if "share1".localized == "" {
            alcBottomOfStackView.constant = EJSizeHeight(40.0)
        } else {
            alcBottomOfStackView.constant = EJSizeHeight(20.0)
        }
    }
}
