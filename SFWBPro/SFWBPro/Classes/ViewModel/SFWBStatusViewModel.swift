//
//  SFWBStatusViewModel.swift
//  SFWBPro
//
//  Created by happy on 2018/4/19.
//  Copyright © 2018年 happy. All rights reserved.
//

import Foundation


/// 单条微博
class SFWBStatusViewModel {
    
    var status: SFWBStatus
    
    /// 构造函数,保存模型
    init(model: SFWBStatus) {
        self.status = model
    }
    
}
