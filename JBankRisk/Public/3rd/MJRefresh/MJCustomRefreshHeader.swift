//
//  MJCustomRefreshHeader.swift
//  JBankRisk
//
//  Created by caohouhong on 16/12/8.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit
import MJRefresh

class MJCustomRefreshHeader: MJRefreshGifHeader {

    //重写方法
    override func prepare() {
        super.prepare()
        
        //隐藏时间
        self.lastUpdatedTimeLabel.isHidden = true
        
        //隐藏状态
        self.stateLabel.isHidden = true
        
         // 设置普通状态的动画图片
        var idleImages = Array<UIImage>()
        for i in 0...60 {
            if let image = UIImage(named: "dropdown_anim__000\(i)") {
            idleImages.append(image)
            }
        }
        
        self.setImages(idleImages, for: MJRefreshState.idle)
        
        // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
        
        var refreshingImages = Array<UIImage>()
        for i in 0...3 {
            if let image = UIImage(named: "dropdown_loading_0\(i)") {
                refreshingImages.append(image)
            }
        }
        self.setImages(refreshingImages, for: MJRefreshState.pulling)
        self.setImages(refreshingImages, for: MJRefreshState.refreshing)
    }
}
