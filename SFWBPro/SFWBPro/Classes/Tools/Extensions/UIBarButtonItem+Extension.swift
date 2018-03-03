//
//  UIBarButtonItem+Extension.swift
//  SFWBPro
//
//  Created by happy on 2018/3/2.
//  Copyright © 2018年 happy. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    /// 创建UIBarButtonItem
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - fontSize: 字体大小,默认是16
    ///   - target: 对象传递
    ///   - selector: 方法执行
    ///   - isBack: 是否包含图片
    convenience init(title : String, fontSize : CGFloat = 16, target: AnyObject?, selector: Selector, isBack: Bool = false){
        let button : UIButton = UIButton.yw_textButton(title, fontSize: fontSize, normalColor: UIColor.darkGray, highlightedColor: UIColor.orange)
        button.addTarget(target, action: selector, for: .touchUpInside)
        
        if isBack {
            let imageName = "navigationbar_back_withtext"
            
            button.setImage(UIImage.init(named: imageName), for: .normal)
            button.setImage(UIImage.init(named: imageName + "_highlighted"), for: .highlighted)
        }
        
        self.init(customView: button)
    }
    
}
