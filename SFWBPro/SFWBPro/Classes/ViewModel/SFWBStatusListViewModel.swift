//
//  SFWBStatusListViewModel.swift
//  SFWBPro
//
//  Created by happy on 2018/3/14.
//  Copyright © 2018年 happy. All rights reserved.
//

import Foundation

/// 上拉刷新错误的最大次数
private let maxPullupTryTimes = 3

class SFWBStatusListViewModel {
    
    /// 微博数据源
    lazy var statusList = [SFWBStatusViewModel]()
    /// 记录上拉刷新的错误次数
    private var pullupErrorTimes = 0
    /// 加载微博数据
    ///
    /// - Parameter complition: 完成回调
    func loadStatus(pullUp: Bool, complition: @escaping (_ isSuccess : Bool, _ shouldRefresh : Bool)->()) {
        
        if pullUp && pullupErrorTimes > maxPullupTryTimes {
            complition(true, false)
            return
        }
        
        let since_id : Int64 = pullUp ? 0 : (statusList.first?.status.id ?? 0)
        let max_id : Int64 = !pullUp ? 0 : (statusList.last?.status.id ?? 0)
        
        SFWBNetworkManager.share.statusList(since_id: since_id, max_id: max_id) { (list, isSuccess) in
            
            print("\(String(describing: list))");
            
            if !isSuccess {
                complition(false, false)
                return
            }
            
            var array = [SFWBStatusViewModel]()
            
            for dict in list ?? [] {
                guard let status = SFWBStatus.yy_model(with: dict) else {
                    continue
                }
                
                array.append(SFWBStatusViewModel.init(model: status))
                
            }
            
            
//            guard let array = NSArray.yy_modelArray(with: SFWBStatus.self, json: list ?? []) as? [SFWBStatus] else {
//                complition(isSuccess, false)
//                return
//            }
            
            if pullUp {
                self.statusList += array // 上拉加载
            }
            else {
                self.statusList = array + self.statusList // 下拉刷新
            }
            
            if pullUp && array.count == 0 {
                
                self.pullupErrorTimes += 1
                complition(isSuccess, false)
            } else {
                complition(isSuccess, true)
            }
            
            
        }
        
    }
    
}
