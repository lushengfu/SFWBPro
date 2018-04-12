//
//  SFWBUserAccount.swift
//  SFWBPro
//
//  Created by happy on 2018/4/10.
//  Copyright © 2018年 happy. All rights reserved.
//

import UIKit

/// 定义文件名
fileprivate let accountFile: NSString = "usersccount.json"

class SFWBUserAccount: NSObject {
    /// 用户登录令牌
    @objc var access_token: String? // "2.00GkH66GurCwUCd6b082316bRxf5DE"
    /// 用户id
    @objc var uid: String?
    /// 过期时间
    @objc var expires_in: TimeInterval = 0 {
        didSet {
            expiresDate = Date(timeIntervalSinceNow: expires_in)
        }
    }
    
    @objc var expiresDate: Date?
    
    @objc var isRealName: Bool = false
    /// 用户图像
    @objc var avatar_large: String?
    /// 用户名
    @objc var screen_name: String?
    
    override var description: String {
        return yy_modelDescription()
    }
    
    /// 初始化方法,保存用户信息
    override init() {
        super.init()
        
        guard let filePath = accountFile.yw_appendDocumentDir(),
            let data = try? NSData(contentsOfFile: filePath, options: []),
            let dict = try? JSONSerialization.jsonObject(with: data as Data, options: []) as? [String : Any]
        else {
            return
        }
        
        yy_modelSet(with: dict ?? [:])
        
        print("保存用户信息 \(self)")
        
//        expiresDate = Date(timeIntervalSinceNow: -3600 * 24)
//        print(expiresDate ?? Date())
        // 判断账户是否过期
        if expiresDate?.compare(Date()) != .orderedDescending {
            print("账户过期~~~")
            
            access_token = nil
            uid = nil
            
            try? FileManager.default.removeItem(atPath: filePath)
        }
        print("账户正常~~~")
    }
    
    /// 保存用户信息
    func saveUseraccount() {
        
        var dict = self.yy_modelToJSONObject() as? [String : Any] ?? [:]
        
        dict.removeValue(forKey: "expires_in")
        
        guard let data = try? JSONSerialization.data(withJSONObject: dict, options: []),
            let filePath = accountFile.yw_appendDocumentDir()
            else {
                return
            }
        
        (data as NSData).write(toFile: filePath, atomically: true)
        
        print(filePath)
    }
    
}
