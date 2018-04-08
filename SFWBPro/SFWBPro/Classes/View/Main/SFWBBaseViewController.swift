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
// 获取状态栏的高度
let statusbarHeight = UIApplication.shared.statusBarFrame.height
// 默认导航栏的高度
let navigationHeight : CGFloat = 44

class SFWBBaseViewController: UIViewController {
    // 登录标记 (false为未登录, true为已登录)
    
    /// 访客视图基本信息
    var vistorInfo : [String : String]?
    
    var tableView : UITableView?
    // 添加刷新控件
    var refreshControl : UIRefreshControl?
    
    // 是否上拉
    var isPullUp = false
    
    lazy var navigationBar = SFSecondNavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: navigationHeight))
    
    lazy var navItem = UINavigationItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UI设置
        setupUI()
        // 加载数据
        loadData()
        
        // 布局的调试
        if #available(iOS 11, *) {
            
            additionalSafeAreaInsets = UIEdgeInsetsMake(0, 0, 0, 0)

            tableView?.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentBehavior.never
            
        } else {
            
            automaticallyAdjustsScrollViewInsets = false;
        }
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
            
            print(statusbarHeight)
            print(navigationBar.bounds.height)
//            navigationBar.yw_top = statusbarHeight
            
//            UIApplication.shared.statusBarStyle = .lightContent
            
//            for view in self.navigationBar.subviews {
//                print(view)
//            }
        }
    }
    
    fileprivate func setupUI() {
        view.backgroundColor = UIColor.yw_random()
        
        setupNavigationBar()
        
        // 三目运算
        SFWBNetworkManager.share.userLogon ? setupTableView() : setupVistorView()
        
    }
    
    // 设置控制器的表格
    func setupTableView() {
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        
        view.insertSubview(tableView!, belowSubview: navigationBar)
        
        tableView?.delegate = self
        tableView?.dataSource = self
        
        tableView?.contentInset = UIEdgeInsetsMake(navigationBar.bounds.height, 0,
                                                   tabBarController?.tabBar.bounds.height ?? 49, 0)
        
        // 初始化刷新控件
        refreshControl = UIRefreshControl()
        // 添加刷新控件到表格视图
        tableView?.addSubview(refreshControl!)
        // 刷新控件添加事件
        refreshControl?.addTarget(self, action: #selector(loadData), for: UIControlEvents.valueChanged)
        
    }
    
    /// 加载数据源方法
    @objc func loadData() {
        // 子类不实现该方法时, 默认为结束刷新
        refreshControl?.endRefreshing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}


// MARK: - 处理点击事件
extension SFWBBaseViewController {
    
    @objc fileprivate func loginClick() {
        print("点击登录按钮")
        // 点击登录,发送通知
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: SFWBUserLoginNotification), object: nil)
    }
    
    @objc fileprivate func registerClick() {
        print("点击注册按钮")
    }
    
}

// MARK: - 界面设置
extension SFWBBaseViewController {
    
    // 设置访客视图
    fileprivate func setupVistorView() {
        let vistorView = SFWBVistorView(frame: view.bounds)
        
//        vistorView.backgroundColor = UIColor.yw_random()
        
        view.insertSubview(vistorView, belowSubview: navigationBar)
        
        vistorView.vistorInfo = vistorInfo
        
        //登录注册按钮添加target
        vistorView.registerButton.addTarget(self, action: #selector(registerClick), for: .touchUpInside)
        vistorView.loginButton.addTarget(self, action: #selector(loginClick), for: .touchUpInside)
    }
    
    // 设置自定义导航栏
    fileprivate func setupNavigationBar() {
        
        navigationBar.yw_height = statusbarHeight + navigationHeight;
        // 添加自定义导航栏
        view.addSubview(navigationBar)
        
        navigationBar.items = [navItem]
        // 设置背景颜色
        // navigationBar.barTintColor = UIColor.yw_color(withHex: 0xf6f6f6)
        navigationBar.backgroundColor = UIColor.yw_color(withHex: 0xf6f6f6)
        // 设置标题字体颜色
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.darkGray]
        // 设置左右两边按钮的字体颜色
        navigationBar.tintColor = UIColor.orange
        
        navItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(registerClick))
        navItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .plain, target: self, action: #selector(loginClick))
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let row = indexPath.row
        
        let section = tableView.numberOfSections - 1
        
        if row < 0 && section < 0 {
            return
        }
        
        let count = tableView.numberOfRows(inSection: section)
        
        if row == count - 1 && !isPullUp{
            print("上拉刷新")
            
            isPullUp = true
            
            loadData()
            
        }
        
        
    }
    
}

