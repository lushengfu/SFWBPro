//
//  UIImage+Extension.swift
//  SFWBPro
//
//  Created by happy on 2018/4/20.
//  Copyright © 2018年 happy. All rights reserved.
//

import Foundation


extension UIImage {
    
    func sf_avatarImage(size: CGSize?, backColor: UIColor? = UIColor.white, lineColor: UIColor? = UIColor.lightGray, lienWidth: CGFloat = 2.0) -> UIImage? {

        var size = size
        
        if size == nil {
            size = self.size
        }
        
        let rect = CGRect(origin: CGPoint(), size: size!)
        
        // 获取图片的上下文
        UIGraphicsBeginImageContextWithOptions(size!, true, 0.0)
        
        // 背景填充
        backColor?.setFill()
        UIRectFill(rect)
        
        let path = UIBezierPath(ovalIn: rect)
        path.addClip()
        
        draw(at: CGPoint())
        
        // 绘制内切圆,即边框
        UIColor.darkGray.setStroke()
        path.lineWidth = lienWidth
        path.stroke()
        
        let result = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return result
    }
    
}
