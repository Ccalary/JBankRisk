//
//  BorrowStatusVC.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/18.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit
import SwiftyJSON
import SnapKit

///借款状态
enum OrderStausType {
    case finish      //订单完结
    case examing     //审核中
    case fullSuccess //满额通过
    case checking    //校验中
    case repaying    //还款中
    case fail        //审核未通过
    case upLoadBill  //上传服务单
    case reUploadData//补交材料
    case defaultStatus //缺省
}

class BorrowStatusVC: UIViewController {

    var orderInfo: JSON!
    
    var isHaveData = true //是否加载缺省页
    
    var statusType: OrderStausType = .defaultStatus
    
    var orderId = ""
    
    var topViewConstraint: Constraint!
    
    var topHeight: CGFloat = 0 {
        didSet{
            self.topViewConstraint.update(offset: topHeight)
        }
    }
    
    var status = "" {
        didSet{
            switch self.status {
            case "0"://订单完结
                statusType = .finish
                infoView.isHidden = false
                topHeight = 280*UIRate
            case "2": //审核中
                statusType = .examing
                infoView.isHidden = false
                topHeight = 200*UIRate
            case "3"://满额通过
                statusType = .fullSuccess
                infoView.isHidden = false
                topHeight = 280*UIRate
            case "4"://校验中
                statusType = .checking
                infoView.isHidden = false
                topHeight = 200*UIRate
            case "5"://还款中
                statusType = .repaying
                topHeight = 280*UIRate
                infoView.isHidden = false
            case "7"://审核未通过
                statusType = .fail
                topHeight = 200*UIRate
                infoView.isHidden = false
            case "8": //上传服务单
                statusType = .upLoadBill
                topHeight = 280*UIRate
                infoView.isHidden = false
            case "9": //补交材料
                statusType = .reUploadData
                topHeight = 280*UIRate
                infoView.isHidden = false
            default:
                statusType = .defaultStatus
                infoView.isHidden = true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if isHaveData {
            self.requestData()
        }
    }
    
    //nav
    func setNavUI(){
        self.view.addSubview(navHoldView)
        navHoldView.navTextLabel.text = self.title
        
        navHoldView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(64)
            make.centerX.equalTo(self.view)
            make.top.equalTo(0)
        }
    }
    
    func setupUI(){
        self.view.backgroundColor = defaultBackgroundColor
       
        if isHaveData {
            self.setNormalUI()
            self.onClickButton()
        }else {
            self.setDefaultUI()
        }
    }
    
    //正常页面
    func setNormalUI(){
        self.title = ""
        self.setNavUI()
        
        self.view.addSubview(mScrollView)
        
        self.mScrollView.addSubview(statusView)
        self.mScrollView.addSubview(infoView)
        
        mScrollView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(SCREEN_HEIGHT - 64)
            make.centerX.equalTo(self.view)
            make.top.equalTo(64)
        }
        
        mScrollView.contentSize = CGSize(width: SCREEN_WIDTH, height: 667*UIRate - 64 + 1)
        
        statusView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            self.topViewConstraint = make.height.equalTo(topHeight).constraint
            make.centerX.equalTo(self.view)
            make.top.equalTo(0)
        }
        
        infoView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(300*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.statusView.snp.bottom)
        }
        
        self.mScrollView.addPullRefreshHandler({ [weak self] in
            self?.requestData()
            self?.mScrollView.stopPullRefreshEver()
        })
        
        //协议
        infoView.onClickProtocol = {[unowned self] in
            
            //如果是还款中加载已签署的合同
            if  self.statusType == .repaying || self.statusType == .checking {
                let contractVC = ContractViewController()
                contractVC.viewType = .search
                contractVC.orderId = self.orderId
                self.navigationController?.pushViewController(contractVC, animated: true)

            }else {
                let webView = BaseWebViewController()
                webView.requestUrl = PC_PROTOCOL_DETAIL + "&orderId=" + (self.orderId)
                webView.webTitle = "合同详情"
                self.navigationController?.pushViewController(webView, animated: true)
            }
        }
 }
    //缺省页面
    func setDefaultUI(){
        
        self.title = "借款进度"
        self.setNavUI()
        
        self.view.addSubview(defaultProView)
        self.view.addSubview(defaultView)
        
        defaultProView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(70*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(64 + 10*UIRate)
        }
        
        defaultView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(SCREEN_HEIGHT - 64)
            make.centerX.equalTo(self.view)
            make.top.equalTo(defaultProView.snp.bottom)
        }
    }
    
    private lazy var mScrollView: UIScrollView = {
        let holdView = UIScrollView()
        holdView.backgroundColor = UIColor.clear
        return holdView
    }()
    
    /*******缺省页*******/
    private lazy var defaultProView: BorrowProgressView = {
        let holdView = BorrowProgressView()
        holdView.backgroundColor = UIColor.white
        return holdView
    }()
    
    private lazy var defaultView: BorrowDefaultView = {
        let holdView = BorrowDefaultView(viewType: BorrowDefaultView.BorrowDefaultViewType.applyStatus1)
        return holdView
    }()
    
    /***Nav隐藏时使用***/
    private lazy var navHoldView: NavigationView = {
        let holdView = NavigationView()
        return holdView
    }()
    
    /*********/
    private lazy var statusView: BorrowStatusView = {
        let holdView = BorrowStatusView()
        return holdView
    }()
    
    private lazy var infoView: BorrowInfoView = {
        let holdView = BorrowInfoView()
        holdView.isHidden = true
        return holdView
    }()
    
    //MARK: - 请求数据
    func requestData(){
        //添加HUD
        self.showHud(in: self.view, hint: "加载中...")
        
        //默认显示最近一单的
        var params = NetConnect.getBaseRequestParams()
        params["userId"] = UserHelper.getUserId()!
        params["orderId"] = self.orderId //产品id有得话按此ID处理，没有的话后台按最新的产品处理
        
        NetConnect.pc_borrow_status(parameters: params, success: { response in
            //隐藏HUD
            self.hideHud()
            let json = JSON(response)
            guard json["RET_CODE"] == "000000" else{
                return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
            }
            
            self.orderInfo = json["Infos"]
            
            self.refreshOrderUI(json: json["Infos"])
            
            
        }, failure:{ error in
            //隐藏HUD
            self.hideHud()
        })
    }

    func refreshOrderUI(json: JSON){
         self.title = json["orderName"].stringValue
         navHoldView.navTextLabel.text = self.title
         self.infoView.json = json
         self.status = json["jstatus"].stringValue
         self.statusView.failDis = json["descrption"].stringValue
         self.statusView.statusType = self.statusType
         self.orderId = json["orderId"].stringValue
    }
    
    //点击按钮
    func onClickButton(){
        
        statusView.onClickButton = {[unowned self] in
            
            switch self.statusType {
            case .finish:
                break
            
            case .fullSuccess://全额通过
                let serviceVC = UpLoadServiceBillVC()
                serviceVC.orderId = self.orderId//产品id
                self.navigationController?.pushViewController(serviceVC, animated: true)
            case .repaying://还款中
                let repayDetailVC = RepayDetailViewController()
                repayDetailVC.orderId = self.orderId//产品id
                self.navigationController?.pushViewController(repayDetailVC, animated: true)
            case .fail://重新申请
                //下版本开启
                /*
                let borrowMoneyVC = BorrowMoneyViewController()
                borrowMoneyVC.currentIndex = 0
                self.navigationController?.pushViewController(borrowMoneyVC, animated: false)
                  */
                break
            case .upLoadBill: //重新上传服务单
                 let billVC = UpLoadServiceBillVC()
                 billVC.orderId = self.orderId//产品id
                 self.navigationController?.pushViewController(billVC, animated: true)
            case .reUploadData://被驳回
                let dataVC = DataReuploadVC()
                self.navigationController?.pushViewController(dataVC, animated: true)
                
            default:
                break
            }
        }
    }
}
