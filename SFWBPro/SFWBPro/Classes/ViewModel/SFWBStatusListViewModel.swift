//
//  SFWBStatusListViewModel.swift
//  SFWBPro
//
//  Created by happy on 2018/3/14.
//  Copyright © 2018年 happy. All rights reserved.
//

import Foundation

class SFWBStatusListViewModel {
    
    /// 微博数据源
    lazy var statusList = [SFWBStatus]()
    
    /// 加载微博数据
    ///
    /// - Parameter complition: 完成回调
    func loadStatus(complition: @escaping (_ isSuccess : Bool)->()) {
        
        let since_id : Int64 = statusList.first?.id ?? 0
        
        SFWBNetworkManager.share.statusList(since_id: since_id, max_id: 0) { (list, isSuccess) in
            
            print("\(String(describing: list))");
            
            var array = [SFWBStatus]()
            
            for dict in list ?? []{
                print(dict)
                print(dict["id"] as! NSNumber)
                print(dict["text"] ?? "")
                
                let status = SFWBStatus()
                status.id = dict["id"] as! Int64
                status.text = dict["text"] as? String
                // FIXME: 拼接数据
                array.append(status)
            }
            
//            guard let array = NSArray.yy_modelArray(with: SFWBStatus.self, json: list ?? []) as? [SFWBStatus] else {
//                complition(isSuccess)
//                return
//            }
            
            self.statusList = array + self.statusList
            
            complition(isSuccess)
        }
        
    }
    
}
