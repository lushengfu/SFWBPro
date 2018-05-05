//
//  SFWBStatusViewModel.swift
//  SFWBPro
//
//  Created by happy on 2018/4/19.
//  Copyright © 2018年 happy. All rights reserved.
//

import Foundation


/// 单条微博
class SFWBStatusViewModel: CustomStringConvertible {
    
    var status: SFWBStatus
    /// 会员等级
    var memberIcon: UIImage?
    /// 认证图标
    var vipIcon: UIImage?
    
    /// 转发字符串
    var retweetStr: String?
    
    /// 评论字符串
    var commentStr: String?
    
    /// 点赞字符串
    var likeStr: String?
    
    /// 被转发微博的正文
    var retweetedText: String?
    
    /// 行高
    var rowHeight: CGFloat = 0
    
    
    /// 有转发微博,就返回转发微博的图片, 否则返回原创微博的图片
    var picURLs: [SFWBStatusPicture]? {
        return status.retweeted_status?.pic_urls ?? status.pic_urls
    }
    
    
    /// 配图视图的size
    var pictureViewSize: CGSize = CGSize()
    
    
    /// 构造函数,保存模型
    init(model: SFWBStatus) {
        self.status = model
        
        // 设置会员等级
        guard let mbrank = model.user?.mbrank else {
            return
        }
        
        if mbrank > 0 && mbrank < 7 {
            let imageName = "common_icon_membership_level\(mbrank)"
            memberIcon = UIImage.init(named: imageName)
        }
        
        // 认证类型 , -1:没有认证, 0:认证用户, 2,3,5:企业认证, 220:达人
        switch model.user?.verified_type ?? -1 {
        case 0:
            vipIcon = UIImage.init(named: "avatar_vip")
        case 2, 3, 5:
            vipIcon = UIImage.init(named: "avatar_enterprise_vip")
        case 220:
            vipIcon = UIImage.init(named: "avatar_grassroot")
        default:
            vipIcon = nil
        }
        
        retweetStr = countString(count: model.reposts_count, defaultStr: "转发")
        commentStr = countString(count: model.comments_count, defaultStr: "评论")
        likeStr = countString(count: model.attitudes_count, defaultStr: "赞")
        
        pictureViewSize = calcPictureViewSize(count:picURLs?.count)
        

        retweetedText = "@" + (model.retweeted_status?.user?.screen_name ?? "") + ":"
        retweetedText = retweetedText! + (model.retweeted_status?.text ?? "")
        
        // 缓存行高
        updateRowHeight()
    }
    
    /// 计算cell 的行高
    func updateRowHeight() {
        //原创微博: 顶部视图高度(12) + 间距(12) + 图像高度(34) + 间距(12) + 正文高度(计算) + 配图视图高度 + 间距(12) + 底部视图高度(35)
        
        //被转发微博: 顶部视图高度(12) + 间距(12) + 图像高度(34) + 间距(12) + 正文高度(计算)  + 间距(12)*2 + 转发微博正文高度(计算) + 配图视图高度 + 间距(12) + 底部视图高度(35)
        
        let margin: CGFloat = 12
        let iconHeight: CGFloat = 34
        let toolbarHeight: CGFloat = 35
        
        var height: CGFloat = 0
        
        let textSize = CGSize(width: UIScreen.yw_screenWidth() - 2*margin, height: CGFloat(MAXFLOAT))
        let originFont = UIFont.systemFont(ofSize: 15)
        let retweetFont = UIFont.systemFont(ofSize: 14)
        
        height += margin * 2 + iconHeight + margin
        
        if let text = status.text {
            height += (text as NSString).boundingRect(with: textSize, options: [.usesLineFragmentOrigin], attributes: [NSAttributedStringKey.font : originFont], context: nil).height
        }
        
        if status.retweeted_status != nil {
            
            height += margin * 2
            
            if let text = retweetedText {
                height += (text as NSString).boundingRect(with: textSize, options: [.usesLineFragmentOrigin], attributes: [NSAttributedStringKey.font : retweetFont], context: nil).height
            }
            
        }
        
        height += pictureViewSize.height
        
        height += margin + toolbarHeight
        
        rowHeight = height
        
    }
    
    /// 更新单张图片视图的尺寸
    func updateSingleImage(image: UIImage) {
        var size = image.size
        size.height += SFWBStatusPictureViewOutterMargin
        
        pictureViewSize = size
        
        updateRowHeight()
    }
    
    /// 根据配图视图计算行高
    private func calcPictureViewSize(count: Int?) -> CGSize {
        
        if count == 0 || count == nil {
            return CGSize()
        }
        
        let row = (count! - 1)/3 + 1
        
        let pictureViewHeight = SFWBStatusPictureViewOutterMargin + CGFloat(row) * SFWBStatusPictureItemWidth + CGFloat(row - 1) * SFWBStatusPictureViewInnerMargin
        
        
        return CGSize(width: SFWBStatusPictureViewWidth, height: pictureViewHeight)
    }
    
    private func countString(count: Int, defaultStr: String) -> String {
        
        if count == 0 {
            return defaultStr
        }
        
        if count < 10000 {
            return "\(count)"
        }
        
        return String.init(format: "%.02f", Double(count) / 10000)
    }
    
    var description: String {
        return status.description
    }
}
