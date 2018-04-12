//
//  SFWBMainViewController.swift
//  SFWBPro
//
//  Created by happy on 2018/3/1.
//  Copyright © 2018年 happy. All rights reserved.
//

import UIKit
import SVProgressHUD

class SFWBMainViewController: UITabBarController {
    
    fileprivate var timer : Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置子控制器
        setupChildController()
        // 添加发布按钮
        addComposeButton()
        // 添加定时器
        setupTimer()
        // 添加代理
        delegate = self
        
        NotificationCenter.default.addObserver(
            self,
            selector:#selector(userLogin),
            name:NSNotification.Name(rawValue: SFWBUserLoginNotification),
            object: nil)
    }
    
    // 页面销毁时,移除定时器
    deinit {
        timer?.invalidate()
        
        NotificationCenter.default.removeObserver(self)
    }
    
    /**
     portrait : 竖屏, 肖像
     landscape : 横屏, 风景画
     
     - 使用代码控制设备的方向,好处可以再需要横屏的时候,单独处理!
     - 设置支持的方向后,当前的控制器及子控制器都会遵守这个方向!
     - 如果播放视频, 通常是通过 modal 展现的!
     */
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    @objc fileprivate func userLogin(n : Notification) {
        
        print("进入登录页面 \(n)")
        
        var when = DispatchTime.now()
        
        if n.object != nil {
            SVProgressHUD.setDefaultMaskType(.gradient)
            SVProgressHUD.showInfo(withStatus: "用户登录信息过期,请重新登录!!!")
            
            when = DispatchTime.now() + 2
        }
        
        DispatchQueue.main.asyncAfter(deadline: when) {
            SVProgressHUD.setDefaultMaskType(.clear)
            let nav = UINavigationController(rootViewController: SFWBOAuthViewController())
            self.present(nav, animated: true, completion: nil)
        }
        
       
        
    }
    
    // MARK: 发布微博点击事件
    // FIXME: 发布微博
    // @objc  允许这个函数在运行时通过OC的消息机制被调用
    @objc fileprivate func composeStatus() {
        print("发布微博")
    }

    // 懒加载发布按钮
    fileprivate lazy var composeButton : UIButton = UIButton.yw_imageButton("tabbar_compose_icon_add", backgroundImageName: "tabbar_compose_button")
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

/// 添加定时器,实时更新微博的条数
extension SFWBMainViewController {
    
    /// 初始化定时器
    fileprivate func setupTimer() {
//        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    /// 定时器循环的方法
    @objc fileprivate func updateTimer() {
        SFWBNetworkManager.share.unreadCount { (count) in
            print("有\(count)条未读的微博")
            let barItem =  self.tabBar.items![0]
            barItem.badgeValue = count > 0 ? "\(count)" : nil
            
            UIApplication.shared.applicationIconBadgeNumber = Int(count)
        }
    }
}

// MARK: - UITabBarControllerDelegate代理方法
extension SFWBMainViewController : UITabBarControllerDelegate {
    
    /// 将要跳转选中的控制器
    ///
    /// - Parameters:
    ///   - tabBarController:
    ///   - viewController: 目标控制器
    /// - Returns:
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        let index = (childViewControllers as NSArray).index(of: viewController)
        
        if selectedIndex == 0 && selectedIndex == index {
            
            let nav = childViewControllers[0] as! SFWBNavigationViewController
            let vc = nav.childViewControllers[0] as! SFWBHomeViewController
            
            let height = statusbarHeight + navigationHeight
            
            vc.tableView?.setContentOffset(CGPoint.init(x: 0, y: -height), animated: true)
            // 延迟刷新数据
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                vc.loadData()
            })
        }
        
        return !viewController.isMember(of: UIViewController.self)
    }
    
}

/// 相当于OC的分类, 同样不能定义属性,只能定义方法
extension SFWBMainViewController {
    
    // 添加发布按钮
    fileprivate func addComposeButton() {
        tabBar.addSubview(composeButton)
        
        let count = childViewControllers.count
        
        let width = view.bounds.width / CGFloat(count) // 这里减1,是要完全覆盖tabbarItem的扩容区(容错区)
        
        // CGRectInset 正数是向内缩进,负数是向外扩展
        composeButton.frame = tabBar.bounds.insetBy(dx: 2 * width, dy: 0)
        
        // 添加监听方法
        composeButton.addTarget(self, action: #selector(composeStatus), for: .touchUpInside)
    }
    
    // 设置子控制器
    fileprivate func setupChildController() {
        
        // 先检查本地沙盒是否有值
        var documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        documentPath = (documentPath as NSString).appendingPathComponent("main.json")
        
        var data = NSData(contentsOfFile: documentPath)
        
        if data == nil {
            let path = Bundle.main.path(forResource: "main.json", ofType: nil)
            data = NSData(contentsOfFile: path!)
            
        }
        
        guard let array = try? JSONSerialization.jsonObject(with: data! as Data, options: []) as? [[String : AnyObject]]
        else {
            return
        }
        
//        let array : [[String : AnyObject]] = [
//            ["clsName" : "SFWBHomeViewController" as AnyObject, "title" : "首页" as AnyObject, "imageName" : "home" as AnyObject,
//             "vistorInfo" : ["imageName" : "", "message" : "关注一下人,看看这里有什么新鲜事或者新鲜人的! 加油💪⛽️"] as AnyObject],
//            ["clsName" : "SFWBMessageViewController" as AnyObject, "title" : "消息" as AnyObject, "imageName" : "message_center" as AnyObject, "vistorInfo" : ["imageName" : "visitordiscover_image_message", "message" : "登录后,可以看到相应的信息,关注一下人,看看这里有什么新鲜事或者新鲜人的! 加油💪⛽️"] as AnyObject],
//            ["clsName" : "UIViewController" as AnyObject],
//            ["clsName" : "SFWBDiscoverViewController" as AnyObject, "title" : "发现" as AnyObject, "imageName" : "discover" as AnyObject,
//             "vistorInfo" : ["imageName" : "visitordiscover_image_message", "message" : "关注一下人,看看这里有什么新鲜事或者新鲜人的! 加油💪⛽️"] as AnyObject],
//            ["clsName" : "SFWBProfileViewController" as AnyObject, "title" : "我的" as AnyObject, "imageName" : "profile" as AnyObject,
//             "vistorInfo" : ["imageName" : "visitordiscover_image_profile", "message" : "登录后,可以看到个人信息,关注一下人,看看这里有什么新鲜事或者新鲜人的! 加油💪⛽️"] as AnyObject]
//        ]
//        (array as NSArray).write(toFile: "/Users/happy/Desktop/demo.plist", atomically: true)
//        let data = try! JSONSerialization.data(withJSONObject: array, options: [.prettyPrinted])
//
//        (data as NSData).write(toFile: "/Users/happy/Desktop/demo.json", atomically: true)
        
        var arrayM = [UIViewController]()
        for dict in array! {
            arrayM.append(controller(dict: dict))
        }
        
        viewControllers = arrayM
        
    }
    
    // 利用字典生成子控制器
    // clsName , title , imageName
    fileprivate func controller(dict : [String : AnyObject]) -> UIViewController {
        guard let clsName = dict["clsName"] as? String,
               let title = dict["title"] as? String,
            let imageName = dict["imageName"] as? String,
        let vistorInfo = dict["vistorInfo"] as? [String : String],
            let cls = NSClassFromString(Bundle.main.nameSpace + "." + clsName) as? SFWBBaseViewController.Type
        else {
            return UIViewController()
        }
        
        let vc = cls.init()
        vc.title = title
        vc.tabBarItem.image = UIImage(named: "tabbar_" + imageName)
        vc.tabBarItem.selectedImage = UIImage(named: "tabbar_" + imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
        vc.vistorInfo = vistorInfo
        // 修改tabbar的字体颜色
        vc.tabBarItem.setTitleTextAttributes(
            [NSAttributedStringKey.foregroundColor : UIColor.orange],
            for: .highlighted)
        // 修改字体大小
        vc.tabBarItem.setTitleTextAttributes(
            [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 12)],
            for: UIControlState.init(rawValue: 0))
        
        let nav = SFWBNavigationViewController(rootViewController: vc)
        
        return nav
    }
    
}
