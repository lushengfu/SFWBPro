//
//  UIImageViwe+WebImage.swift
//  SFWBPro
//
//  Created by happy on 2018/4/20.
//  Copyright © 2018年 happy. All rights reserved.
//

import SDWebImage

extension UIImageView {
    
    /// 隔离SDWebImage
    ///
    /// - Parameters:
    ///   - urlStr: 网络图片url路径
    ///   - placeholderImage: 占位图
    ///   - isAvatar: 是否设置圆角
    func sf_setImage(urlStr: String?, placeholderImage: UIImage?, isAvatar: Bool) {
        
        guard let urlString = urlStr,
            let Url = URL.init(string: urlString)
            else {
                image = placeholderImage
                return
        }
        
        sd_setImage(with: Url, placeholderImage: placeholderImage, options: [], progress: nil) { [weak self](image, _, _, _) in
            
            if isAvatar {
                self?.image = image?.sf_avatarImage(size: self?.bounds.size)
            }
            
        }
        
    }
    
    
}
