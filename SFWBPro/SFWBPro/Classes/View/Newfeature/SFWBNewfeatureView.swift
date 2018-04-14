//
//  SFWBNewfeatureView.swift
//  SFWBPro
//
//  Created by happy on 2018/4/13.
//  Copyright © 2018年 happy. All rights reserved.
//  新特性页面

import UIKit

/// 设置新特性的图片的张数
fileprivate let imageCount = 4

class SFWBNewfeatureView: UIView {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var enterButton: UIButton!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBAction func enterClickButton() {
        
        removeFromSuperview()
    }
    
    class func newfeatureView() -> SFWBNewfeatureView {
        
        let nib = UINib(nibName: "SFWBNewfeatureView", bundle: nil)
        
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! SFWBNewfeatureView
        
        return v
    }
    
    override func awakeFromNib() {
//        print(bounds)
        
        let rect = UIScreen.main.bounds
        for i in 0..<imageCount {
            
            let imageName = "new_feature_\(i + 1)"
            
            let imgView = UIImageView(image: UIImage.init(named: imageName))
            
            imgView.frame = rect.offsetBy(dx: CGFloat(i) * rect.width, dy: 0)
            
            scrollView.addSubview(imgView)
        }
        
        scrollView.contentSize = CGSize(width: CGFloat(imageCount + 1) * rect.width, height: rect.height)
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        
        enterButton.isHidden = true
    }

}

// MARK: - UIScrollViewDelegate
extension SFWBNewfeatureView: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let page = Int(scrollView.contentOffset.x/scrollView.bounds.width)
       
        if page == imageCount {
            removeFromSuperview()
        }

        enterButton.isHidden = (page != imageCount - 1)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        enterButton.isHidden = true
        
        let page = Int(scrollView.contentOffset.x/scrollView.bounds.width + 0.5)
        
        pageControl.currentPage = page
        
        pageControl.isHidden = (page == imageCount)
    }
    
}
