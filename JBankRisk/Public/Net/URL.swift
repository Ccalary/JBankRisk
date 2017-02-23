//
//  URL.swift
//  JBankRisk
//
//  Created by caohouhong on 16/10/31.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit
let LOCAL = "http://192.168.1.80:8080" //本地
let ONLINE = "https://dev.zc-cfc.com" //线上
let PRODUCT = "https://www.zc-cfc.com"//生产

//H 测试
//let BASR_DEV_URL = UserHelper.getRerviceUrl() ?? PRODUCT

let BASR_DEV_URL = LOCAL 

/// 请求地址接口
let OTHER_SERVICE_URL = "https://www.zc-cfc.com/jinangk.xhtml?TX_CODE=490001"

/*************注册登录模块(RL)*************/
/// 1.1注册
let RL_REGISTER_URL = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=490051"

/// 1.2验证码接口
let RL_RANDOM_CODE_URL = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=100003"

/// 1.3登录接口
let RL_NORMAL_LOGIN_URL = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=490010"

/// 1.4验证码登录
let RL_RANCODE_LOGIN_URL = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=490110"

/// 1.5修改密码
let RL_CHANGE_PSW_URL = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=490053"

/*****************借款流程模块(BM)******************/

/// 2.1 首页
let BM_HOME_URL = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=490014"

/// 2.2 身份信息上传
let BM_IDENTITY_UPLOAD = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=590013"

/// 2.3 产品信息上传
let BM_PRODUCT_UPLOAD = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=490041"

/// 2.3.1 产品信息上传(驳回)
let BM_PRODUCT_UPLOAD_REJECT = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=490043"

/// 2.4 获取商户地址
let BM_GET_SALE_ADDRESS = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=490012"

/// 2.5 学校信息上传
let BM_SCHOOL_UPLOAD = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=590042"

/// 2.5.1 学校信息上传(驳回)
let BM_SCHOOL_UPLOAD_REJECT = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=590043"

/// 2.6 获取学校名称
let BM_GET_SCHOOL_NAME = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=490099"

/// 2.7申请借款期限
let BM_APPLY_PERIOD_URL = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=490011"

/// 2.8月还款，总还款计算
let BM_COUNT_REPAYMENT_URL = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=400046"

/// 2.9 职业信息上传
let BM_WORK_UPLOAD = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=490071"

/// 2.9.1 职业信息上传(驳回)
let BM_WORK_UPLOAD_REJECT = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=490072"

/// 2.10 联系人信息上传
let BM_CONTACT_UPLOAD = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=490091"

/// 2.10.1 联系人信息上传(驳回)
let BM_CONTACT_UPLOAD_REJECT = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=490097"

/// 2.11 照片信息上传
let BM_PHOTO_UPLOAD = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=100001"

/// 2.12申请借款相关协议(协议地址)
let BM_APPLY_PROTOCOL = BASR_DEV_URL + "/attachment/agreement.html"

/// 2.13身份信息回传
let BM_GET_IDENTITY_INFO = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=590014"

/// 2.14产品信息回传
let BM_GET_PRODUCT_INFO = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=490044"

/// 2.15工作信息回传
let BM_GET_WORK_INFO = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=490074"

/// 2.15.1工作信息回传(驳回)
let BM_GET_WORK_INFO_REJECT = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=490075"

/// 2.16学校信息回传
let BM_GET_SCHOOL_INFO = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=490094"

/// 2.16.1学校信息回传(驳回)
let BM_GET_SCHOOL_INFO_REJECT = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=490095"

/// 2.17联系信息回传
let BM_GET_CONTACT_INFO = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=490093"

/// 2.17.1联系信息回传(驳回)
let BM_GET_CONTACT_INFO_REJECT = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=490092"

/// 2.18照片信息回传
let BM_GET_DATA_INFO = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=490114"

/// 2.19借款状态与信息上传状态
let BM_BORROW_STATUS = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=490012"

/// 2.20自由族收入信息上传
let BM_INCOME_STATUS = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=490413"

/// 2.20.1自由族收入信息上传(驳回)
let BM_INCOME_STATUS_REJECT = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=490414"

/***************************个人中心(PC)****************************/

///3.1个人中心首页
let PC_HOME_URL = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=490311"

///3.2借款纪录
let PC_BORROW_RECORD = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=490044"

///3.3借款状态
let PC_BORROW_STATUS = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=490112"

///3.4还款账单
let PC_REPAYMENT_BILL = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=490314"

///3.5总还款详情
let PC_REPAYMENT_ALL_DETAIL = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=490225"

///3.6月还款详情
let PC_REPAYMENT_MONTH_DETAIL = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=490048"

///3.7应还详情
let PC_NEED_REPAYMENT_DETAIL = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=490235"

///3.8已还明细
let PC_REPAY_LIST_DETAIL = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=490375"

///3.9合同详情
let PC_PROTOCOL_DETAIL = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=666666"

///3.10消息
let PC_MESSAGE_URL = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=490223"

///3.11消息已读
let PC_MESSAGE_READED_URL = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=490224"

///3.12计算总额
let PC_REPAY_AMOUNT = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=900090"

///3.13发起支付请求
let PC_REPAY_REQUEST = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=900099"

///3.14支付成功回调结果
let PC_REPAY_SUCCESS_RESULT = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=900091"

/****************其他(other)******************/
///4.1修改密码
let OT_CHANGE_PSD_URL = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=490385"

///4.2修改手机号
let OT_CHANGE_MOBILE_URL = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=490113"

///4.3版本升级
let OT_UPDATA_VERSION_URL = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=490000"

///4.4合同签约
let OT_CONTRACT_SIGN_URL = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=999111"

///4.5合同查询
let OT_CONTRACT_SEARCH_URL = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=900002"

///4.6合同列表
let OT_CONTRACT_LIST = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=999113"

///4.7上传用户通讯录
let OT_UPLOAD_CONTACT_LIST = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=900005"

