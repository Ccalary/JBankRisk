//
//  HomeViewController.swift
//  JBankRisk
//
//  Created by 曹后红 on 16/10/8.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//  首页

import UIKit
import SnapKit
import SwiftyJSON
import Alamofire
import MJRefresh

let homeCellID = "HomeTableViewCell"

class HomeViewController: UIViewController, UIGestureRecognizerDelegate{
    
    var bannerView: CyclePictureView! //图片轮播
    var imageArray:[String]? = [""] //储存所有照片
    
    //汇款信息
    var alertInfo:JSON?
    
    //cell数据
    var cellDataArray: [Dictionary<String,String>]? = [["":""],["":""],["":""]]

    //目前的步数
    var currentStep = 0
    //最新产品的orderId
    var orderId = ""
    
    //还款状态判断
    var mJstatus = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //启动滑动返回（swipe back）
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        //请求版本更新
        self.requestUpdataVersion()
        
        //读取缓存
        self.getDataFromCache()
        setup()
        initBannerImage()
        
        //添加HUD
        self.showHud(in: self.view)

    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
         self.requestHomeData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
         super.viewWillAppear(animated)
         self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //是否允许手势
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if (gestureRecognizer == self.navigationController?.interactivePopGestureRecognizer) {
            //只有二级以及以下的页面允许手势返回
            return (self.navigationController?.viewControllers.count)! > 1
        }
        return true
    }
    
    //基本设置
    func setup(){
        self.view.addSubview(aTableView)
       
        aTableView.snp.makeConstraints { (mark) in
            mark.width.equalTo(self.view)
            mark.height.equalTo(SCREEN_HEIGHT - TabBarHeight)
            mark.top.equalTo(-StatusBarHeight)
        }
        self.aTableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            self?.requestHomeData()
        })
    }
    
   private lazy var aTableView: UITableView = {
       
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: homeCellID)
        //tableView 单元格分割线的显示
        tableView.separatorInset = UIEdgeInsets.zero
        return tableView
    }()
    
    //MARK: - 初始化banner轮播图
    func initBannerImage(){
        
        //图片轮播
        bannerView = CyclePictureView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 220*UIRate), imageArray:imageArray!)
        //bannerView.delegate = self
        self.aTableView.tableHeaderView = bannerView
    }
    
    func requestHomeData(){
       
        var params = NetConnect.getBaseRequestParams()
        params["userId"] = UserHelper.getUserId()
        NetConnect.bm_home_url(parameters: params, success:
            { response in
                //隐藏HUD
                self.hideHud()
                self.aTableView.mj_header.endRefreshing()
                let json = JSON(response)
                guard json["RET_CODE"] == "000000" else{
                    return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
                }
                //第一个为1，依次类推
                self.currentStep = json["flag"].intValue
                
                //如果录入大于1，则表明展示过芝麻信用授权界面
                if (self.currentStep > 1) {
                    UserHelper.setIsShowedZhiMa(true)
                }else {
                    UserHelper.setIsShowedZhiMa(false)
                }
                
                //还款状态
                self.mJstatus = json["jstatus"].stringValue
                //最新一单的id
                self.orderId = json["orderId"].stringValue
                
                //7日内有回款（一天只弹出一次）
                self.alertInfo = json["alertMap"]
                self.showTips()
                
                if UserHelper.getUserId() != "" {
                    
                     self.getTheUploadProgree(flag: json["flag"].stringValue,userType:json["userType"].stringValue)
                    
                    self.borrowStatusNotice()//进度弹窗
                }
                self.imageArray = json["bannnerList"].arrayObject as! [String]?
                
                self.cellDataArray = json["list"].arrayObject as? [Dictionary<String, String>]
                UserHelper.setHomeImageData(imageArray: self.imageArray!)
                UserHelper.setHomeCellDataArray(cellArray: self.cellDataArray!)
                self.showData()
                
        }, failure: {error in
            //隐藏HUD
            self.hideHud()
            self.aTableView.mj_header.endRefreshing()
            self.showHint(in: self.view, hint: "网络请求失败")
        })
    }
    
    func showData(){
        self.initBannerImage()
        self.aTableView.reloadData()
    }
    
    //读取首页缓存
    func getDataFromCache(){
        self.imageArray = UserHelper.getHomeImageData() ?? [""]
        self.cellDataArray = UserHelper.getHomeCellDataArray()
    }
    
    //老用户判断进程
    func getTheUploadProgree(flag: String, userType: String){
        //flag 进度  1－ 2- 3- 4- 5-   9完成
        UserHelper.setIsReject(isReject: false)
        
        if flag == "2"{
            UserHelper.setIdentity(isUpload: true)
        }else if flag == "3"{
            UserHelper.setIdentity(isUpload: true)
            UserHelper.setProduct(isUpload: true)
        }else if flag == "4"{
            UserHelper.setIdentity(isUpload: true)
            UserHelper.setProduct(isUpload: true)
            self.setUpload(with: userType)
            
        }else if flag == "5"{
            UserHelper.setIdentity(isUpload: true)
            UserHelper.setProduct(isUpload: true)
            UserHelper.setContact(isUpload: true)
            self.setUpload(with: userType)
            
        }else if flag == "9" {
             //如果第一单进入还款中，则清空录入信息(只保留身份信息)
            UserHelper.setIdentity(isUpload: true)
            if self.mJstatus == "0" || self.mJstatus == "5" || self.mJstatus == "-1" || self.mJstatus == "7" { //0完结 5还款中,-1撤销成功,7审核未通过。 可以重新进单
                self.currentStep = 2
                UserHelper.setProduct(isUpload: false)
                UserHelper.setSchool(isUpload: false)
                UserHelper.setWork(isUpload: false)
                UserHelper.setIncome(isUpload: false)
                UserHelper.setContact(isUpload: false)
                UserHelper.setData(isUpload: false)
                UserHelper.setAllFinishIsUpload(isUpload: false)
                
            }else if self.mJstatus == "99" { //录入中
                UserHelper.setProduct(isUpload: true)
                self.setUpload(with: userType)
                UserHelper.setContact(isUpload: true)
                UserHelper.setData(isUpload: false)
                UserHelper.setAllFinishIsUpload(isUpload: false)
            }else if self.mJstatus == "9"{ //被驳回(身份信息和附件上传不可更改，其它可以更改)
                UserHelper.setIsReject(isReject: true)
                UserHelper.setHomeNewOneOrderId(self.orderId)//保存orderId
                UserHelper.setProduct(isUpload: true)
                self.setUpload(with: userType)
                UserHelper.setContact(isUpload: true)
                UserHelper.setData(isUpload: true)
                UserHelper.setAllFinishIsUpload(isUpload: true)
                
            }else {
                UserHelper.setProduct(isUpload: true)
                self.setUpload(with: userType)
                UserHelper.setContact(isUpload: true)
                UserHelper.setData(isUpload: true)
                UserHelper.setAllFinishIsUpload(isUpload: true)
            }
        }
    }
    //进度弹窗
    func borrowStatusNotice(){
        
        guard self.mJstatus != "",
              self.mJstatus != UserHelper.getBorrowStatus()
        else {
            return
        }
        switch mJstatus {
            
        case "0","2","3","4","5","7","8","9":
            UserHelper.setBorrow(status: self.mJstatus)
            //根据status显示
            let popupView = PopupProgressView(status: self.mJstatus)
            let popupController = CNPPopupController(contents: [popupView])!
            popupController.present(animated: true)
            
            popupView.onClickSure = {_ in
                popupController.dismiss(animated:true)
            }

        default:
            break
        }
    }
    
    //根据角色设置
    func setUpload(with userType: String){
        switch userType {// 1-学生 2- 白领 3－ 自由族 4-未选择
        case "1":
            UserHelper.setSchool(isUpload: true)
        case "2":
            UserHelper.setWork(isUpload: true)
        case "3":
            UserHelper.setIncome(isUpload: true)
        default:
            break
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource,CyclePictureViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: homeCellID) as! HomeTableViewCell
    
        cell.topTextLabel.text = cellDataArray?[indexPath.row]["show1"]
        cell.bottomTextLabel.text = cellDataArray?[indexPath.row]["show2"]
        switch indexPath.row {
        case 0:
            cell.leftImageView.image = UIImage(named: "home_loan_icon_50x50")
            cell.rightTextLabel.text = "我要借款"
            cell.rightImageView.image = UIImage(named: "home_right_arrow_7x12")
            break
        case 1:
            cell.leftImageView.image = UIImage(named: "home_progress_icon_50x50")
            cell.rightTextLabel.text = "进度查询"
            cell.rightImageView.image = UIImage(named: "home_right_arrow_7x12")
            break
        case 2:
            cell.leftImageView.image = UIImage(named: "home_repayment_icon_50x50")
            cell.rightTextLabel.text = "我要还款"
            cell.rightImageView.image = UIImage(named: "home_right_arrow_7x12")
            break
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80*UIRate
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //登录后才能进入
        guard UserHelper.isLogin() else {
            let loginVC = LoginViewController()
            self.navigationController?.pushViewController(loginVC, animated: true)
            return
        }
        
        switch indexPath.row {
        case 0:
            //保证有userId 和 角色已选
            guard (UserHelper.getUserId() != "") && (UserHelper.getUserRole() != nil) else {
                
                let popupView =  PopupSelectRoleView(currentIndex: -1)
                let popupController = CNPPopupController(contents: [popupView])!
                popupController.theme.presentationStyle = .slideInFromRight
                popupController.theme.dismissesOppositeDirection = false
                popupController.theme.animationDuration = 0.6
                popupController.present(animated: true)
                popupView.onClickCloseBtn = { _ in
                    popupController.dismiss(animated: true)
                }
                popupView.onClickSelect = {[unowned self] role in
                    popupController.dismiss(animated: true)
                    UserHelper.setUserRole(role: role.rawValue)
                    let borrowMoneyVC = BorrowMoneyViewController()
                    self.navigationController?.pushViewController(borrowMoneyVC, animated: false)
                }
                return
        }
            let borrowMoneyVC = BorrowMoneyViewController()
            borrowMoneyVC.currentIndex = self.currentStep - 1
            self.navigationController?.pushViewController(borrowMoneyVC, animated: false)
            
        case 1:
    
            let borrowStatusVC = BorrowStatusVC()
            borrowStatusVC.orderId = self.orderId
            
            //99 为录入中 加载缺省页
            if self.mJstatus == "99" || self.mJstatus.isEmpty {
                borrowStatusVC.isHaveData = false
            }else {
                borrowStatusVC.isHaveData = true
            }
            self.navigationController?.pushViewController(borrowStatusVC, animated: true)
        case 2:
            let repayDetailVC = RepayBillViewController()
            self.navigationController?.pushViewController(repayDetailVC, animated: true)
        default:
            break
        }
    }
    
    //请求版本更新
    func requestUpdataVersion(){
        var params = NetConnect.getBaseRequestParams()
        params["versionCode"] = APP_VERSION_CODE
        
        NetConnect.other_updata_version(parameters: params, success:
            { response in
                let json = JSON(response)
                guard json["RET_CODE"] == "000000" else{
                    return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
                    }
                
                //0-无更新 1-有更新 2-强制更新
                if json["vjstatus"].stringValue == "1" || json["vjstatus"].stringValue == "2" {
                    let popupView =  PopupNewVersionView(disText: json["updateDesc"].stringValue)
                    let popupController = CNPPopupController(contents: [popupView])!
                    popupController.present(animated: true)
                    popupView.onClickCancle = { _ in
                        
                        if json["vjstatus"].stringValue == "2" {
                            //强制更新，弹窗消不去
                        }else {
                             popupController.dismiss(animated: true)
                        }
                    }
                    //升级
                    popupView.onClickSure = { _ in
                        let appstoreUrl = json["updateUrl"].stringValue
                        let url = URL(string: appstoreUrl)
                        if let url = url {
                             UIApplication.shared.openURL(url)
                        }
                    }
                }
        }, failure: {error in
            
        })
    }
    
    //MARK: - CyclePictureViewDelegate的方法(点击跳转)
    func cyclePictureSkip(To index: Int) {
        //        let bannerUrlVC = BaseWebViewController()
        //        bannerUrlVC.requestUrl = self.urlArray?[index] as? String
        //        self.navigationController?.pushViewController(bannerUrlVC, animated: false
        //        )
    }
}

extension HomeViewController {
    
    //弹出窗口（如果有的话一天只一次）
    func showTips(){
        
        if let alertInfo = self.alertInfo {
            if !alertInfo.isEmpty && UserHelper.getRepayNoticeCanShow() {
                
                let popupView =  PopupRepaymentTipView()
                let popupController = CNPPopupController(contents: [popupView])!
                popupView.dicInfo = alertInfo
                popupController.present(animated: true)
                popupView.onClickSure = { _ in
                    popupController.dismiss(animated: true)
                }
                //保存弹出时间
                UserHelper.setRepayNoticeTime()
            }
        }
    }
}
