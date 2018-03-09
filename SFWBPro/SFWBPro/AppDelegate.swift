//
//  AppDelegate.swift
//  SFWBPro
//
//  Created by happy on 2018/3/1.
//  Copyright © 2018年 happy. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.backgroundColor = UIColor.white
        window?.rootViewController = SFWBMainViewController()
        window?.makeKeyAndVisible()
        
        // 网络加载数据
        loadAppInfo()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
       
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
       
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
    }
}

extension AppDelegate {
    
    fileprivate func loadAppInfo() {
        
        // 模拟网络异步加载数据
        DispatchQueue.global().async {
            
            let url = Bundle.main.url(forResource: "main.json", withExtension: nil)
            
            let data = NSData(contentsOf: url!)
            
            var docmPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            docmPath = (docmPath as NSString).appendingPathComponent("main.json")
            
            data?.write(toFile: docmPath, atomically: true)
            
            print("加载完毕 ..... \(docmPath)")
        }
        
    }
    
}

