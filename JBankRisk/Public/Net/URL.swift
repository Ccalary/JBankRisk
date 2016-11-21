//
//  URL.swift
//  JBankRisk
//
//  Created by caohouhong on 16/10/31.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit
let LOCAL = "http://192.168.1.121:8080" //本地
let ONLINE = "http://106.38.109.11:8081" //线上

let BASR_DEV_URL = ONLINE

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

/// 2.4 获取商户地址
let BM_GET_SALE_ADDRESS = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=490012"

/// 2.5 学校信息上传
let BM_SCHOOL_UPLOAD = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=590042"

/// 2.6 获取学校名称
let BM_GET_SCHOOL_NAME = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=490099"

/// 2.7申请借款期限
let BM_APPLY_PERIOD_URL = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=490011"

/// 2.8月还款，总还款计算
let BM_COUNT_REPAYMENT_URL = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=400046"

/// 2.9 职业信息上传
let BM_WORK_UPLOAD = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=490071"

/// 2.10 联系人信息上传
let BM_CONTACT_UPLOAD = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=490091"

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

/// 2.14学校信息回传
let BM_GET_SCHOOL_INFO = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=490094"

/// 2.14联系信息回传
let BM_GET_CONTACT_INFO = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=490093"

/// 2.14照片信息回传
let BM_GET_DATA_INFO = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=490114"

/// 2.15借款状态与信息上传状态
let BM_BORROW_STATUS = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=490012"

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
let PC_PROTOCOL_DETAIL = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=490666"








