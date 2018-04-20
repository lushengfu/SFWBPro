//
//  SFWBStatusViewModel.swift
//  SFWBPro
//
//  Created by happy on 2018/4/19.
//  Copyright © 2018年 happy. All rights reserved.
//

import Foundation


/// 单条微博
class SFWBStatusViewModel: CustomStringConvertible {
    
    var status: SFWBStatus
    /// 会员等级
    var memberIcon: UIImage?
    /// 认证图标
    var vipIcon: UIImage?
    
    
    /// 构造函数,保存模型
    init(model: SFWBStatus) {
        self.status = model
        
        // 设置会员等级
        guard let mbrank = model.user?.mbrank else {
            return
        }
        
        if mbrank > 0 && mbrank < 7 {
            let imageName = "common_icon_membership_level\(mbrank)"
            memberIcon = UIImage.init(named: imageName)
        }
        
        // 认证类型 , -1:没有认证, 0:认证用户, 2,3,5:企业认证, 220:达人
        switch model.user?.verified_type ?? -1 {
        case 0:
            vipIcon = UIImage.init(named: "avatar_vip")
        case 2, 3, 5:
            vipIcon = UIImage.init(named: "avatar_enterprise_vip")
        case 220:
            vipIcon = UIImage.init(named: "avatar_grassroot")
        default:
            return
        }
    }
    
    var description: String {
        return status.description
    }
}
