//
//  SFWBWelcomeView.swift
//  SFWBPro
//
//  Created by happy on 2018/4/13.
//  Copyright © 2018年 happy. All rights reserved.
//  欢迎页面

import UIKit
import SDWebImage

class SFWBWelcomeView: UIView {

    @IBOutlet weak var iconImgView: UIImageView!
    
    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var bottomCons: NSLayoutConstraint!
    
    class func welcomeView() -> SFWBWelcomeView {
        
        let nib = UINib(nibName: "SFWBWelcomeView", bundle: nil)
        
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! SFWBWelcomeView
        
        return v
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        print(iconImgView)
    }
    
    override func awakeFromNib() {
//        print(iconImgView)
        guard let iconStr = SFWBNetworkManager.share.userAccount.avatar_large,
            let iconUrl = URL.init(string: iconStr)
        else {
            return
        }
        
        iconImgView.sd_setImage(with: iconUrl, placeholderImage: UIImage.init(named: "avatar_default_big"), options: [], completed: nil)
        
//        iconImgView.layer.cornerRadius = iconImgView.yw_width * 0.5
//        iconImgView.layer.masksToBounds = true
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        layoutIfNeeded()
        
        bottomCons.constant = bounds.size.height - 240
        
        UIView.animate(withDuration: 3.0, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: {
            self.layoutIfNeeded()
        }) { (_) in
            UIView.animate(withDuration: 1.0, animations: {
                self.tipLabel.alpha = 1.0
            }, completion: { (_) in
                self.removeFromSuperview()
            })
            
        }
    }
    
}
