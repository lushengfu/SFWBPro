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
    fileprivate lazy var listViewModel = SFWBStatusListViewModel()
    
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
    override func setupTableView() {
        super.setupTableView()
        
        navItem.leftBarButtonItem = UIBarButtonItem.init(title: "好友", target: self, selector: #selector(showFriends))
        
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: statusCell)
    }
    
    override func loadData() {
        
        // 加载数据
        listViewModel.loadStatus { (isSuccess) in
            
            self.tableView?.reloadData()
            // 结束刷新
            self.refreshControl?.endRefreshing()
            // 上拉标记重置
            self.isPullUp = false
            
        }
        // 模拟数据延迟加载
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


extension SFWBHomeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.statusList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sCell = tableView.dequeueReusableCell(withIdentifier: statusCell, for: indexPath)
        
        sCell.textLabel?.text = listViewModel.statusList[indexPath.row].text
        sCell.contentView.backgroundColor = UIColor.yw_random()
        
        return sCell
    }
}
