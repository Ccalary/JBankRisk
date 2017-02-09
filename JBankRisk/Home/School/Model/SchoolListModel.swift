//
//  SchoolListModel.swift
//  JBankRisk
//
//  Created by caohouhong on 17/2/6.
//  Copyright © 2017年 jingjinsuo. All rights reserved.
//

import UIKit
import ObjectMapper

class SchoolListModel: BaseResponseModel {

    /*
     "schoolCode"    学校列表
     **/
    
    var schoolCode: [SchoolModel] = []
    
    required init?(map: Map){
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        schoolCode <- map["schoolCode"]
    }
}
