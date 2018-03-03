//
//  SFWBBaseViewController.swift
//  SFWBPro
//
//  Created by happy on 2018/3/1.
//  Copyright © 2018年 happy. All rights reserved.
//

import UIKit

class SFWBBaseViewController: UIViewController {

    lazy var navigationBar = SFSecondNavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 64))
    
    lazy var navItem = UINavigationItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // UI设置
        setupUI()
    }
    
    // 标题设置
    override var title: String? {
        didSet {
            navItem.title = title
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if #available(iOS 11, *) {
            
            // 获取状态栏的高度
            let statusbarHeight = UIApplication.shared.statusBarFrame.height
            
            print(statusbarHeight)
            
//            navigationBar.yw_top = statusbarHeight
            
//            UIApplication.shared.statusBarStyle = .lightContent
            
//            for view in self.navigationBar.subviews {
//                print(view)
//            }
            
            
        }
    }
    
    func setupUI() {
        view.backgroundColor = UIColor.yw_random()
        // 添加自定义导航栏
        view.addSubview(navigationBar)
        
        navigationBar.items = [navItem]
        // 设置背景颜色
//        navigationBar.barTintColor = UIColor.yw_color(withHex: 0xf6f6f6)
        navigationBar.backgroundColor = UIColor.yw_color(withHex: 0xf6f6f6)
        // 设置标题字体颜色
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.darkGray]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension SFWBBaseViewController {
    
    
    
}

