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
            
            // 添加返回按钮
            if let vc = viewController as? SFWBBaseViewController {
                
                var title = "返回"
                
                if childViewControllers.count == 1 {
                    title = childViewControllers.first?.title ?? "返回"
                }
                
                vc.navItem.leftBarButtonItem = UIBarButtonItem.init(title: title, target: self, selector: #selector(goBackParent), isBack: true)
                
            }
            
        }
        
        
        super.pushViewController(viewController, animated: true)
    }
    
    @objc fileprivate func goBackParent() {
        popViewController(animated: true)
    }

}
