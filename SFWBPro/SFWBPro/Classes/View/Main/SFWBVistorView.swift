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
    fileprivate lazy var tipLabel : UILabel = UILabel.yw_label(
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
        
        // 添加子视图
        addSubview(iconView)
        addSubview(houseIconView)
        tipLabel.textAlignment = .center
        addSubview(tipLabel)
        addSubview(registerButton)
        addSubview(loginButton)
        
        for v in subviews {
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        // 添加原生自动布局
        // iconView
        addConstraint(NSLayoutConstraint(
            item: iconView,
            attribute: .centerX,
            relatedBy: NSLayoutRelation.equal,
            toItem: self,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0))
        addConstraint(NSLayoutConstraint(
            item: iconView,
            attribute: .centerY,
            relatedBy: NSLayoutRelation.equal,
            toItem: self,
            attribute: .centerY,
            multiplier: 1.0,
            constant: -60))
        
        // houseIconView
        addConstraint(NSLayoutConstraint(
            item: houseIconView,
            attribute: .centerX,
            relatedBy: NSLayoutRelation.equal,
            toItem: iconView,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0))
        addConstraint(NSLayoutConstraint(
            item: houseIconView,
            attribute: .centerY,
            relatedBy: NSLayoutRelation.equal,
            toItem: iconView,
            attribute: .centerY,
            multiplier: 1.0,
            constant: 0))
        
        
        let margin : CGFloat = 20.0
        
        // tiplabel
        addConstraint(NSLayoutConstraint(item: tipLabel,
                                         attribute: .centerX,
                                         relatedBy: NSLayoutRelation.equal,
                                         toItem: self,
                                         attribute: .centerX,
                                         multiplier: 1.0,
                                         constant: 0))
        
        addConstraint(NSLayoutConstraint(item: tipLabel,
                                         attribute: .top,
                                         relatedBy: NSLayoutRelation.equal,
                                         toItem: iconView,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: margin))
        
        addConstraint(NSLayoutConstraint(item: tipLabel,
                                         attribute: .width,
                                         relatedBy: NSLayoutRelation.equal,
                                         toItem: nil,
                                         attribute: NSLayoutAttribute.notAnAttribute,
                                         multiplier: 0,
                                         constant: 236))
        
        // 注册按钮
        addConstraint(NSLayoutConstraint(item: registerButton,
                                         attribute: .left,
                                         relatedBy: NSLayoutRelation.equal,
                                         toItem: tipLabel,
                                         attribute: .left,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: registerButton,
                                         attribute: .top,
                                         relatedBy: NSLayoutRelation.equal,
                                         toItem: tipLabel,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: margin))
        addConstraint(NSLayoutConstraint(item: registerButton,
                                         attribute: .width,
                                         relatedBy: NSLayoutRelation.equal,
                                         toItem: nil,
                                         attribute: NSLayoutAttribute.notAnAttribute,
                                         multiplier: 0,
                                         constant: 100))
        // 登录按钮
        addConstraint(NSLayoutConstraint(item: loginButton,
                                         attribute: .right,
                                         relatedBy: NSLayoutRelation.equal,
                                         toItem: tipLabel,
                                         attribute: .right,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: loginButton,
                                         attribute: .top,
                                         relatedBy: NSLayoutRelation.equal,
                                         toItem: tipLabel,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: margin))
        addConstraint(NSLayoutConstraint(item: loginButton,
                                         attribute: .width,
                                         relatedBy: NSLayoutRelation.equal,
                                         toItem: nil,
                                         attribute: NSLayoutAttribute.notAnAttribute,
                                         multiplier: 0,
                                         constant: 100))
    }
    
}
