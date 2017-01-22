//
//  BaseResponseModel.swift
//  JBankRisk
//
//  Created by caohouhong on 17/1/17.
//  Copyright © 2017年 jingjinsuo. All rights reserved.
//  基本的Model(父类)

import UIKit
import ObjectMapper

class BaseResponseModel: Mappable {
    
    /*
     "RET_CODE" 状态码  “000000”为成功
     "RET_DESC" 返回描述
     **/
    
    var RET_CODE: String?
    var RET_DESC: String = ""
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        RET_CODE <- map["RET_CODE"]
        RET_DESC <- map["RET_DESC"]
    }
    
    func isSuccess() -> Bool {
        if let retCode = RET_CODE{
            if retCode == "000000"{
                return true
            }else{
                return false
            }
        }else{
            return false
        }
    }
}
