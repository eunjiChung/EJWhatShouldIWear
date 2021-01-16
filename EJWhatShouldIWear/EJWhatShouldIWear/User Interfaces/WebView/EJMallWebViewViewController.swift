//
//  EJMallWebViewViewController.swift
//  EJWhatShouldIWear
//
//  Created by chungeunji on 2021/01/16.
//  Copyright © 2021 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit
import WebKit

final class EJMallWebViewViewController: UIViewController {

    @IBOutlet weak var webContentView: UIView!
    var webView: WKWebView?
    var mallTitle: String?
    var urlString: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        initWebView()

        if let urlString = self.urlString {
            loadWebPage(urlString)
        }
    }

    private func initView() {
        self.title = mallTitle
    }

    private func initWebView() {
        let contentController = WKUserContentController()
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = contentController
        configuration.preferences.javaScriptEnabled = true
        configuration.mediaTypesRequiringUserActionForPlayback = []
        configuration.allowsInlineMediaPlayback = true

        webView = WKWebView(frame: self.view.frame, configuration: configuration)
        webContentView.addSubview(webView!)

        webView?.navigationDelegate = self
        webView?.uiDelegate = self
        webView?.scrollView.delegate = self
    }

    func loadWebPage(_ urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView?.load(request)
        }
    }

    @IBAction func touchBack(_ sender: Any) {
        webView?.goBack()
    }

    @IBAction func touchForward(_ sender: Any) {
        webView?.goForward()
    }

    @IBAction func touchRefresh(_ sender: Any) {
        webView?.reload()
    }

    @IBAction func touchShsare(_ sender: Any) {

        let currentUrl = webView?.url?.absoluteString
        let textToShare = [currentUrl]
        let activityVC = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        present(activityVC, animated: true, completion: nil)
    }
    
    @IBAction func touchClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension EJMallWebViewViewController: WKUIDelegate, WKNavigationDelegate {

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let currentUrl = webView.url?.absoluteString, let afterUrl = navigationAction.request.url?.absoluteString else {
            decisionHandler(.cancel)
            return
        }

        if currentUrl != afterUrl, afterUrl.contains("document_srl") {
            loadWebPage(afterUrl)
            decisionHandler(.allow)
            return
        } else if navigationAction.request.url?.scheme == "tel" {
            UIApplication.shared.open(navigationAction.request.url!, options: [:], completionHandler: nil)
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }

    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        webView.reload()
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url?.absoluteString else {
            decisionHandler(.cancel)
            return
        }

        decisionHandler(.allow)
    }

    // MARK: - Show Alert from Webview
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let otherAction = UIAlertAction(title: "OK", style: .default, handler: {action in completionHandler()})
        alert.addAction(otherAction)
        self.present(alert, animated: true, completion: nil)
    }

    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "CANCEL", style: .cancel, handler: {(action) in completionHandler(false)})
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {(action) in completionHandler(true)})
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}

extension EJMallWebViewViewController: UIScrollViewDelegate {

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        UIView.animate(withDuration: 0.3) {
            self.navigationController?.setNavigationBarHidden(velocity.y > 0, animated: true)
            self.navigationController?.setToolbarHidden(velocity.y > 0, animated: true)
        }
    }
}

extension UIViewController {

    func showWebView(_ urlString: String) {
        guard let navi = UIStoryboard(name: "WebView", bundle: nil).instantiateViewController(withIdentifier: "EJMallNavigationController") as? UINavigationController,
              let webView = navi.viewControllers.first as? EJMallWebViewViewController else { return }
        webView.urlString = urlString
        present(navi, animated: true, completion: nil)
    }

}
