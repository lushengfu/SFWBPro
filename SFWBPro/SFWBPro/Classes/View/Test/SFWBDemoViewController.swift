//
//  SFWBDemoViewController.swift
//  SFWBPro
//
//  Created by happy on 2018/3/2.
//  Copyright © 2018年 happy. All rights reserved.
//

import UIKit

class SFWBDemoViewController: SFWBBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "第\(navigationController?.childViewControllers.count ?? 0)个"
    }
    
    @objc fileprivate func showNext() {
        
        let vc = SFWBDemoViewController()
        
        navigationController?.pushViewController(vc, animated: true)
        
    }

    override func setupTableView() {
        super.setupTableView()
        
        navItem.rightBarButtonItem = UIBarButtonItem.init(title: "下一个", target: self, selector: #selector(showNext))
//        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "下一个", style: .plain, target: self, action: #selector(showNext))
    
    }

}
