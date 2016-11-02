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

/// 1.注册
let RL_REGISTER_URL = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=490051"

/// 2.验证码接口
let RL_RANDOM_CODE_URL = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=100003"

/// 3.登录接口
let RL_NORMAL_LOGIN_URL = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=490010"

/// 4.验证码登录
let RL_RANCODE_LOGIN_URL = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=490110"

///5.修改密码
let RL_CHANGE_PSW_URL = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=490053"

/*****************借款流程模块(BM)******************/

/// 6.申请期限
let BM_APPLY_PERIOD_URL = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=490011"

/// 7.月还款，总还款计算
let BM_COUNT_REPAYMENT_URL = BASR_DEV_URL + "/jinangk.xhtml?TX_CODE=400046"






