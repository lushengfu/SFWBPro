//
//  SFWBNetworkManager.swift
//  SFWBPro
//
//  Created by happy on 2018/3/10.
//  Copyright © 2018年 happy. All rights reserved.
//

import UIKit
import AFNetworking

enum SFWBHttpMethod {
    case Get
    case Post
}

class SFWBNetworkManager: AFHTTPSessionManager {

    static let share = SFWBNetworkManager()
    // 请求数据token
    lazy var userAccount = SFWBUserAccount()
    
    var userLogon : Bool {
        return userAccount.access_token != nil
    }
    
    /// 自动添加token的请求
    func tokenRequest(method: SFWBHttpMethod = .Get, URLString: String, parameters: [String: Any]?, completion:@escaping (_ json: AnyObject?,_ isSuccess: Bool) -> ()) {
        
        guard let token = userAccount.access_token else {
            //FIXME: 没有token, 需要登录
            completion(nil, false)
            // 发送登录通知
            NotificationCenter.default.post(
                name: NSNotification.Name(rawValue: SFWBUserLoginNotification),
                object: "lose token")
            
            return
        }
        
        var parameters = parameters
        
        if parameters == nil {
            parameters = [String : AnyObject]()
        }
        
        // 此处的字典一定有值
        parameters!["access_token"] = token as AnyObject
        
        request(method: method, URLString: URLString, parameters: parameters, completion: completion)
    }
    
    /// get 和 post 请求方法
    ///
    /// - Parameters:
    ///   - method: get/post
    ///   - URLString: urlstring
    ///   - parameters: 自动参数
    ///   - completion: 返回请求结果的回调
    func request(method: SFWBHttpMethod = .Get, URLString: String, parameters: [String: Any]?, completion:@escaping (_ json: AnyObject?,_ isSuccess: Bool) -> ()) {
        
        let sfSuccess = {(task: URLSessionDataTask, json: Any?)->(Void) in
            completion(json as AnyObject, true)
        }
        
        let sfFailure = {(task:URLSessionDataTask?, error: Error)->() in
            
            // 可选可以参与比较
            if (task?.response as? HTTPURLResponse)?.statusCode == 403 {
                //FIXME: 发送通知,token已过期
                
                // 发送登录通知
                NotificationCenter.default.post(
                    name: NSNotification.Name(rawValue: SFWBUserLoginNotification),
                    object: nil)
            }
            print("网络请求失败: \(error)")
            
            completion(nil, false)
        }
        
        if method == .Get {
            get(URLString, parameters: parameters, progress: nil, success: sfSuccess, failure: sfFailure)
        }
        else
        {
            post(URLString, parameters: parameters, progress: nil, success: sfSuccess, failure: sfFailure)
        }
        
    }
    
}
