//
//  SFWBUser.swift
//  SFWBPro
//
//  Created by happy on 2018/4/19.
//  Copyright © 2018年 happy. All rights reserved.
//

import UIKit

class SFWBUser: NSObject {
    /// 用户id
    @objc var id: Int64 = 0
    
    /// 用户名
    @objc var screen_name: String?
    
    /// 用户图像
    @objc var profile_image_url: String?
    
    /// 认证类型 , -1:没有认证, 0:认证用户, 2,3,5:企业认证, 220:达人
    @objc var verified_type: Int = 0
    
    /// 会员等级 0-6
    @objc var mbrank: Int = 0
    
    override var description: String {
        return yy_modelDescription()
    }
    
}
