//
//  SFWBCommon.swift
//  SFWBPro
//
//  Created by happy on 2018/4/8.
//  Copyright © 2018年 happy. All rights reserved.
//

import Foundation

// MARK: 应用程序相关信息
let SFWBAppKey = "2289389798"

let SFWBAppSecret = "b2f9c34ca4223381b7dc147e7e7cdbeb"
/// 微博重定向地址
let SFWBRedirectURL = "http://baidu.com"

/// 用户登录的通知
let SFWBUserLoginNotification = "SFWBUserLoginNotification"

/// 用户登录成功的通知
let SFWBUserLoginSuccessNotification = "SFWBUserLoginSuccessNotification"

// MARK: 微博配图设置参数
/// 配图外边距
let SFWBStatusPictureViewOutterMargin = CGFloat(12)
/// 配图内边距
let SFWBStatusPictureViewInnerMargin = CGFloat(3)
/// 微博配图的宽度
let SFWBStatusPictureViewWidth = UIScreen.yw_screenWidth() - 2 * SFWBStatusPictureViewOutterMargin;
/// 配图的单个图片的宽高
let SFWBStatusPictureItemWidth = (SFWBStatusPictureViewWidth - 2 * SFWBStatusPictureViewInnerMargin)/3.0


