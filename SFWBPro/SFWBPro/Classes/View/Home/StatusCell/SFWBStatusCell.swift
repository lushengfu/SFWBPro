//
//  SFWBStatusCell.swift
//  SFWBPro
//
//  Created by happy on 2018/4/18.
//  Copyright © 2018年 happy. All rights reserved.
//

import UIKit

class SFWBStatusCell: UITableViewCell {
    
    var viewModel: SFWBStatusViewModel? {
        didSet {
            contentLabel.text = viewModel?.status.text
            nameLabel.text = viewModel?.status.user?.screen_name
            /// 会员等级
            memberImgView.image = viewModel?.memberIcon
            /// 认证等级
            vipImgView.image = viewModel?.vipIcon
            /// 用户图标设置
            iconImgView.sf_setImage(urlStr: viewModel?.status.user?.profile_image_url, placeholderImage: UIImage.init(named: "avatar_default_big"), isAvatar: true)
            
            statusToolBar.viewModel = viewModel
            
//            statusPictureView.pictureHeightCons.constant = 100
//
//            print(viewModel?.status.pic_urls ?? [])
            
            statusPictureView.pictureHeightCons.constant = viewModel?.pictureViewSize.height ?? 0
            
            statusPictureView.urls = viewModel?.status.pic_urls
        }
    }
    

    /// 用户图标
    @IBOutlet weak var iconImgView: UIImageView!
    
    /// 用户名
    @IBOutlet weak var nameLabel: UILabel!
    
    /// 会员图标
    @IBOutlet weak var memberImgView: UIImageView!
    
    /// 时间label
    @IBOutlet weak var timeLabel: UILabel!
    
    /// 来源label
    @IBOutlet weak var sourceLabel: UILabel!
    
    /// 认证等级
    @IBOutlet weak var vipImgView: UIImageView!
    
    /// 正文图标
    @IBOutlet weak var contentLabel: UILabel!
    
    /// 底部工具栏
    @IBOutlet weak var statusToolBar: SFWBStatusToolBar!
    
    /// 配图视图
    @IBOutlet weak var statusPictureView: SFWBStatusPictureView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
