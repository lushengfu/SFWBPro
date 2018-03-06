//
//  SFWBVistorView.swift
//  SFWBPro
//
//  Created by happy on 2018/3/6.
//  Copyright © 2018年 happy. All rights reserved.
//  访客视图

import UIKit

class SFWBVistorView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: 添加私有控件
    // 图像视图
    fileprivate lazy var iconView : UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    // 小房子
    fileprivate lazy var houseIconView : UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
    // label文字说明
    fileprivate lazy var textLabel = UILabel.yw_label(
        withText: "关注一下人,看看这里有什么新鲜事或者新鲜人的! 加油💪⛽️",
        fontSize: 14,
        color: UIColor.darkGray)
    
    // 注册按钮
    fileprivate lazy var registerButton : UIButton = UIButton.yw_textButton(
        "注册",
        fontSize: 16,
        normalColor: UIColor.orange,
        highlightedColor: UIColor.darkGray,
        backgroundImageName: "common_button_white_disable")
    // 登录按钮
    fileprivate lazy var loginButton : UIButton = UIButton.yw_textButton(
        "登录",
        fontSize: 16,
        normalColor: UIColor.gray,
        highlightedColor: UIColor.darkGray,
        backgroundImageName: "common_button_white_disable")
}

extension SFWBVistorView {
    
    fileprivate func setupUI() {
        backgroundColor = UIColor.white
    }
    
}
