//
//  NetConnect.swift
//  JBankRisk
//
//  Created by caohouhong on 16/10/31.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit
import Alamofire

class NetConnect {
    /*************注册登录模块(RL)*************/
    /// 1.注册
    static func rl_register(parameters: Parameters?,finished:@escaping (_ response:Any?) -> ()){
    
        NetManager.doGetWithUrl(RL_REGISTER_URL, parameters: parameters, finished:{
            (response,error) in
            if let response = response {
                finished(response)
            }else if let error = error {
                finished(error as Any?)
            }
            
        })
    }
}
