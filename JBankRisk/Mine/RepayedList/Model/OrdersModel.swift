//
//  OrdersModel.swift
//  JBankRisk
//
//  Created by caohouhong on 17/1/17.
//  Copyright © 2017年 jingjinsuo. All rights reserved.
//

import UIKit
import ObjectMapper

class OrdersModel: Mappable {
 
    /*
      "orderId"        产品id
      "orderName"      产品名字
     **/
    var orderId: String = ""
    var orderName: String = ""
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map){
        orderId     <- map["orderId"]
        orderName   <- map["orderName"]
    }
    
}
