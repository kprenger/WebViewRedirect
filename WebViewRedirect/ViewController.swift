//
//  ViewController.swift
//  WebViewRedirect
//
//  Created by Kurt Prenger on 12/1/18.
//  Copyright © 2018 MTS. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    private lazy var webViewController = UIViewController()
    
    private var webView: WKWebView?
    private let closeWebViewMsg = "closeWebView"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = WKWebView(frame: view.frame)
        
        /*
         Using a combo of ngrok
         */
        guard let webView = webView else { return }
        webView.configuration.userContentController.add(self, name: closeWebViewMsg)
        
        webView.isUserInteractionEnabled = true
        webView.navigationDelegate = self
        
        /*
         Using a combo of ngrok and python's SimpleHttpServer, you can host the `index.html` page locally
         and access it as if it were actually on the internet. More info in the README.
         */
        
        guard let url = URL(string: "https://0295a737.ngrok.io") else { return }
        webView.load(URLRequest(url: url))
        
        webViewController.view.addSubview(webView)
    }

    @IBAction func openLinkTouched(_ sender: UIButton) {
        let app = UIApplication.shared
        guard let url = URL(string: "https://bit.ly/2O8tZnw") else { return }
        
        if (app.canOpenURL(url)) {
            app.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func openWebViewTouched(_ sender: Any) {
        present(webViewController, animated: true, completion: nil)
    }
}

extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print("nav action")
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        print("nav response")
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("failure")
    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        print("redirect")
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("provisional nav start")
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("provisional nav fail")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("finished")
    }
}

extension ViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        closeWebView()
    }
    
    func closeWebView() {
        webViewController.dismiss(animated: true, completion: nil)
    }
}

