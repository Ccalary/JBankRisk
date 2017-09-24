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
        params["userId"] = UserHelper.getUserId()
        params["channel"] = "3" // iOS-3,android-4
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
           
            PrintLog("首页地址\(BM_HOME_URL)")
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
        
        NetworkRequest.sharedInstance.postRequest(urlString: UserHelper.getIsReject() ? BM_PRODUCT_UPLOAD_REJECT : BM_PRODUCT_UPLOAD, params: parameters, success: { (response) in
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
        
        NetworkRequest.sharedInstance.postRequest(urlString: UserHelper.getIsReject() ? BM_SCHOOL_UPLOAD_REJECT : BM_SCHOOL_UPLOAD, params: parameters, success: { (response) in
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
        
        NetworkRequest.sharedInstance.postRequest(urlString: UserHelper.getIsReject() ? BM_WORK_UPLOAD_REJECT : BM_WORK_UPLOAD, params: parameters, success: { (response) in
            success(response)
        }, failture: { (error) in
            failure(error)
        })
    }
    
    /// 2.10联系信息上传
    static func bm_upload_contact_info(parameters: Parameters,success:@escaping (_ response:[String:AnyObject]) -> (),failure:@escaping(_ error: Error) -> ()){
        
        NetworkRequest.sharedInstance.postRequest(urlString: UserHelper.getIsReject() ? BM_CONTACT_UPLOAD_REJECT : BM_CONTACT_UPLOAD, params: parameters, success: { (response) in
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
        
        NetworkRequest.sharedInstance.getRequest(urlString: UserHelper.getIsReject() ? BM_GET_WORK_INFO_REJECT : BM_GET_WORK_INFO, params: parameters, success: { (response) in
            success(response)
        }, failture: { (error) in
            failure(error)
        })
    }
    
    /// 2.15获得学校信息
    static func bm_get_school_info(parameters: Parameters,success:@escaping (_ response:[String:AnyObject]) -> (),failure:@escaping(_ error: Error) -> ()){
        
        NetworkRequest.sharedInstance.getRequest(urlString: UserHelper.getIsReject() ? BM_GET_SCHOOL_INFO_REJECT : BM_GET_SCHOOL_INFO, params: parameters, success: { (response) in
            success(response)
        }, failture: { (error) in
            failure(error)
        })
    }
    
    /// 2.16获得联系信息
    static func bm_get_contact_info(parameters: Parameters,success:@escaping (_ response:[String:AnyObject]) -> (),failure:@escaping(_ error: Error) -> ()){
        
        NetworkRequest.sharedInstance.getRequest(urlString: UserHelper.getIsReject() ? BM_GET_CONTACT_INFO_REJECT : BM_GET_CONTACT_INFO, params: parameters, success: { (response) in
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
    
    /// 2.18收入信息上传
    static func bm_upload_income_info(parameters: Parameters,success:@escaping (_ response:[String:AnyObject]) -> (),failure:@escaping(_ error: Error) -> ()){
        
        NetworkRequest.sharedInstance.postRequest(urlString: UserHelper.getIsReject() ? BM_INCOME_STATUS_REJECT : BM_INCOME_STATUS, params: parameters, success: { (response) in
            success(response)
        }, failture: { (error) in
            failure(error)
        })
    }
    
    /// 2.19获取芝麻信用授权地址
    static func bm_income_get_zhima_url(parameters: Parameters,success:@escaping (_ response:[String:AnyObject]) -> (),failure:@escaping(_ error: Error) -> ()){
        
        NetworkRequest.sharedInstance.postRequest(urlString: BM_INCOME_GET_ZHIMA_URL, params: parameters, success: { (response) in
            success(response)
        }, failture: { (error) in
            failure(error)
        })
    }
    
    /***********************个人中心（PC）**************************/
    
    //3.1 个人中心首页
    static func pc_home_info(parameters: Parameters,success:@escaping (_ response:[String:AnyObject]) -> (),failure:@escaping(_ error: Error) -> ()){
        
        NetworkRequest.sharedInstance.getRequest(urlString: PC_HOME_URL, params: parameters, success: { (response) in
            success(response)
        }, failture: { (error) in
            failure(error)
        })
    }
    
    
    //3.2 借款纪录
    static func pc_borrow_record(parameters: Parameters,success:@escaping (_ response:[String:AnyObject]) -> (),failure:@escaping(_ error: Error) -> ()){
        
        NetworkRequest.sharedInstance.getRequest(urlString: PC_BORROW_RECORD, params: parameters, success: { (response) in
            success(response)
        }, failture: { (error) in
            failure(error)
        })
    }
    
    //3.3 借款状态
    static func pc_borrow_status(parameters: Parameters,success:@escaping (_ response:[String:AnyObject]) -> (),failure:@escaping(_ error: Error) -> ()){
        
        NetworkRequest.sharedInstance.getRequest(urlString: PC_BORROW_STATUS, params: parameters, success: { (response) in
            success(response)
        }, failture: { (error) in
            failure(error)
        })
    }
    
    //3.4 还款账单
    static func pc_repayment_bill(parameters: Parameters,success:@escaping (_ response:[String:AnyObject]) -> (),failure:@escaping(_ error: Error) -> ()){
        
        NetworkRequest.sharedInstance.getRequest(urlString: PC_REPAYMENT_BILL, params: parameters, success: { (response) in
            success(response)
        }, failture: { (error) in
            failure(error)
        })
    }
    
    //3.5 总还款详情
    static func pc_repayment_all_detail(parameters: Parameters,success:@escaping (_ response:[String:AnyObject]) -> (),failure:@escaping(_ error: Error) -> ()){
        
        NetworkRequest.sharedInstance.getRequest(urlString: PC_REPAYMENT_ALL_DETAIL, params: parameters, success: { (response) in
            success(response)
        }, failture: { (error) in
            failure(error)
        })
    }
    
    //3.6 月还款详情
    static func pc_repayment_month_detail(parameters: Parameters,success:@escaping (_ response:[String:AnyObject]) -> (),failure:@escaping(_ error: Error) -> ()){
        
        NetworkRequest.sharedInstance.getRequest(urlString: PC_REPAYMENT_MONTH_DETAIL, params: parameters, success: { (response) in
            success(response)
        }, failture: { (error) in
            failure(error)
        })
    }
    
    //3.7 应还详情
    static func pc_need_repayment_detail(parameters: Parameters,success:@escaping (_ response:[String:AnyObject]) -> (),failure:@escaping(_ error: Error) -> ()){
        
        NetworkRequest.sharedInstance.getRequest(urlString: PC_NEED_REPAYMENT_DETAIL, params: parameters, success: { (response) in
            success(response)
        }, failture: { (error) in
            failure(error)
        })
    }
    
    //3.8 已还明细
    static func pc_repay_list_detail(parameters: Parameters,success:@escaping (_ response:[String:AnyObject]) -> (),failure:@escaping(_ error: Error) -> ()){
        
        NetworkRequest.sharedInstance.getRequest(urlString: PC_REPAY_LIST_DETAIL, params: parameters, success: { (response) in
            success(response)
        }, failture: { (error) in
            failure(error)
        })
    }

    //3.9 消息
    static func pc_message_detail(parameters: Parameters,success:@escaping (_ response:[String:AnyObject]) -> (),failure:@escaping(_ error: Error) -> ()){
        
        NetworkRequest.sharedInstance.getRequest(urlString: PC_MESSAGE_URL, params: parameters, success: { (response) in
            success(response)
        }, failture: { (error) in
            failure(error)
        })
    }
    
    //3.10 已读消息
    static func pc_message_readed(parameters: Parameters,success:@escaping (_ response:[String:AnyObject]) -> (),failure:@escaping(_ error: Error) -> ()){
        
        NetworkRequest.sharedInstance.getRequest(urlString: PC_MESSAGE_READED_URL, params: parameters, success: { (response) in
            success(response)
        }, failture: { (error) in
            failure(error)
        })
    }

    //3.11计算还款总额
    static func pc_repay_amount(parameters: Parameters,success:@escaping (_ response:[String:AnyObject]) -> (),failure:@escaping(_ error: Error) -> ()){
        
        NetworkRequest.sharedInstance.postRequest(urlString: PC_REPAY_AMOUNT, params: parameters, success: { (response) in
            success(response)
        }, failture: { (error) in
            failure(error)
        })
    }

    //3.12发起支付请求
    static func pc_repay_request(parameters: Parameters,success:@escaping (_ response:[String:AnyObject]) -> (),failure:@escaping(_ error: Error) -> ()){
        
        NetworkRequest.sharedInstance.postRequest(urlString: PC_REPAY_REQUEST, params: parameters, success: { (response) in
            success(response)
        }, failture: { (error) in
            failure(error)
        })
    }
    
    //3.13支付成功回调
    static func pc_repay_success_result(parameters: Parameters,success:@escaping (_ response:[String:AnyObject]) -> (),failure:@escaping(_ error: Error) -> ()){
        
        NetworkRequest.sharedInstance.postRequest(urlString: PC_REPAY_SUCCESS_RESULT, params: parameters, success: { (response) in
            success(response)
        }, failture: { (error) in
            failure(error)
        })
    }

    ///3.14我要吐槽信息上传

    static func pc_upload_suggest_info(params:[String: String], data: [Data], name: [String],success:@escaping (_ response:[String:AnyObject]) -> (),failure:@escaping(_ error: Error) -> ()){
        
        NetworkRequest.sharedInstance.upLoadImageRequest(urlString: PC_UPLOAD_SUGGEST_INFO,params:params, data: data, name: name, success: { (response) in
            success(response)
        }, failture: { (error) in
            failure(error)
        })
    }
    
    ///3.16 提前还款
    static func pc_repay_final(parameters: Parameters,success:@escaping (_ response:[String:AnyObject]) -> (),failure:@escaping(_ error: Error) -> ()){
        NetworkRequest.sharedInstance.getRequest(urlString: PC_REPAY_FINAN, params: parameters, success: { (response) in
            success(response)
        }, failture: { (error) in
            failure(error)
        })
    }

    ///3.17申请(取消)结算
    static func pc_repay_final_apply(parameters: Parameters,success:@escaping (_ response:[String:AnyObject]) -> (),failure:@escaping(_ error: Error) -> ()){
        NetworkRequest.sharedInstance.getRequest(urlString: PC_REPAY_FINAN_APPLY, params: parameters, success: { (response) in
            success(response)
        }, failture: { (error) in
            failure(error)
        })
    }
    
    ///3.18撤销订单
    static func pc_cancel_order(parameters: Parameters,success:@escaping (_ response:[String:AnyObject]) -> (),failure:@escaping(_ error: Error) -> ()){
        NetworkRequest.sharedInstance.getRequest(urlString: PC_CANCEL_ORDER, params: parameters, success: { (response) in
            success(response)
        }, failture: { (error) in
            failure(error)
        })
    }
    
    /******************其他******************/
    //4.1 修改密码
    static func other_change_psd(parameters: Parameters,success:@escaping (_ response:[String:AnyObject]) -> (),failure:@escaping(_ error: Error) -> ()){
        
        NetworkRequest.sharedInstance.postRequest(urlString: OT_CHANGE_PSD_URL, params: parameters, success: { (response) in
            success(response)
        }, failture: { (error) in
            failure(error)
        })
    }
    
    //4.2 修改手机号
    static func other_change_mobile(parameters: Parameters,success:@escaping (_ response:[String:AnyObject]) -> (),failure:@escaping(_ error: Error) -> ()){
        
        NetworkRequest.sharedInstance.postRequest(urlString: OT_CHANGE_MOBILE_URL, params: parameters, success: { (response) in
            success(response)
        }, failture: { (error) in
            failure(error)
        })
    }
    
    //4.3 版本升级
    static func other_updata_version(parameters: Parameters,success:@escaping (_ response:[String:AnyObject]) -> (),failure:@escaping(_ error: Error) -> ()){
        NetworkRequest.sharedInstance.getRequest(urlString: OT_UPDATA_VERSION_URL, params: parameters, success: { (response) in
            
            success(response)
        }, failture: { (error) in
            failure(error)
        })
    }
    
    //4.4 合同签约
    static func other_contract_sign(parameters: Parameters,success:@escaping (_ response:[String:AnyObject]) -> (),failure:@escaping(_ error: Error) -> ()){
        NetworkRequest.sharedInstance.getRequest(urlString: OT_CONTRACT_SIGN_URL, params: parameters, success: { (response) in
            success(response)
        }, failture: { (error) in
            failure(error)
        })
    }
    
    //4.5 合同查询
    static func other_contract_search(parameters: Parameters,success:@escaping (_ response:[String:AnyObject]) -> (),failure:@escaping(_ error: Error) -> ()){
        NetworkRequest.sharedInstance.getRequest(urlString: OT_CONTRACT_SEARCH_URL, params: parameters, success: { (response) in
            success(response)
        }, failture: { (error) in
            failure(error)
        })
    }
    
    //4.6 合同列表
    static func other_contract_list(parameters: Parameters,success:@escaping (_ response:[String:AnyObject]) -> (),failure:@escaping(_ error: Error) -> ()){
        NetworkRequest.sharedInstance.getRequest(urlString: OT_CONTRACT_LIST, params: parameters, success: { (response) in
            success(response)
        }, failture: { (error) in
            failure(error)
        })
    }
    
    //4.7 上传用户通讯录
    static func other_upload_contact_list(parameters: Parameters,success:@escaping (_ response:[String:AnyObject]) -> (),failure:@escaping(_ error: Error) -> ()){
        NetworkRequest.sharedInstance.postRequest(urlString: OT_UPLOAD_CONTACT_LIST, params: parameters, success: { (response) in
            success(response)
        }, failture: { (error) in
            failure(error)
        })
    }
    
    //4.8 上传用户硬件信息
    static func other_upload_hardware_info(parameters: Parameters,success:@escaping (_ response:[String:AnyObject]) -> (),failure:@escaping(_ error: Error) -> ()){
        NetworkRequest.sharedInstance.postRequest(urlString: OT_UPLOAD_HARDWARE_INFO, params: parameters, success: { (response) in
            success(response)
        }, failture: { (error) in
            failure(error)
        })
    }

}

