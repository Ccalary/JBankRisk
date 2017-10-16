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
    

    //MARK:是否已登录 1- 已登录
    static func isLogin() -> Bool {
        let defaults = UserDefaults()
        let isLogIn = defaults.object(forKey: "isLogin") as? String
        return isLogIn == "1"
    }
    
    //MARK:保存登录信息
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
    
    //MARK:退出登录清除信息
    static func setLogoutInfo(){
         let defaults = UserDefaults()
         defaults.set("0", forKey: "isLogin") //退出登录
         defaults.set(nil, forKey: "userId") //清空userId
         defaults.set(nil, forKey: "mobile")  //情况电话
         defaults.set(nil, forKey: "userRole")//角色
         defaults.set(nil, forKey: "homeCellArray") //清空首页缓存数据
         defaults.synchronize()
    }
    
    //MARK: 是否第一次打开app
    static func setIsFirstTime(_ isFirstTime: String){
        let defaults = UserDefaults()
        defaults.set(isFirstTime, forKey: "isFirstTime\(APP_VERSION)")
        defaults.synchronize()
    }
    
    static func getIsFirstTime() -> String?{
        let defaults = UserDefaults()
        return defaults.object(forKey: "isFirstTime\(APP_VERSION)") as? String
    }
    
    //MARK: 是否是推送而来  1 - 是 其它－否
    static func setIsFromPush(_ isPush: String){
        let defaults = UserDefaults()
        defaults.set(isPush, forKey: "isPush")
        defaults.synchronize()
    }
    
    static func getIsFromPush() -> Bool{
        let defaults = UserDefaults()
        let isPush = defaults.object(forKey: "isPush") as? String
        return isPush == "1"
    }
    
    //MARK: 是否弹出过芝麻信用授权
    static func setIsShowedZhiMa(_ isShowed: Bool){
        let defaults = UserDefaults()
        defaults.set(isShowed, forKey: "isShowedZhiMa\(self.getUserId())")
        defaults.synchronize()
    }
    
    static func getIsShowedZhiMa() -> Bool{
        let defaults = UserDefaults()
        return defaults.object(forKey: "isShowedZhiMa\(self.getUserId())") as? Bool ?? false
    }

    
    //MARK:获得用户角色
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
    static func getUserMobile() -> String {
        let defaults = UserDefaults()
        return defaults.object(forKey: "mobile") as? String ?? ""
    }
    
    static func setUserMobile(mobile: String){
        let defaults = UserDefaults()
        defaults.set(mobile, forKey: "mobile")
        defaults.synchronize()
    }
    //用户id
    static func getUserId() -> String {
        let defaults = UserDefaults()
        return defaults.object(forKey: "userId") as? String ?? ""
    }
    
    static func setUserId(userId: String){
        let defaults = UserDefaults()
        defaults.set(userId, forKey: "userId")
        defaults.synchronize()
    }
    
    //借款状态
    static func getBorrowStatus() -> String? {
        let defaults = UserDefaults()
        return defaults.object(forKey: "borrowStatus\(self.getUserId())") as? String
    }
    
    static func setBorrow(status: String?){
        let defaults = UserDefaults()
        defaults.set(status, forKey: "borrowStatus\(self.getUserId())")
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
    //MARK:首页banner图地址
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
        return defaults.object(forKey: "userBorrowAmt\(self.getUserId())") as? Int
    }
    
    static func setUserBorrowAmt(money: Int){
        let defaults = UserDefaults()
        defaults.set(money, forKey: "userBorrowAmt\(self.getUserId())")
        defaults.synchronize()
    }

    //获取用户家庭地址
    static func getUserHomeAddress() -> String? {
        let defaults = UserDefaults()
        return defaults.object(forKey: "userHomeAddress\(self.getUserId())") as? String
    }
    
    static func setUserHome(address: String?){
        let defaults = UserDefaults()
        defaults.set(address, forKey: "userHomeAddress\(self.getUserId())")
        defaults.synchronize()
    }
    
    /****************上传记录****************/
    //MARK:上传记录
    //用户身份信息是否上传
    static func getIdentityIsUpload() -> Bool {
        let defaults = UserDefaults()
        return (defaults.object(forKey: "identityUpload\(self.getUserId())") as? Bool) ?? false
    }
    
    static func setIdentity(isUpload: Bool){
        let defaults = UserDefaults()
        defaults.set(isUpload, forKey: "identityUpload\(self.getUserId())")
        defaults.synchronize()
    }
    
    //产品信息是否上传
    static func getProductIsUpload() -> Bool {
        let defaults = UserDefaults()
        return (defaults.object(forKey: "productUpload\(self.getUserId())") as? Bool) ?? false
    }
    
    static func setProduct(isUpload: Bool){
        let defaults = UserDefaults()
        defaults.set(isUpload, forKey: "productUpload\(self.getUserId())")
        defaults.synchronize()
    }
    
    //工作信息是否上传
    static func getWorkIsUpload() -> Bool {
        let defaults = UserDefaults()
        return (defaults.object(forKey: "workUpload\(self.getUserId())") as? Bool) ?? false
    }
    
    static func setWork(isUpload: Bool){
        let defaults = UserDefaults()
        defaults.set(isUpload, forKey: "workUpload\(self.getUserId())")
        defaults.synchronize()
    }
    
    //学校信息是否上传
    static func getSchoolIsUpload() -> Bool {
        let defaults = UserDefaults()
        return (defaults.object(forKey: "schoolUpload\(self.getUserId())") as? Bool) ?? false
    }
    
    static func setSchool(isUpload: Bool){
        let defaults = UserDefaults()
        defaults.set(isUpload, forKey: "schoolUpload\(self.getUserId())")
        defaults.synchronize()
    }
    
    //收入信息是否上传
    static func getIncomeIsUpload() -> Bool {
        let defaults = UserDefaults()
        return (defaults.object(forKey: "incomeUpload\(self.getUserId())") as? Bool) ?? false
    }
    
    static func setIncome(isUpload: Bool){
        let defaults = UserDefaults()
        defaults.set(isUpload, forKey: "incomeUpload\(self.getUserId())")
        defaults.synchronize()
    }

    
    //联系人信息是否上传
    static func getContactIsUpload() -> Bool {
        let defaults = UserDefaults()
        return (defaults.object(forKey: "contactUpload\(self.getUserId())") as? Bool) ?? false
    }
    
    static func setContact(isUpload: Bool){
        let defaults = UserDefaults()
        defaults.set(isUpload, forKey: "contactUpload\(self.getUserId())")
        defaults.synchronize()
    }

    
    //用户信息是否上传
    static func getDataIsUpload() -> Bool {
        let defaults = UserDefaults()
        return (defaults.object(forKey: "dataUpload\(self.getUserId())") as? Bool) ?? false
    }
    
    static func setData(isUpload: Bool){
        let defaults = UserDefaults()
        defaults.set(isUpload, forKey: "dataUpload\(self.getUserId())")
        defaults.synchronize()
    }

    //是否信息全部上传完毕
    static func getAllFinishIsUpload() -> Bool {
        let defaults = UserDefaults()
        return (defaults.object(forKey: "finishUplod\(self.getUserId())") as? Bool) ?? false
    }
    
    static func setAllFinishIsUpload(isUpload: Bool){
        let defaults = UserDefaults()
        defaults.set(isUpload, forKey: "finishUplod\(self.getUserId())")
        defaults.synchronize()
    }
    
    //是否是驳回
    static func getIsReject() -> Bool {
        let defaults = UserDefaults()
        return (defaults.object(forKey: "isReject\(self.getUserId())") as? Bool) ?? false
    }
    
    static func setIsReject(isReject: Bool){
        let defaults = UserDefaults()
        defaults.set(isReject, forKey: "isReject\(self.getUserId())")
        defaults.synchronize()
    }
    
    //是否是第二单
    static func getIsTwiceOrder() -> Bool {
        let defaults = UserDefaults()
        return (defaults.object(forKey: "isTwiceOrder\(self.getUserId())") as? Bool) ?? false
    }
    
    static func setIsTwiceOrder(isTwice: Bool){
        let defaults = UserDefaults()
        defaults.set(isTwice, forKey: "isTwiceOrder\(self.getUserId())")
        defaults.synchronize()
    }

    
    //最新一单的orderId
    static func getHomeNewOneOrderId() -> String {
        let defaults = UserDefaults()
        return (defaults.object(forKey: "homeNewOneOrderId\(self.getUserId())") as? String) ?? ""
    }
    
    static func setHomeNewOneOrderId(_ orderId: String){
        let defaults = UserDefaults()
        defaults.set(orderId, forKey: "homeNewOneOrderId\(self.getUserId())")
        defaults.synchronize()
    }
    
    /***********用户电子合同相关*************/
    //最新产品id
    static func getUserNewOrderId() -> String? {
        let defaults = UserDefaults()
        return defaults.object(forKey: "userOrderId\(self.getUserId())") as? String
    }
    
    static func setUserNewOrderId(_ orderId: String){
        let defaults = UserDefaults()
        defaults.set(orderId, forKey: "userOrderId\(self.getUserId())")
        defaults.synchronize()
    }
    
    //合同是否签署完毕
    static func getContractIsSigned() -> Bool {
        let defaults = UserDefaults()
        return (defaults.object(forKey: "ContractIsSigned\(self.getUserNewOrderId() as Optional)") as? Bool) ?? false
    }
    
    static func setContract(isSigned: Bool){
        let defaults = UserDefaults()
        defaults.set(isSigned, forKey: "ContractIsSigned\(self.getUserNewOrderId() as Optional)")
        defaults.synchronize()
    }

    /*************个人中心***************/
    //MARK:个人中心
    //用户头像地址
    static func getUserHeaderUrl() -> String? {
        let defaults = UserDefaults()
        return defaults.object(forKey: "userHeaderUrl\(self.getUserId())") as? String
    }
    
    static func setUserHeader(headerUrl: String){
        let defaults = UserDefaults()
        defaults.set(headerUrl, forKey: "userHeaderUrl\(self.getUserId())")
        defaults.synchronize()
    }
    
    /**************上传用户通讯录******************/
    //用户通讯录是否上传
    static func getContactListIsUpload() -> Bool {
        let defaults = UserDefaults()
        return (defaults.object(forKey: "ContactListIsUpLoad\(self.getUserId())") as? Bool) ?? false
    }
    
    static func setContactList(isUpload: Bool){
        let defaults = UserDefaults()
        defaults.set(isUpload, forKey: "ContactListIsUpLoad\(self.getUserId())")
        defaults.synchronize()
    }
    
    //MARK:上传用户通讯录
    static func uploadUserContactInfo(withparams params:[String:Any]){
        
        NetConnect.other_upload_contact_list(parameters: params, success: { response in
            let json = JSON(response)
            guard json["RET_CODE"] == "000000" else{
                return
            }
            //已上传
            UserHelper.setContactList(isUpload: true)
            PrintLog("通讯录上传成功")
            
        }, failure:{ error in
           PrintLog("通讯录上传失败")
        })
    }
    
    /**********七日内有还款一天显示一次***********/
    //获取今天日期
    static func getTodayTime() -> String{
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy.MM.dd"
        
        return dateFormat.string(from: Date())
    }
    
    static func getRepayNoticeCanShow() -> Bool {
        let defaults = UserDefaults()
        let dateStr = defaults.object(forKey: "repayNotice\(self.getUserId())") as? String
        return dateStr == getTodayTime() ? false : true //判断时间是否相同
    }
    
    static func setRepayNoticeTime(){
        let defaults = UserDefaults()
        defaults.set(getTodayTime(), forKey: "repayNotice\(self.getUserId())")
        defaults.synchronize()
    }
    
    //MARK: - 发送验证码时的时间戳
    static func setRandomCodeTimeStamp(){
        let defaults = UserDefaults()
        let timestamp = Date().timeIntervalSince1970
        let times = Int(timestamp)
        defaults.set(times, forKey: "RandomCodeTimeStamp")
        defaults.synchronize()

    }
    
    static func getRandomCodeTimeStamp() -> Int{
        let defaults = UserDefaults()
        let timeStamp = defaults.object(forKey: "RandomCodeTimeStamp") as? Int
        return timeStamp ?? 0
    }
    
    //退出时的剩余时间
    static func setRandomCodeRestTime(_ time: Int){
        let defaults = UserDefaults()
        defaults.set(time, forKey: "RandomCodeRestTime")
        defaults.synchronize()
    }
    
    static func getRandomCodeRestTime() -> Int{
        let defaults = UserDefaults()
        let timeStamp = defaults.object(forKey: "RandomCodeRestTime") as? Int
        return timeStamp ?? 0
    }
    
    //网络状态
    static func setNetStatus(_ status: String){
        let defaults = UserDefaults()
        defaults.set(status, forKey: "netStatus")
        defaults.synchronize()
    }
    
    static func getNetStatus() -> String{
        let defaults = UserDefaults()
        let str = defaults.object(forKey: "netStatus") as? String
        return str ?? ""
    }
    
    //MARK: 一个月一次判断
    //是否经过一个月了（30天）
    static func getIsOneMonthLong() -> Bool {
        let defaults = UserDefaults()
        let oldStamp = defaults.object(forKey: "oneMonth\(self.getUserId())") as? TimeInterval ?? 0.0
        let nowStamp = Date().timeIntervalSince1970
        if (nowStamp - oldStamp) > 30*24*60*60 {
            return true
        }
        return false
    }
    
    static func setIsOneMonthLongNowTime(){
        let defaults = UserDefaults()
        let timeStamp = Date().timeIntervalSince1970
        defaults.set(timeStamp, forKey: "oneMonth\(self.getUserId())")
        defaults.synchronize()
    }
    
    //撤销进行到的步骤
    static func setRevokeStep(_ status: Int){
        let defaults = UserDefaults()
        defaults.set(status, forKey: "revokeStep")
        defaults.synchronize()
    }
    
    static func getRevokeStep() -> Int{
        let defaults = UserDefaults()
        let str = defaults.object(forKey: "revokeStep") as? Int
        return str ?? 0
    }
}

