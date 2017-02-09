//
//  SchoolModel.swift
//  JBankRisk
//
//  Created by caohouhong on 17/2/6.
//  Copyright © 2017年 jingjinsuo. All rights reserved.
//

import UIKit
import ObjectMapper

class SchoolModel: Mappable {

    /*
     "school_code"      学校代码
     "school_name"      学校名字
     **/
    var school_code: String = ""
    var school_name: String = ""
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map){
        school_code     <- map["school_code"]
        school_name   <- map["school_name"]
    }

}
