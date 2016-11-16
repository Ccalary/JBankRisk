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
        params["userId"] = UserHelper.getUserId() ?? ""
        params["channelId"] = "3" // iOS-3,android-4
        return params
    }
    
    
    /*************注册登录模块(RL)*************/
    /// 1.1注册
    static func rl_register(parameters: Parameters,success:@escaping (_ response:[String:AnyObject]) -> (),failure:@escaping(_ error: Error) -> ()){
    
        NetworkRequest.sharedInstance.getRequest(urlString: RL_REGISTER_URL, params: parameters, success: { (response) in
            success(response)
        }, failture: { (error) in
            failure(error)
        })
   }
    
    /// 1.2验证码
    static func rl_randomCode(parameters: Parameters,success:@escaping (_ response:[String:AnyObject]) -> (),failure:@escaping(_ error: Error) -> ()){
        
        NetworkRequest.sharedInstance.getRequest(urlString: RL_RANDOM_CODE_URL, params: parameters, success: { (response) in
            success(response)
        }, failture: { (error) in
            failure(error)
        })
    }
    
    /// 1.3登录
    static func rl_normalLogin(parameters: Parameters,success:@escaping (_ response:[String:AnyObject]) -> (),failure:@escaping(_ error: Error) -> ()){
        
        NetworkRequest.sharedInstance.getRequest(urlString: RL_NORMAL_LOGIN_URL, params: parameters, success: { (response) in
            success(response)
        }, failture: { (error) in
            failure(error)
        })
    }
    
    /// 1.4验证码登录
    static func rl_randomCodeLogin(parameters: Parameters,success:@escaping (_ response:[String:AnyObject]) -> (),failure:@escaping(_ error: Error) -> ()){
        
        NetworkRequest.sharedInstance.getRequest(urlString: RL_RANCODE_LOGIN_URL, params: parameters, success: { (response) in
            success(response)
        }, failture: { (error) in
            failure(error)
        })
    }
    
    /// 1.5修改密码
    static func rl_changePsw(parameters: Parameters,success:@escaping (_ response:[String:AnyObject]) -> (),failure:@escaping(_ error: Error) -> ()){
        
        NetworkRequest.sharedInstance.getRequest(urlString: RL_CHANGE_PSW_URL, params: parameters, success: { (response) in
            success(response)
        }, failture: { (error) in
            failure(error)
        })
    }
    
   /******************借款流程模块(BM)*********************/
    
    /// 2.1首页
    static func bm_home_url(parameters: Parameters,success:@escaping (_ response:[String:AnyObject]) -> (),failure:@escaping(_ error: Error) -> ()){
        
        NetworkRequest.sharedInstance.getRequest(urlString: BM_HOME_URL, params: parameters, success: { (response) in
            success(response)
        }, failture: { (error) in
            failure(error)
        })
    }
    
    ///2.2表明身份信息上传
    static func bm_upload_identity_info(parameters: Parameters,success:@escaping (_ response:[String:AnyObject]) -> (),failure:@escaping(_ error: Error) -> ()){
        
        NetworkRequest.sharedInstance.postRequest(urlString: BM_IDENTITY_UPLOAD, params: parameters, success: { (response) in
            success(response)
        }, failture: { (error) in
            failure(error)
        })
    }
    
    ///2.3产品信息上传
    static func bm_upload_product_info(parameters: Parameters,success:@escaping (_ response:[String:AnyObject]) -> (),failure:@escaping(_ error: Error) -> ()){
        
        NetworkRequest.sharedInstance.postRequest(urlString: BM_PRODUCT_UPLOAD, params: parameters, success: { (response) in
            success(response)
        }, failture: { (error) in
            failure(error)
        })
    }

    /// 2.4获取商户地址
    static func bm_get_sale_address(parameters: Parameters,success:@escaping (_ response:[String:AnyObject]) -> (),failure:@escaping(_ error: Error) -> ()){
        
        NetworkRequest.sharedInstance.getRequest(urlString: BM_GET_SALE_ADDRESS, params: parameters, success: { (response) in
            success(response)
        }, failture: { (error) in
            failure(error)
        })
    }

    ///2.5学校信息上传
    static func bm_upload_school_info(parameters: Parameters,success:@escaping (_ response:[String:AnyObject]) -> (),failure:@escaping(_ error: Error) -> ()){
        
        NetworkRequest.sharedInstance.postRequest(urlString: BM_SCHOOL_UPLOAD, params: parameters, success: { (response) in
            success(response)
        }, failture: { (error) in
            failure(error)
        })
    }

    /// 2.6获取学校名称
    static func bm_get_school_name(parameters: Parameters,success:@escaping (_ response:[String:AnyObject]) -> (),failure:@escaping(_ error: Error) -> ()){
        
        NetworkRequest.sharedInstance.postRequest(urlString: BM_GET_SCHOOL_NAME, params: parameters, success: { (response) in
            success(response)
        }, failture: { (error) in
            failure(error)
        })
    }
    
    /// 2.7申请借款期限
    static func bm_applyPeriod(parameters: Parameters,success:@escaping (_ response:[String:AnyObject]) -> (),failure:@escaping(_ error: Error) -> ()){
        
        NetworkRequest.sharedInstance.getRequest(urlString: BM_APPLY_PERIOD_URL, params: parameters, success: { (response) in
            success(response)
        }, failture: { (error) in
            failure(error)
        })
    }
    
    /// 2.8计算还款金额
    static func bm_count_repayment(parameters: Parameters,success:@escaping (_ response:[String:AnyObject]) -> (),failure:@escaping(_ error: Error) -> ()){
        
        NetworkRequest.sharedInstance.getRequest(urlString: BM_COUNT_REPAYMENT_URL, params: parameters, success: { (response) in
            success(response)
        }, failture: { (error) in
            failure(error)
        })
    }

    /// 2.9职业信息上传
    static func bm_upload_work_info(parameters: Parameters,success:@escaping (_ response:[String:AnyObject]) -> (),failure:@escaping(_ error: Error) -> ()){
        
        NetworkRequest.sharedInstance.postRequest(urlString: BM_WORK_UPLOAD, params: parameters, success: { (response) in
            success(response)
        }, failture: { (error) in
            failure(error)
        })
    }
    
    /// 2.10联系信息上传
    static func bm_upload_contact_info(parameters: Parameters,success:@escaping (_ response:[String:AnyObject]) -> (),failure:@escaping(_ error: Error) -> ()){
        
        NetworkRequest.sharedInstance.postRequest(urlString: BM_CONTACT_UPLOAD, params: parameters, success: { (response) in
            success(response)
        }, failture: { (error) in
            failure(error)
        })
    }

    /// 2.11照片信息上传
    static func bm_upload_photo_info(params:[String: String], data: [Data], name: [String],success:@escaping (_ response:[String:AnyObject]) -> (),failure:@escaping(_ error: Error) -> ()){
        
        NetworkRequest.sharedInstance.upLoadImageRequest(urlString: BM_PHOTO_UPLOAD,params:params, data: data, name: name, success: { (response) in
            success(response)
        }, failture: { (error) in
            failure(error)
        })
    }
    
    /// 2.12获得身份信息
    static func bm_get_identity_info(parameters: Parameters,success:@escaping (_ response:[String:AnyObject]) -> (),failure:@escaping(_ error: Error) -> ()){
        
        NetworkRequest.sharedInstance.getRequest(urlString: BM_GET_IDENTITY_INFO, params: parameters, success: { (response) in
            success(response)
        }, failture: { (error) in
            failure(error)
        })
    }
    
    /// 2.13获得产品信息
    static func bm_get_product_info(parameters: Parameters,success:@escaping (_ response:[String:AnyObject]) -> (),failure:@escaping(_ error: Error) -> ()){
        
        NetworkRequest.sharedInstance.getRequest(urlString: BM_GET_PRODUCT_INFO, params: parameters, success: { (response) in
            success(response)
        }, failture: { (error) in
            failure(error)
        })
    }
    
    /// 2.14获得工作信息
    static func bm_get_work_info(parameters: Parameters,success:@escaping (_ response:[String:AnyObject]) -> (),failure:@escaping(_ error: Error) -> ()){
        
        NetworkRequest.sharedInstance.getRequest(urlString: BM_GET_WORK_INFO, params: parameters, success: { (response) in
            success(response)
        }, failture: { (error) in
            failure(error)
        })
    }
    
    /// 2.15获得学校信息
    static func bm_get_school_info(parameters: Parameters,success:@escaping (_ response:[String:AnyObject]) -> (),failure:@escaping(_ error: Error) -> ()){
        
        NetworkRequest.sharedInstance.getRequest(urlString: BM_GET_SCHOOL_INFO, params: parameters, success: { (response) in
            success(response)
        }, failture: { (error) in
            failure(error)
        })
    }
    
    /// 2.16获得联系信息
    static func bm_get_contact_info(parameters: Parameters,success:@escaping (_ response:[String:AnyObject]) -> (),failure:@escaping(_ error: Error) -> ()){
        
        NetworkRequest.sharedInstance.getRequest(urlString: BM_GET_CONTACT_INFO, params: parameters, success: { (response) in
            success(response)
        }, failture: { (error) in
            failure(error)
        })
    }

    /// 2.17获得照片信息
    static func bm_get_data_info(parameters: Parameters,success:@escaping (_ response:[String:AnyObject]) -> (),failure:@escaping(_ error: Error) -> ()){
        
        NetworkRequest.sharedInstance.getRequest(urlString: BM_GET_DATA_INFO, params: parameters, success: { (response) in
            success(response)
        }, failture: { (error) in
            failure(error)
        })
    }
}








