//
//  SFWBStatusPictureView.swift
//  SFWBPro
//
//  Created by happy on 2018/4/21.
//  Copyright © 2018年 happy. All rights reserved.
//

import UIKit

class SFWBStatusPictureView: UIView {
    
    var viewModel: SFWBStatusViewModel? {
        didSet {
            calcViewSize()
        }
    }
    
    private func calcViewSize() {
        
        if viewModel?.picURLs?.count == 1 {
            // 单张图片imageView的frame
            let viewSize = viewModel?.pictureViewSize ?? CGSize()
            
            let iv = subviews[0]
            iv.frame = CGRect(x: 0,
                              y: SFWBStatusPictureViewOutterMargin,
                              width: viewSize.width,
                              height: viewSize.height - SFWBStatusPictureViewOutterMargin)
            
            
        } else {
            let iv = subviews[0]
            iv.frame = CGRect(x: 0,
                              y: SFWBStatusPictureViewOutterMargin,
                              width: SFWBStatusPictureItemWidth,
                              height: SFWBStatusPictureItemWidth)
        }
        
        pictureHeightCons.constant = viewModel?.pictureViewSize.height ?? 0
    }
    
    var urls: [SFWBStatusPicture]? {
        didSet {
            
            for v in subviews {
                v.isHidden = true
            }
            
            var index = 0
            for url in urls ?? [] {
                
                let iv = subviews[index] as! UIImageView
                
                // 处理四张图需要处理的计算
                if index == 1 && urls?.count == 4 {
                    index += 1
                }
                
                iv.sf_setImage(urlStr: url.thumbnail_pic, placeholderImage: nil, isAvatar: false)
                
                iv.isHidden = false
                
                index += 1
            }
            
        }
    }
    
    

    @IBOutlet weak var pictureHeightCons: NSLayoutConstraint!
    
    override func awakeFromNib() {
        setupUI()
    }
    
}

extension SFWBStatusPictureView {
    
    
    fileprivate func setupUI() {
        
        backgroundColor = superview?.backgroundColor
        
        clipsToBounds = true
        
        let count = 3
        
        let rect = CGRect(x: 0,
                          y: SFWBStatusPictureViewOutterMargin,
                          width: SFWBStatusPictureItemWidth,
                          height: SFWBStatusPictureItemWidth)
        
        
        for i in 0..<count * count {
            let iv = UIImageView()
            
//            iv.backgroundColor = UIColor.red;
            iv.contentMode = .scaleAspectFill
            iv.clipsToBounds = true
            
            let row = CGFloat(i/count)
            let cal = CGFloat(i%count)
            
            let offsetX = cal * (SFWBStatusPictureItemWidth + SFWBStatusPictureViewInnerMargin)
            let offsetY = row * (SFWBStatusPictureItemWidth + SFWBStatusPictureViewInnerMargin)
            
            iv.frame = rect.offsetBy(dx: offsetX, dy: offsetY)
            
            addSubview(iv)
        }
        
        
    }
    
}
