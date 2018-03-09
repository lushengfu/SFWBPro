//
//  SFSecondNavigationBar.swift
//  SFWBPro
//
//  Created by happy on 2018/3/2.
//  Copyright © 2018年 happy. All rights reserved.
//

import UIKit

class SFSecondNavigationBar: UINavigationBar {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        if #available(iOS 11, *) {
            // 获取状态栏的高度
//            let statusbarHeight = UIApplication.shared.statusBarFrame.height

            for subview in self.subviews {
                let stringFromClass = NSStringFromClass(subview.classForCoder)
                print("--------- \(stringFromClass)")
                if stringFromClass.contains("BarBackground") {
                    subview.frame = self.bounds
                } else if stringFromClass.contains("UINavigationBarContentView") {
                    subview.frame = CGRect(x: 0, y: statusbarHeight, width: UIScreen.yw_screenWidth(), height: navigationHeight)
                }
            }
        }
        
    }

}
