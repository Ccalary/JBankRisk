//
//  URL.swift
//  JBankRisk
//
//  Created by caohouhong on 16/10/31.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

let BASR_DEV_URL = "http://192.168.1.246:8080"

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






