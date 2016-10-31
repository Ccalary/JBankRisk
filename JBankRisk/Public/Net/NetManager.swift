//
//  NetManager.swift
//  JBankRisk
//
//  Created by 曹后红 on 16/10/15.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetManager {

    /// 网络请求get
    ///
    /// - Parameters:
    ///   - url: 网络地址
    ///   - parameters: 参数
    static func doGetWithUrl(_ url: URLConvertible, parameters: Parameters?, finished:@escaping (_ response:Any?, _ error: Error?) -> Void){
    
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result{
            case .success(let value):
              finished(value as Any?, nil)
                let json = JSON(value)
                PrintLog(json)
            case .failure(let error):
                PrintLog(error)
              finished(nil, error)
            }
        }
    }
    
    /// 网络请求post
    ///
    /// - Parameters:
    ///   - url: 网络地址
    ///   - parameters: 参数
    static func doPostWithUrl(_ url: URLConvertible, parameters: Parameters?, finished:@escaping (_ response:AnyObject?, _ error: Error?) -> ()){
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result{
            case .success(let value):
                finished(response as AnyObject?, nil)
                let json = JSON(value)
                PrintLog(json)
            case .failure(let error):
                PrintLog(error)
                finished(nil, error)
            }
        }
    }

    
}
