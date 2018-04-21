//
//  SFWBStatus.swift
//  SFWBPro
//
//  Created by happy on 2018/3/14.
//  Copyright © 2018年 happy. All rights reserved.
//

import UIKit
import YYModel

class SFWBStatus: NSObject {

    @objc var id: Int64 = 0
    
    @objc var text: String?
    
    /// 转发数
    @objc var reposts_count: Int = 0
    
    /// 评论数
    @objc var comments_count: Int = 0
    
    /// 点赞数
    @objc var attitudes_count: Int = 0
    
    /// 微博用户
    @objc var user: SFWBUser?
    
    /// 微博配图
    @objc var pic_urls: [SFWBStatusPicture]?
    
    override var description: String {
        return yy_modelDescription()
    }
    
    class func modelContainerPropertyGenericClass() ->[String : AnyClass]? {
        return ["pic_urls" : SFWBStatusPicture.self]
    }
    
}
