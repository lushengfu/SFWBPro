//
//  SFWBStatusListViewModel.swift
//  SFWBPro
//
//  Created by happy on 2018/3/14.
//  Copyright © 2018年 happy. All rights reserved.
//

import Foundation
import SDWebImage

/// 上拉刷新错误的最大次数
private let maxPullupTryTimes = 3

class SFWBStatusListViewModel {
    
    /// 微博数据源
    lazy var statusList = [SFWBStatusViewModel]()
    /// 记录上拉刷新的错误次数
    private var pullupErrorTimes = 0
    /// 加载微博数据
    ///
    /// - Parameter complition: 完成回调
    func loadStatus(pullUp: Bool, complition: @escaping (_ isSuccess : Bool, _ shouldRefresh : Bool)->()) {
        
        if pullUp && pullupErrorTimes > maxPullupTryTimes {
            complition(true, false)
            return
        }
        
        let since_id : Int64 = pullUp ? 0 : (statusList.first?.status.id ?? 0)
        let max_id : Int64 = !pullUp ? 0 : (statusList.last?.status.id ?? 0)
        
        SFWBNetworkManager.share.statusList(since_id: since_id, max_id: max_id) { (list, isSuccess) in
            
            print("\(String(describing: list))");
            
            if !isSuccess {
                complition(false, false)
                return
            }
            
            var array = [SFWBStatusViewModel]()
            
            for dict in list ?? [] {
                guard let status = SFWBStatus.yy_model(with: dict) else {
                    continue
                }

                array.append(SFWBStatusViewModel.init(model: status))
                
//                print(status.pic_urls ?? [])
            }
            
//            print(array)
//            guard let array = NSArray.yy_modelArray(with: SFWBStatus.self, json: list ?? []) as? [SFWBStatus] else {
//                complition(isSuccess, false)
//                return
//            }
            
            if pullUp {
                self.statusList += array // 上拉加载
            }
            else {
                self.statusList = array + self.statusList // 下拉刷新
            }
            
            if pullUp && array.count == 0 {
                
                self.pullupErrorTimes += 1
                complition(isSuccess, false)
            } else {
                
                self.cacheSingleImage(list: array, finished: complition)
                
//                complition(isSuccess, true)
            }
            
            
        }
        
    }
    
    /// 缓存单张图片
    private func cacheSingleImage(list: [SFWBStatusViewModel], finished: @escaping (_ isSuccess: Bool, _ shouldRefrsh: Bool)->()) {
        
        var lenght = 0
        
        let group = DispatchGroup()
        
        for vm in list {
            
            if vm.picURLs?.count != 1 {
                continue
            }
            
            guard let picStr = vm.picURLs![0].thumbnail_pic,
                let picURL = URL.init(string: picStr) else {
                    continue
            }
            
            print(" 要缓存的 URL 是 \(picURL) ")
            group.enter()
            SDWebImageManager.shared().imageDownloader?.downloadImage(with: picURL, options: [], progress: nil, completed: { (image, _, _, _) in

                if let image = image,
                    let data = UIImagePNGRepresentation(image)
                {
                    lenght = data.count
                    
                    vm.updateSingleImage(image: image)
                }
                
                print(" 要缓存的 image 是 \(String(describing: image)) 长度 \(lenght)")
                group.leave()
            })
            
        }
        
        group.notify(queue: DispatchQueue.main) {
            print(" 所有缓存的 image  长度 \(lenght / 1024) k")
            
            finished(true, true)
        }
        
    }
    
}
