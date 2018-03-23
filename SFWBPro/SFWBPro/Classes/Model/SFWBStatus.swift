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

    var id : Int64 = 0
    
    var text : String?
    
    override var description: String {
        return yy_modelDescription()
    }
    
}
