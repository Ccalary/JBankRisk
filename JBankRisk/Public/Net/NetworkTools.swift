//
//  NetworkTools.swift
//  JBankRisk
//
//  Created by caohouhong on 17/1/17.
//  Copyright © 2017年 jingjinsuo. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import AlamofireObjectMapper

private let NetworkToolsShareInstance = NetworkTools()

class NetworkTools {
    class var sharedInstance : NetworkTools {
        return NetworkToolsShareInstance
    }
}

/*
   MVC使用，暂时先改的都放在了这里
 */
extension NetworkTools {
    
    /*
        已还明细
     **/
    //参数的finished闭包被使用了，而使用的环境又是一个闭包，则需要加@escaping
    func repayListDetail(parameters : [String : Any]? = nil, finished :  @escaping (_ result : RepayedList?, _ error: Error?) -> ()) {
        
        Alamofire.request(PC_REPAY_LIST_DETAIL, method: HTTPMethod.get, parameters: parameters).responseObject { (response: DataResponse<RepayedList>) in
            
            let repayBillResponse = response.result.value
            let json = JSON(data: response.data!)
            PrintLog(json)
            
            if let repayBillResponse = repayBillResponse {
                finished(repayBillResponse, nil)
            }else {
                finished(nil,response.result.error)
            }
        }
    }

}
