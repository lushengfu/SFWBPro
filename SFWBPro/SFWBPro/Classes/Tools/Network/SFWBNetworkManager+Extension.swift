//
//  SFWBNetworkManager+Extension.swift
//  SFWBPro
//
//  Created by happy on 2018/3/10.
//  Copyright © 2018年 happy. All rights reserved.
//

import Foundation

/// 封装网络请求
extension SFWBNetworkManager {
    
    /// 获取所有微博数据
    ///
    /// - Parameters:
    ///   - since_id: 下拉刷新时加载比since_id大的微博
    ///   - max_id: 上拉加载时比max_id小的微博
    ///   - complition: 完成回调
    func statusList(since_id: Int64 = 0, max_id: Int64 = 0, complition: @escaping (_ list: [[String: Any]]?, _ isSuccess: Bool) -> ()) {
        
        let homeUrl = "https://api.weibo.com/2/statuses/home_timeline.json"
        
        let params = ["since_id" : "\(since_id)"]
        
        tokenRequest(URLString: homeUrl, parameters: params) { (json, isSuccess) in
            
//            if isSuccess {
//                print(json ?? nil)
//            }
            
            let result = json?["statuses"] as? [[String: Any]]
            
            complition(result, isSuccess)
            
        }
        
    }
    
}
