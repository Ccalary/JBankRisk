//
//  UserHelper.swift
//  JBankRisk
//
//  Created by caohouhong on 16/10/31.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

class UserHelper {
    
    //是否已登录 1- 已登录
    static func isLogin() -> Bool {
        let defaults = UserDefaults()
        let isLogIn = defaults.object(forKey: "isLogin") as? String
        return isLogIn == "1"
    }
    
    //保存登录信息
    static func setLoginInfo(dic:Dictionary<String,String>){
        let defaults = UserDefaults()
        defaults.set("1", forKey: "isLogin")//已登录
        defaults.set(dic["APP_SESSION_KEY"], forKey: "APP_SESSION_KEY")//版本号
        defaults.set(dic["userId"], forKey: "userId")//userId
        defaults.set(dic["mobile"], forKey: "mobile")//电话
        
        defaults.set(dic, forKey: "loginInfo")//登录信息
        defaults.synchronize()
    }
    
    //退出登录清除信息
    static func logout(){
         let defaults = UserDefaults()
         defaults.set("0", forKey: "isLogin") //退出登录
         defaults.set("", forKey: "user_id")
         defaults.set(nil, forKey: "loginInfo")//清空登录信息
    }
    
    ///获得用户角色
    ///1- "学生" 2- “白领” 3-“自由族”
    static func getUserRole() -> String{
        let defaults = UserDefaults()
        return defaults.object(forKey: "userRole") as! (String)
    }
    
    ///保存用户角色
    static func setUserRole(role: String) {
        let defaults = UserDefaults()
        defaults.set(role, forKey: "userRole")
        defaults.synchronize()
    }

    ///地址（list）信息
    static func getChinaAreaInfo() -> NSArray? {
        let defaults = UserDefaults()
        return defaults.object(forKey: "chinaAreaInfo") as? NSArray
    }
    
    static func setChinaAreaInfo(areaArray:NSArray){
        let defaults = UserDefaults()
         defaults.set(areaArray, forKey: "chinaAreaInfo")
         defaults.synchronize()
    }

    //获取用户电话
    static func getUserMobile() -> String? {
        let defaults = UserDefaults()
        return defaults.object(forKey: "mobile") as? String
    }
    
    //用户id
    static func getUserId() -> String? {
        let defaults = UserDefaults()
        return defaults.object(forKey: "userId") as? String
    }
    
    static func setUserId(userId: String){
        let defaults = UserDefaults()
        defaults.set(userId, forKey: "userId")
        defaults.synchronize()
    }
}

