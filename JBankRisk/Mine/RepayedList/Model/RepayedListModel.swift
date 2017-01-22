//
//  RepayedListModel.swift
//  JBankRisk
//
//  Created by caohouhong on 17/1/17.
//  Copyright © 2017年 jingjinsuo. All rights reserved.
//

import UIKit
import ObjectMapper

class RepayedListModel: Mappable {

    //名字
    var orderName: String = ""
    //日期
    var realpayDate: String = ""
    //钱数
    var pay_amt_total: Double = 0.00
    //产品id
    var orderId: Int = 0
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        orderName       <- map["orderName"]
        realpayDate     <- map["realpayDate"]
        pay_amt_total   <- map["pay_amt_total"]
        orderId         <- map["orderId"]
    }

}
