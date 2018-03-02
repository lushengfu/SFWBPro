//
//  SFWBMainViewController.swift
//  SFWBPro
//
//  Created by happy on 2018/3/1.
//  Copyright © 2018年 happy. All rights reserved.
//

import UIKit

class SFWBMainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置子控制器
        setupChildController()
        // 添加发布按钮
        addComposeButton()
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

/// 相当于OC的分类, 同样不能定义属性,只能定义方法
extension SFWBMainViewController {
    
    // 添加发布按钮
    fileprivate func addComposeButton() {
        tabBar.addSubview(composeButton)
        
        let count = childViewControllers.count
        
        let width = view.bounds.width / CGFloat(count) - 1 // 这里减1,是要完全覆盖tabbarItem的扩容区(容错区)
        
        // CGRectInset 正数是向内缩进,负数是向外扩展
        composeButton.frame = tabBar.bounds.insetBy(dx: 2 * width, dy: 0)
        
        // 添加监听方法
        composeButton.addTarget(self, action: #selector(composeStatus), for: .touchUpInside)
    }
    
    // 设置子控制器
    fileprivate func setupChildController() {
        
        let array = [
            ["clsName" : "SFWBHomeViewController", "title" : "首页", "imageName" : "home"],
            ["clsName" : "SFWBMessageViewController", "title" : "消息", "imageName" : "message_center"],
            ["clsName" : "UIViewController"],
            ["clsName" : "SFWBDiscoverViewController", "title" : "发现", "imageName" : "discover"],
            ["clsName" : "SFWBProfileViewController", "title" : "我的", "imageName" : "profile"]
        ]
        
        var arrayM = [UIViewController]()
        for dict in array {
            arrayM.append(controller(dict: dict))
        }
        
        viewControllers = arrayM
        
    }
    
    // 利用字典生成子控制器
    // clsName , title , imageName
    fileprivate func controller(dict : [String : String]) -> UIViewController {
        guard let clsName = dict["clsName"],
               let title = dict["title"],
            let imageName = dict["imageName"],
            let cls = NSClassFromString(Bundle.main.nameSpace + "." + clsName) as? UIViewController.Type
        else {
            return UIViewController()
        }
        
        let vc = cls.init()
        vc.title = title
        vc.tabBarItem.image = UIImage(named: "tabbar_" + imageName)
        vc.tabBarItem.selectedImage = UIImage(named: "tabbar_" + imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
        
        // 修改tabbar的字体颜色
        vc.tabBarItem.setTitleTextAttributes(
            [NSAttributedStringKey.foregroundColor : UIColor.orange],
            for: .highlighted)
        // 修改字体大小
        vc.tabBarItem.setTitleTextAttributes(
            [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 12)],
            for: UIControlState.init(rawValue: 0))
        
        let nav = UINavigationController(rootViewController: vc)
        
        return nav
    }
    
}
