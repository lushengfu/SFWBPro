//
//  SFWBOAuthViewController.swift
//  SFWBPro
//
//  Created by happy on 2018/4/8.
//  Copyright © 2018年 happy. All rights reserved.
//

import UIKit

class SFWBOAuthViewController: UIViewController {
    
    lazy var webView  = UIWebView()
    
    override func loadView() {
        view = webView
        
        title = "login sina";
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", target: self, selector: #selector(close), isBack: true)
        
        view.backgroundColor = UIColor.white
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    // MARK: event responce
    @objc fileprivate func close() {
        dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
