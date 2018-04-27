//
//  SFWBHomeViewController.swift
//  SFWBPro
//
//  Created by happy on 2018/3/1.
//  Copyright © 2018年 happy. All rights reserved.
//

import UIKit

/// 原创微博的cell id
private let originalStatusCell = "originalStatusCell"
/// 被转发微博的cell id
private let retweetedStatusCell = "retweetedStatusCell"
/// 标题的图片和文本的间距
private let homeTitlePadding: CGFloat = 12.0

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
        navItem.rightBarButtonItem = nil
 
        tableView?.register(UINib(nibName: "SFWBStatusNormalCell", bundle: nil), forCellReuseIdentifier: originalStatusCell)
        tableView?.register(UINib(nibName: "SFWBStatusRetweetedCell", bundle: nil), forCellReuseIdentifier: retweetedStatusCell)
        
        tableView?.rowHeight = UITableViewAutomaticDimension
        tableView?.estimatedRowHeight = 300
        
        tableView?.separatorStyle = .none
        // 设置标题view
        setupTitleView()
    }
    
    fileprivate func setupTitleView() {
        
        var titleName = SFWBNetworkManager.share.userAccount.screen_name;
        if titleName == nil {
            titleName = "首页"
        }
        
        let titleBtn = UIButton.yw_textButton(titleName, fontSize: 17.0, normalColor: UIColor.darkGray, highlightedColor: UIColor.black)
        titleBtn?.setImage(UIImage.init(named: "navigationbar_arrow_down"), for: .normal)
        titleBtn?.setImage(UIImage.init(named: "navigationbar_arrow_up"), for: .selected)
        
        navItem.titleView = titleBtn
        
        titleBtn?.addTarget(self, action: #selector(titleClickBtn), for: .touchUpInside)
        
        titleBtn?.titleEdgeInsets = UIEdgeInsetsMake(0, -(((titleBtn?.imageView?.yw_width)! + homeTitlePadding)), 0, ((titleBtn?.imageView?.yw_width)! + homeTitlePadding))
        titleBtn?.imageEdgeInsets = UIEdgeInsetsMake(0, ((titleBtn?.titleLabel?.yw_width)! + homeTitlePadding), 0, -((titleBtn?.titleLabel?.yw_width)! + homeTitlePadding))
    }
    
    @objc fileprivate func titleClickBtn(btn: UIButton) {
        
        btn.isSelected = !btn.isSelected
        
    }
    
    override func loadData() {
        
        // 加载数据
        listViewModel.loadStatus(pullUp: self.isPullUp) { (isSuccess, shouldRefresh) in
            
            // 结束刷新
            self.refreshControl?.endRefreshing()
            // 上拉标记重置
            self.isPullUp = false
            
            if shouldRefresh {
                self.tableView?.reloadData()
            }
            
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
        let vm = listViewModel.statusList[indexPath.row]
        
        let cellId = (vm.status.retweeted_status != nil) ? retweetedStatusCell : originalStatusCell
        
        let sCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SFWBStatusCell
        
        
        sCell.viewModel = vm
        
        return sCell
    }
}
