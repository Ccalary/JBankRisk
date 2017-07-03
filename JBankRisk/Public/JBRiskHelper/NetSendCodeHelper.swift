//
//  NetSendCodeHelper.swift
//  JBankRisk
//
//  Created by caohouhong on 17/6/15.
//  Copyright © 2017年 jingjinsuo. All rights reserved.
//

import UIKit
import SwiftyJSON

class NetSendCodeHelper {
    
   //将发送验证码的网络请求单独拿出来，错误信息通过闭包返回
   static func sendCodeToNumber(_ number: String,_ block: @escaping (_ desc: String)->() ){
        var params = NetConnect.getBaseRequestParams()
        params["mobile"] = number
        NetConnect.rl_randomCode(parameters: params, success:
            { response in
                let json = JSON(response)
                guard json["RET_CODE"] == "000000" else{
                  return  block(json["RET_DESC"].stringValue)
                }
        }, failure: {error in
        })
    }
}
