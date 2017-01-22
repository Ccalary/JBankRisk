//
//  RepayedList.swift
//  JBankRisk
//
//  Created by caohouhong on 17/1/17.
//  Copyright © 2017年 jingjinsuo. All rights reserved.
//

import UIKit
import ObjectMapper

class RepayedList: BaseResponseModel {
    
    /*
      "orders"      筛选的列表
      "areadyList"  已还列表
     **/
    
    var orders: [OrdersModel] = []
    var areadyList: [RepayedListModel] = []
    
    
    required init?(map: Map){
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        orders <- map["orders"]
        areadyList <- map["areadyList"]
    }
}
