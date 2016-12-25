//
//  UserHelper.swift
//  JBankRisk
//
//  Created by caohouhong on 16/10/31.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit
import SwiftyJSON

class UserHelper {
    
    //是否已登录 1- 已登录
    static func isLogin() -> Bool {
        let defaults = UserDefaults()
        let isLogIn = defaults.object(forKey: "isLogin") as? String
        return isLogIn == "1"
    }
    
    //保存登录信息
    static func setLoginInfo(dic:JSON){
        let defaults = UserDefaults()
        defaults.set("1", forKey: "isLogin")//已登录
//        defaults.set(dic["APP_SESSION_KEY"], forKey: "APP_SESSION_KEY")//版本号
        defaults.set(dic["userId"].stringValue, forKey: "userId")//userId
        defaults.set(dic["mobile"].stringValue, forKey: "mobile")//电话
        let role = changeRoleIntToString(roleType: dic["userType"].intValue)
        defaults.set(role, forKey: "userRole")//角色
        defaults.synchronize()
    }
    
    
    //转换后台返回的角色信息： 1-学生 2-白领 3-自由族 4-无
    static func changeRoleIntToString(roleType: Int) -> String?{
        switch roleType {
        case 1:
            return "学生"
        case 2:
            return "白领"
        case 3:
            return "自由族"
        default:
            return nil
        }
    }
    
    //退出登录清除信息
    static func setLogoutInfo(){
         let defaults = UserDefaults()
         defaults.set("0", forKey: "isLogin") //退出登录
         defaults.set(nil, forKey: "userId") //清空userId
         defaults.set(nil, forKey: "mobile")  //情况电话
         defaults.set(nil, forKey: "userRole")//角色
         defaults.set(nil, forKey: "homeCellArray") //清空首页缓存数据
         defaults.synchronize()
    }
    
    ///获得用户角色
    ///1- "学生" 2- “白领” 3-“自由族”
    static func getUserRole() -> String?{
        let defaults = UserDefaults()
        return defaults.object(forKey: "userRole") as? String
    }
    
    ///保存用户角色
    static func setUserRole(role: String) {
        let defaults = UserDefaults()
        defaults.set(role, forKey: "userRole")
        defaults.synchronize()
    }

    //获取用户电话
    static func getUserMobile() -> String? {
        let defaults = UserDefaults()
        return defaults.object(forKey: "mobile") as? String
    }
    
    static func setUserMobile(mobile: String){
        let defaults = UserDefaults()
        defaults.set(mobile, forKey: "mobile")
        defaults.synchronize()
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
    
    //借款状态
    static func getBorrowStatus() -> String? {
        let defaults = UserDefaults()
        return defaults.object(forKey: "\(self.getUserId())borrowStatus") as? String
    }
    
    static func setBorrow(status: String?){
        let defaults = UserDefaults()
        defaults.set(status, forKey: "\(self.getUserId())borrowStatus")
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
    
    /****************首页缓存***************/
    //首页banner图地址
    static func getHomeImageData() -> [String]? {
        let defaults = UserDefaults()
        return defaults.object(forKey: "homeImageArray") as? [String]
    }
    
    static func setHomeImageData(imageArray: [String]){
        let defaults = UserDefaults()
        defaults.set(imageArray, forKey: "homeImageArray")
        defaults.synchronize()
    }
    
    //首页banner信息
    static func getHomeCellDataArray() -> [Dictionary<String,String>]? {
        let defaults = UserDefaults()
        return defaults.object(forKey: "homeCellArray") as? [Dictionary<String,String>]
    }
    
    static func setHomeCellDataArray(cellArray: [Dictionary<String,String>]?){
        let defaults = UserDefaults()
        defaults.set(cellArray, forKey: "homeCellArray")
        defaults.synchronize()
    }

    //获取用户借款金额
    static func getUserBorrowAmt() -> Int? {
        let defaults = UserDefaults()
        return defaults.object(forKey: "\(self.getUserId())userBorrowAmt") as? Int
    }
    
    static func setUserBorrowAmt(money: Int){
        let defaults = UserDefaults()
        defaults.set(money, forKey: "\(self.getUserId())userBorrowAmt")
        defaults.synchronize()
    }

    
    /****************上传记录****************/
    //用户身份信息是否上传
    static func getIdentityIsUpload() -> Bool {
        let defaults = UserDefaults()
        return (defaults.object(forKey: "\(self.getUserId())identityUpload") as? Bool) ?? false
    }
    
    static func setIdentity(isUpload: Bool){
        let defaults = UserDefaults()
        defaults.set(isUpload, forKey: "\(self.getUserId())identityUpload")
        defaults.synchronize()
    }
    
    //产品信息是否上传
    static func getProductIsUpload() -> Bool {
        let defaults = UserDefaults()
        return (defaults.object(forKey: "\(self.getUserId())productUpload") as? Bool) ?? false
    }
    
    static func setProduct(isUpload: Bool){
        let defaults = UserDefaults()
        defaults.set(isUpload, forKey: "\(self.getUserId())productUpload")
        defaults.synchronize()
    }
    
    //工作信息是否上传
    static func getWorkIsUpload() -> Bool {
        let defaults = UserDefaults()
        return (defaults.object(forKey: "\(self.getUserId())workUpload") as? Bool) ?? false
    }
    
    static func setWork(isUpload: Bool){
        let defaults = UserDefaults()
        defaults.set(isUpload, forKey: "\(self.getUserId())workUpload")
        defaults.synchronize()
    }
    
    //学校信息是否上传
    static func getSchoolIsUpload() -> Bool {
        let defaults = UserDefaults()
        return (defaults.object(forKey: "\(self.getUserId())schoolUpload") as? Bool) ?? false
    }
    
    static func setSchool(isUpload: Bool){
        let defaults = UserDefaults()
        defaults.set(isUpload, forKey: "\(self.getUserId())schoolUpload")
        defaults.synchronize()
    }
    
    //收入信息是否上传
    static func getIncomeIsUpload() -> Bool {
        let defaults = UserDefaults()
        return (defaults.object(forKey: "\(self.getUserId())incomeUpload") as? Bool) ?? false
    }
    
    static func setIncome(isUpload: Bool){
        let defaults = UserDefaults()
        defaults.set(isUpload, forKey: "\(self.getUserId())incomeUpload")
        defaults.synchronize()
    }

    
    //联系人信息是否上传
    static func getContactIsUpload() -> Bool {
        let defaults = UserDefaults()
        return (defaults.object(forKey: "\(self.getUserId())contactUpload") as? Bool) ?? false
    }
    
    static func setContact(isUpload: Bool){
        let defaults = UserDefaults()
        defaults.set(isUpload, forKey: "\(self.getUserId())contactUpload")
        defaults.synchronize()
    }

    
    //用户信息是否上传
    static func getDataIsUpload() -> Bool {
        let defaults = UserDefaults()
        return (defaults.object(forKey: "\(self.getUserId())dataUpload") as? Bool) ?? false
    }
    
    static func setData(isUpload: Bool){
        let defaults = UserDefaults()
        defaults.set(isUpload, forKey: "\(self.getUserId())dataUpload")
        defaults.synchronize()
    }

    //是否信息全部上传完毕
    static func getAllFinishIsUpload() -> Bool {
        let defaults = UserDefaults()
        return (defaults.object(forKey: "\(self.getUserId())finishUplod") as? Bool) ?? false
    }
    
    static func setAllFinishIsUpload(isUpload: Bool){
        let defaults = UserDefaults()
        defaults.set(isUpload, forKey: "\(self.getUserId())finishUplod")
        defaults.synchronize()
    }
    
    /*************个人中心***************/
    //用户头像地址
    static func getUserHeaderUrl() -> String? {
        let defaults = UserDefaults()
        return defaults.object(forKey: "\(self.getUserId())userHeaderUrl") as? String
    }
    
    static func setUserHeader(headerUrl: String){
        let defaults = UserDefaults()
        defaults.set(headerUrl, forKey: "\(self.getUserId())userHeaderUrl")
        defaults.synchronize()
    }

    
    
}

