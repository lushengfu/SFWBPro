//
//  SFWBHomeViewController.swift
//  SFWBPro
//
//  Created by happy on 2018/3/1.
//  Copyright © 2018年 happy. All rights reserved.
//

import UIKit

private let statusCell = "statusCell"

class SFWBHomeViewController: SFWBBaseViewController {

    // 微博数据源
    fileprivate lazy var statusList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @objc fileprivate func showFriends() {
        print(#function)
        
        let vc = SFWBDemoViewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    // 重写UI设置
    override func setupUI() {
        super.setupUI()
        
        navItem.leftBarButtonItem = UIBarButtonItem.init(title: "好友", target: self, selector: #selector(showFriends))
        
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: statusCell)
    }
    
    override func loadData() {
        for i in 0..<15 {
            statusList.insert(i.description, at: 0)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension SFWBHomeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sCell = tableView.dequeueReusableCell(withIdentifier: statusCell, for: indexPath)
        
        sCell.textLabel?.text = statusList[indexPath.row]
        sCell.contentView.backgroundColor = UIColor.yw_random()
        
        return sCell
    }
}
