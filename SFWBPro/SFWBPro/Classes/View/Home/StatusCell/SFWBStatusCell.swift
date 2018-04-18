//
//  SFWBStatusCell.swift
//  SFWBPro
//
//  Created by happy on 2018/4/18.
//  Copyright © 2018年 happy. All rights reserved.
//

import UIKit

class SFWBStatusCell: UITableViewCell {

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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
