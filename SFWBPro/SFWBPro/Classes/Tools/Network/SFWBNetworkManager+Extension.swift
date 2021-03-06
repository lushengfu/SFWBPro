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
        // @"https://api.weibo.com/2/remind/unread_count.json"
        let params = ["since_id" : "\(since_id)",
            "max_id" : "\(max_id > 0 ? (max_id - 1) : 0)"]
        
        tokenRequest(URLString: homeUrl, parameters: params) { (json, isSuccess) in
            
//            if isSuccess {
//                print(json ?? nil)
//            }
            
            let result = json?["statuses"] as? [[String: Any]]
            
            complition(result, isSuccess)
            
        }
        
    }
    
    /// 获取微博的未读数
    func unreadCount(compltion: @escaping (_ count : Int64)->()) {
        
        let unreadUrl = "https://api.weibo.com/2/remind/unread_count.json"
        
        guard let uid = userAccount.uid  else {
            return
        }
        
        let parame = ["uid" : uid]
        
        tokenRequest(URLString: unreadUrl, parameters: parame) { (json, isSuccess) in
            
            guard let dict = json as? [String : Any] else {
                return
            }
            print(dict["status"] as? Int64 ?? 0)
            let count = dict["status"] as? Int64 ?? 0
            compltion(count)
            
        }
    }
}

// MARK: - 获取用户信息
extension SFWBNetworkManager {
    
    func loadUserInfo(compltion: @escaping (_ dict: [String : Any])->()) {
        
        let urlStr = "https://api.weibo.com/2/users/show.json"
        
        guard let uid = userAccount.uid  else {
            return
        }
        
        let parameters = ["uid" : uid]
        
        tokenRequest(URLString: urlStr, parameters: parameters) { (json, isSuccess) in
            
            print(json as? [String : Any] ?? [:])
            
            compltion(json as? [String : Any] ?? [:])
        }
        
    }
}


// MARK: - OAuth授权的网络请求
extension SFWBNetworkManager {

    func loadAccesstoken(code : String, completion:@escaping (_ isSuccess: Bool)->()) {
        
        let urlStr = "https://api.weibo.com/oauth2/access_token"
        let parameters = ["client_id" : SFWBAppKey,
                          "client_secret" : SFWBAppSecret,
                          "grant_type" : "authorization_code",
                          "code" : code,
                          "redirect_uri" : SFWBRedirectURL
                          ]
        
        request(method: .Post, URLString: urlStr, parameters: parameters) { (json, isSuccess) in
//            print(json)
            
//            self.userAccount.yy_modelSet(with: json as? [String : AnyObject] ?? [:])
            self.userAccount.yy_modelSet(withJSON: (json as? [String : AnyObject]) ?? [:])
            print(self.userAccount)
            // 获取用户信息
            self.loadUserInfo(compltion: { (dict) in
                
                self.userAccount.yy_modelSet(with: dict)
                print(self.userAccount)
                // 保存用户信息
                self.userAccount.saveUseraccount()
                completion(isSuccess)
            })
            
            print(self.userAccount)
        }
        
    }
    
}


