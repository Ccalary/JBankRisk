//
//  HHRefreshNormalHeader.swift
//  JBankRisk
//
//  Created by chh on 2017/10/10.
//  Copyright © 2017年 jingjinsuo. All rights reserved.
//

import UIKit
import MJRefresh

class HHRefreshNormalHeader: MJRefreshNormalHeader {

    //重写方法
    override func prepare() {
        super.prepare()
        self.lastUpdatedTimeLabel.isHidden = true
        self.stateLabel.isHidden = true
    }
}
