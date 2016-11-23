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
                infoView.isHidden = true
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
                infoView.isHidden = true
            case "7"://审核未通过
                statusType = .fail
                topHeight = 200*UIRate
                infoView.isHidden = false
            case "8": //上传服务单
                statusType = .upLoadBill
                
            case "9": //补交材料
                statusType = .reUploadData
                topHeight = 280*UIRate
                infoView.isHidden = false
            default:
                statusType = .defaultStatus
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
    
    //Nav
    func setNavUI(){
        self.view.addSubview(navHoldView)
        self.navHoldView.addSubview(navImageView)
        self.navHoldView.addSubview(navTextLabel)
        self.navHoldView.addSubview(navDivideLine)
        
        navHoldView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(64)
            make.centerX.equalTo(self.view)
            make.top.equalTo(0)
        }
        
        navImageView.snp.makeConstraints { (make) in
            make.width.equalTo(13)
            make.height.equalTo(21)
            make.left.equalTo(19)
            make.centerY.equalTo(10)
        }
        
        navTextLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(navImageView)
        }
        
        navDivideLine.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(navHoldView)
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
        
        self.view.addSubview(statusView)
        self.view.addSubview(infoView)
        
        statusView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            self.topViewConstraint = make.height.equalTo(topHeight).constraint
            make.centerX.equalTo(self.view)
            make.top.equalTo(64)
        }
        
        infoView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(300*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.statusView.snp.bottom)
        }
        
        //协议
        infoView.onClickProtocol = {
            let webView = BaseWebViewController()
            webView.requestUrl = PC_PROTOCOL_DETAIL + "&orderId=" + (self.orderInfo?["order_id"].stringValue)!
            self.navigationController?.pushViewController(webView, animated: true)
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
    private lazy var navHoldView: UIView = {
        let holdView = UIView()
        holdView.backgroundColor = UIColor.white
        return holdView
    }()
    
    //图片
    private lazy var navImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "navigation_left_back_13x21")
        return imageView
    }()
    
    private lazy var navTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 18)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        return label
    }()
    
    //分割线
    private lazy var navDivideLine: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
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
        
        var params = NetConnect.getBaseRequestParams()
        params["userId"] = UserHelper.getUserId()!
        
        NetConnect.pc_borrow_status(parameters: params, success: { response in
            //隐藏HUD
            self.hideHud()
            let json = JSON(response)
            guard json["RET_CODE"] == "000000" else{
                return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
            }
            
            self.orderInfo = json["Infos"]
            
            self.refreshOrderUI(json: json["Infos"])
            self.status = json["jstatus"].stringValue
            self.statusView.failDis = json["descrption"].stringValue
            self.statusView.statusType = self.statusType
            
        }, failure:{ error in
            //隐藏HUD
            self.hideHud()
        })
    }

    func refreshOrderUI(json: JSON){
         self.title = json["orderName"].stringValue
         navTextLabel.text = self.title
         self.infoView.json = json
         self.orderId = json["order_id"].stringValue
    }
    
    //点击按钮
    func onClickButton(){
        
        statusView.onClickButton = {
            
            switch self.statusType {
            case .finish:
                break
            
            case .fullSuccess://全额通过
                let serviceVC = UpLoadServiceBillVC()
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
            case .reUploadData://被驳回
                let roleType = RoleType(rawValue: UserHelper.getUserRole()!)!
                let dataVC = DataViewController(roleType: roleType, isReupload: true)
               self.navigationController?.pushViewController(dataVC, animated: true)
                
            default:
                break
            }
        }
    }
}
