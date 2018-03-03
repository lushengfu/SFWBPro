//
//  SFWBBaseViewController.swift
//  SFWBPro
//
//  Created by happy on 2018/3/1.
//  Copyright © 2018年 happy. All rights reserved.
//

import UIKit

// swift 中,利用 extension 可以把函数按照功能分类管理, 便于阅读和维护!

// extension需要注意的地方:
// 1. 不能定义属性
// 2. 不能重写父类的方法

class SFWBBaseViewController: UIViewController {

    var tableView : UITableView?
    
    lazy var navigationBar = SFSecondNavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 64))
    
    lazy var navItem = UINavigationItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // UI设置
        setupUI()
        // 加载数据
        loadData()
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
        
        setupNavigationBar()
        
        setupTableView()
    }
    
    
    /// 加载数据源方法
    func loadData() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

// MARK: - 界面设置
extension SFWBBaseViewController {
    
    // 设置控制器的表格
    fileprivate func setupTableView() {
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        
        view.insertSubview(tableView!, belowSubview: navigationBar)
        
        tableView?.delegate = self
        tableView?.dataSource = self
    }
    
    // 设置自定义导航栏
    fileprivate func setupNavigationBar() {
        // 添加自定义导航栏
        view.addSubview(navigationBar)
        
        navigationBar.items = [navItem]
        // 设置背景颜色
        // navigationBar.barTintColor = UIColor.yw_color(withHex: 0xf6f6f6)
        navigationBar.backgroundColor = UIColor.yw_color(withHex: 0xf6f6f6)
        // 设置标题字体颜色
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.darkGray]
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SFWBBaseViewController: UITableViewDelegate, UITableViewDataSource {
    
    // 为子类提供实现的方法
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

