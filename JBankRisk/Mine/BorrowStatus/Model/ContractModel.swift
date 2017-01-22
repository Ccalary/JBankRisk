//
//  ContractModel.swift
//  JBankRisk
//
//  Created by caohouhong on 17/1/7.
//  Copyright © 2017年 jingjinsuo. All rights reserved.
//

import UIKit
import SwiftyJSON

struct ContractModel {

    //名字
    var name = ""
    //签署状态
    var status = ""
   
    init(json: JSON) {
        name = json["name"].stringValue
    }
    
}
