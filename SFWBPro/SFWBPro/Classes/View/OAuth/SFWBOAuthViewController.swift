//
//  SFWBOAuthViewController.swift
//  SFWBPro
//
//  Created by happy on 2018/4/8.
//  Copyright © 2018年 happy. All rights reserved.
//

import UIKit
import WebKit
import SVProgressHUD

class SFWBOAuthViewController: UIViewController {
    
    fileprivate lazy var webView  = WKWebView()
    
    override func loadView() {
        view = webView
        
        title = "login sina";
        
        webView.navigationDelegate = self
        
        webView.scrollView.isScrollEnabled = false
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", target: self, selector: #selector(close), isBack: true)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "自动填充", target: self, selector: #selector(autoFill))
        
        view.backgroundColor = UIColor.white
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlStr = "https://api.weibo.com/oauth2/authorize?client_id=\(SFWBAppKey)&redirect_uri=\(SFWBRedirectURL)"
        
        guard let url = URL(string: urlStr) else {
            return
        }
        
        let request = URLRequest(url: url)
        
        webView.load(request)
        
        
    }
    
    // MARK: event responce
    @objc fileprivate func close() {
        SVProgressHUD.dismiss()
        
        dismiss(animated: true, completion: nil)
    }
    
    /// 自动填充
    @objc fileprivate func autoFill() {
        
        let jsStr = "document.getElementById('userId').value='cylushengfu@163.com';"
        
        webView.evaluateJavaScript(jsStr, completionHandler: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}

extension SFWBOAuthViewController : WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let urlStr = navigationAction.request.url?.absoluteString
        print("请求001 --- \(String(describing: urlStr))")
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
//        print("请求路径为----- \(String(describing: navigationResponse.response.url?.absoluteString))")
        
        if navigationResponse.response.url?.absoluteString.hasPrefix(SFWBRedirectURL) == false {
            decisionHandler(.allow)
            return
        }
        
        if navigationResponse.response.url?.query?.hasPrefix("code=") == false {
            decisionHandler(.cancel)
            close()
            return
        }
        
        // swift4.0 去子串
        let codeStr = navigationResponse.response.url?.query ?? ""
        let urlIndex = codeStr.index(after: "code".endIndex)
        let code = codeStr[urlIndex...]
        
        print("授权码是--- \(String(describing: code))")
        SFWBNetworkManager.share.loadAccesstoken(code: String(code))
//        print("请求路径---- \(String(describing: navigationResponse.response.url?.query))")
        decisionHandler(.cancel)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        SVProgressHUD.show()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        SVProgressHUD.dismiss()
    }
    
}
