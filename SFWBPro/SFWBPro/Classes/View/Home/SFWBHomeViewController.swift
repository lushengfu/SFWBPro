//
//  SFWBHomeViewController.swift
//  SFWBPro
//
//  Created by happy on 2018/3/1.
//  Copyright © 2018年 happy. All rights reserved.
//

import UIKit

class SFWBHomeViewController: SFWBBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @objc fileprivate func showFriends() {
        print(#function)
        
        let vc = SFWBDemoViewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    // 重写UI设置
    override func setupUI() {
        super.setupUI()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "好友", style: .plain, target: self, action: #selector(showFriends));
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension SFWBHomeViewController {
    
}
