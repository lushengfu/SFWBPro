//
//  SFWBBaseViewController.swift
//  SFWBPro
//
//  Created by happy on 2018/3/1.
//  Copyright © 2018年 happy. All rights reserved.
//

import UIKit

class SFWBBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // UI设置
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = UIColor.yw_random()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension SFWBBaseViewController {
    
    
    
}
