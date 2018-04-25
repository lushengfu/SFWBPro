//
//  SFWBStatus.swift
//  SFWBPro
//
//  Created by happy on 2018/3/14.
//  Copyright © 2018年 happy. All rights reserved.
//

import UIKit
import YYModel

@objcMembers class SFWBStatus: NSObject {

    var id: Int64 = 0
    
    var text: String?
    
    /// 转发数
    var reposts_count: Int = 0
    
    /// 评论数
    var comments_count: Int = 0
    
    /// 点赞数
    var attitudes_count: Int = 0
    
    /// 微博用户
    var user: SFWBUser?
    
    /// 微博配图
    var pic_urls: [SFWBStatusPicture]?
    
    override var description: String {
        return yy_modelDescription()
    }
    
    class func modelContainerPropertyGenericClass() -> [String : AnyClass] {
        
        return ["pic_urls" : SFWBStatusPicture.self]
        
    }
    
}
