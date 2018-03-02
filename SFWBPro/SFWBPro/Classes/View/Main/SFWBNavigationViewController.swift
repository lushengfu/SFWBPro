//
//  SFWBNavigationViewController.swift
//  SFWBPro
//
//  Created by happy on 2018/3/1.
//  Copyright © 2018年 happy. All rights reserved.
//

import UIKit

class SFWBNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 先隐藏导航栏
        navigationBar.isHidden = true
    }
    
    // 重写push方法,隐藏tabbar
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
//         不是栈底控制器,就隐藏tabbar
        if childViewControllers.count > 0 {
            hidesBottomBarWhenPushed = true
        }
        
        super.pushViewController(viewController, animated: true)
    }

}
