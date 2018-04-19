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
    
    /// 微博用户
    @objc var user: SFWBUser?
    
    override var description: String {
        return yy_modelDescription()
    }
    
}
