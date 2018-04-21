//
//  SFWBStatusToolBar.swift
//  SFWBPro
//
//  Created by happy on 2018/4/21.
//  Copyright © 2018年 happy. All rights reserved.
//

import UIKit

class SFWBStatusToolBar: UIView {
    
    var viewModel: SFWBStatusViewModel? {
        didSet {
            
            retweetButton.setTitle(viewModel?.retweetStr, for: .normal)
            commentButton.setTitle(viewModel?.commentStr, for: .normal)
            likeButton.setTitle(viewModel?.likeStr, for: .normal)
        }
    }
    

    /// 转发按钮
    @IBOutlet weak var retweetButton: UIButton!
    
    @IBOutlet weak var commentButton: UIButton!

    @IBOutlet weak var likeButton: UIButton!
}
