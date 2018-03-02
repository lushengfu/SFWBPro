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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}

/// 相当于OC的分类, 同样不能定义属性,只能定义方法
extension SFWBMainViewController {
    
    // 设置子控制器
    fileprivate func setupChildController() {
        
        let array = [
            ["clsName" : "SFWBHomeViewController", "title" : "首页", "imageName" : "home"],
            ["clsName" : "SFWBMessageViewController", "title" : "消息", "imageName" : "message_center"],
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
        let nav = UINavigationController(rootViewController: vc)
        
        return nav
    }
    
}
