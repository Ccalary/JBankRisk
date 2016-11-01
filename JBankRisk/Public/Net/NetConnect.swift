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
    
    //基本参数
    static func getBaseRequestParams() -> Dictionary<String,Any>{
        var params = [String:Any]()
        params["companyId"] = "10000101"
        return params
    }
    
    
    /*************注册登录模块(RL)*************/
    /// 1.注册
    static func rl_register(parameters: Parameters,success:@escaping (_ response:[String:AnyObject]) -> (),failure:@escaping(_ error: Error) -> ()){
    
        NetworkRequest.sharedInstance.getRequest(urlString: RL_REGISTER_URL, params: parameters, success: { (response) in
            success(response)
        }, failture: { (error) in
            failure(error)
        })
   }
    
    /// 2.验证码
    static func rl_randomCode(parameters: Parameters,success:@escaping (_ response:[String:AnyObject]) -> (),failure:@escaping(_ error: Error) -> ()){
        
        NetworkRequest.sharedInstance.getRequest(urlString: RL_RANDOM_CODE_URL, params: parameters, success: { (response) in
            success(response)
        }, failture: { (error) in
            failure(error)
        })
    }
    
    /// 3.登录
    static func rl_normalLogin(parameters: Parameters,success:@escaping (_ response:[String:AnyObject]) -> (),failure:@escaping(_ error: Error) -> ()){
        
        NetworkRequest.sharedInstance.getRequest(urlString: RL_NORMAL_LOGIN_URL, params: parameters, success: { (response) in
            success(response)
        }, failture: { (error) in
            failure(error)
        })
    }
    
    /// 4.验证码登录
    static func rl_randomCodeLogin(parameters: Parameters,success:@escaping (_ response:[String:AnyObject]) -> (),failure:@escaping(_ error: Error) -> ()){
        
        NetworkRequest.sharedInstance.getRequest(urlString: RL_RANCODE_LOGIN_URL, params: parameters, success: { (response) in
            success(response)
        }, failture: { (error) in
            failure(error)
        })
    }
    
    /// 5.修改密码
    static func rl_changePsw(parameters: Parameters,success:@escaping (_ response:[String:AnyObject]) -> (),failure:@escaping(_ error: Error) -> ()){
        
        NetworkRequest.sharedInstance.getRequest(urlString: RL_CHANGE_PSW_URL, params: parameters, success: { (response) in
            success(response)
        }, failture: { (error) in
            failure(error)
        })
    }
}
