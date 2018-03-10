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
    
    func statusList(complition: @escaping (_ list: [[String: AnyObject]]?, _ isSuccess: Bool) -> ()) {
        
        let homeUrl = "https://api.weibo.com/2/statuses/home_timeline.json"
        
        
        tokenRequest(URLString: homeUrl, parameters: nil) { (json, isSuccess) in
            
//            if isSuccess {
//                print(json ?? nil)
//            }
            
            let result = json?["statuses"] as? [[String: AnyObject]]
            
            complition(result, isSuccess)
            
        }
        
    }
    
}
