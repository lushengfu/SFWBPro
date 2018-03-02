//
//  UIBarButtonItem+Extension.swift
//  SFWBPro
//
//  Created by happy on 2018/3/2.
//  Copyright © 2018年 happy. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    convenience init(title : String, fontSize : CGFloat = 16, target: AnyObject?, selector: Selector){
        let button : UIButton = UIButton.yw_textButton(title, fontSize: fontSize, normalColor: UIColor.darkGray, highlightedColor: UIColor.orange)
        button.addTarget(target, action: selector, for: .touchUpInside)
        
        self.init(customView: button)
    }
    
}
