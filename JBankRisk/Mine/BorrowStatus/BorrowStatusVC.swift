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

///撤销借款订单状态
enum RevokeStatusType{
    case cannot   //不可撤销-1
    case can      //撤销0
    case pay      //支付违约金1
    case upload   //上传退款凭证2
    case reviewing//审核中
    case success  //撤销成功
}

class BorrowStatusVC: UIViewController {
    
    //是否是从推送而来
    var isPush = false
    
    var isHaveData = true //是否加载缺省页
    
    var statusType: OrderStausType = .defaultStatus
    
    //撤销状态
    private var revokeStatus: RevokeStatusType = .cannot
    
    var orderId = ""
    
    private var topViewConstraint: Constraint!
    
    private var repayFinalType:RepayFinalType = .cannotApply
    
    var topHeight: CGFloat = 0 {
        didSet{
            self.topViewConstraint.update(offset: topHeight)
        }
    }
    
    
    //7天内是否有还款
    private var weekPay = 0
    //还款状态0可申请 1申请中 2成功 3还款完成
    private var payFlag = 0{
        didSet{
            switch payFlag {
            case 0:
                repayFinalType = .canApply
            case 1:
                repayFinalType = .applying
            case 2:
                repayFinalType = .success
            case 3:
                repayFinalType = .sucRepayed
            default:
                repayFinalType = .cannotApply
            }
            
            statusView.repayFinalType = repayFinalType
        }
    }
    
    //撤销订单罚金
    private var cancelMoney: Double = 0.00
    //撤销订单的状态
    private var revokeFlag = -1{
        didSet{
            switch revokeFlag {
            case -1:
                revokeStatus = .cannot
            case 0:
                revokeStatus = .can
            case 1:
                revokeStatus = .pay
            case 2:
                revokeStatus = .upload
            case 3:
                revokeStatus = .reviewing
            case 4:
                revokeStatus = .success
            default:
                revokeStatus = .cannot
            }
            
            statusView.revokeState = revokeStatus
        }
    }
    
    var status = "" {
        didSet{
            infoView.isHidden = false
            infoView.showProtocalBtn = false
            switch self.status {
            case "0"://订单完结
                statusType = .finish
                topHeight = 280*UIRate
                infoView.showProtocalBtn = true
            case "2": //审核中
                statusType = .examing
                topHeight = 200*UIRate
            case "3"://满额通过
                statusType = .fullSuccess
                topHeight = 300*UIRate
            case "4"://校验中
                statusType = .checking
                topHeight = 200*UIRate
            case "5"://还款中
                statusType = .repaying
                topHeight = 280*UIRate
                infoView.showProtocalBtn = true
            case "7"://审核未通过
                statusType = .fail
                topHeight = 200*UIRate
            case "8": //上传服务单
                statusType = .upLoadBill
                topHeight = 300*UIRate
            case "9": //补交材料
                statusType = .reUploadData
                topHeight = 300*UIRate
                
            default:
                statusType = .defaultStatus
                infoView.isHidden = true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //如果是从推送而来
        if isPush {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(leftBarButton))
        }
        
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
//            make.height.equalTo(300*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.statusView.snp.bottom)
            make.bottom.equalTo(self.view)
        }
        
        self.mScrollView.addPullRefreshHandler({ [weak self] in
            self?.requestData()
        })
        
        //协议
        infoView.onClickProtocol = {[unowned self] in
            
            //如果是还款中加载已签署的合同
            if  self.statusType == .repaying || self.statusType == .finish {
//                 self.requestListData()
//                let contractVC = ContractViewController()
//                contractVC.viewType = .search
//                contractVC.orderId = self.orderId
//                self.navigationController?.pushViewController(contractVC, animated: true)
                //2017.8.13 弹窗显示，不可以直接看合同
                let popView = PopupProtocalDetailView()
                let popupController = CNPPopupController(contents: [popView])!
                popupController.present(animated: true)
                
                popView.onClickCopy = {_ in
                    popupController.dismiss(animated:true)
                    self.showHint(in: self.view, hint: "复制成功")
                }
                popView.onClickKnow = {_ in
                    popupController.dismiss(animated: true)
                }

            }else {
//                let webView = BaseWebViewController()
//                webView.requestUrl = PC_PROTOCOL_DETAIL + "&orderId=" + (self.orderId)
//                webView.webTitle = "合同详情"
//                self.navigationController?.pushViewController(webView, animated: true)
            }
        }
 }
    //缺省页面
    func setDefaultUI(){
        
        self.navigationItem.title = "借款进度"
        
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
    
    /********如果是从推送而来*******/
    func leftBarButton(){
       self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - 请求数据
    func requestData(){
        
        //默认显示最近一单的
        var params = NetConnect.getBaseRequestParams()
        params["orderId"] = self.orderId //产品id有得话按此ID处理，没有的话后台按最新的产品处理
        
        NetConnect.pc_borrow_status(parameters: params, success: { response in
    
            let json = JSON(response)
            guard json["RET_CODE"] == "000000" else{
                return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
            }
            self.status = json["jstatus"].stringValue
            self.weekPay = json["weekPay"].intValue
            //大于6期才可以申请清算
            if json["term"].intValue > 6{
                 self.payFlag = json["pay_flag"].intValue
            }
            self.revokeFlag = json["revokeStatus"].intValue
            self.cancelMoney = json["penltyMoney"].doubleValue
            self.statusView.failDis = json["descrption"].stringValue
            self.statusView.statusType = self.statusType
            self.refreshOrderUI(json: json["Infos"])
            
            self.mScrollView.stopPullRefreshEver()
            
        }, failure:{ error in
            
            self.mScrollView.stopPullRefreshEver()
            self.showHint(in: self.view, hint: "网络请求失败")
        })
    }

    func refreshOrderUI(json: JSON){
         self.navigationItem.title = json["orderName"].stringValue
         self.infoView.json = json
         self.orderId = json["orderId"].stringValue
    }
    
    //点击按钮
    func onClickButton(){
        
        statusView.onClickButton = {[unowned self] in
            
            switch self.statusType {
            case .finish://还款结束
                
                switch self.revokeStatus {
                case .success:
                    self.popToCancelOrderVC()//跳转到撤销进度界面
                    return
                default:
                    break
                }
                
                switch self.repayFinalType {
                case .sucRepayed:
                    self.popToRepayFinalVC()
                default:
                    self.popToRepayDetailVC() 
                }
            
            case .fullSuccess://全额通过
                let serviceVC = UpLoadServiceBillVC()
                serviceVC.orderId = self.orderId//产品id
                self.navigationController?.pushViewController(serviceVC, animated: true)
            case .repaying://还款中
                
                switch self.revokeStatus {
                case .cannot:
                    break
                case .can:
                   self.showCancelOrderPopupView()
                   return
                default:
                   self.popToCancelOrderVC()//跳转到撤销进度界面
                   return
                }
                
                switch self.repayFinalType {
                case .cannotApply:
                    self.popToRepayDetailVC()
                case .canApply:
                    
                    //七日内有还款
                    if self.weekPay > 0 {
                        self.showPopupView()
                    }else {
                       self.popToRepayFinalVC()
                    }
                case .applying, .success:
                    self.popToRepayFinalVC()
                default:
                    self.popToRepayDetailVC()
                }
               
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
        
        //修改非图片资料
        statusView.onClickTipsButton = { [unowned self] in
            self.navigationController?.pushViewController(BorrowMoneyViewController(), animated: true)
        }

        //还款详情
        statusView.onClickRepayDetailBtn = { [unowned self] in
           self.popToRepayDetailVC()
        }
    }
    
    func showPopupView(){
        let popupView =  PopupRepayFinalTipsView()
        let popupController = CNPPopupController(contents: [popupView])!
        popupController.present(animated: true)
        popupView.onClickSure = { [weak self] _ in
            popupController.dismiss(animated: true)
            
            let repayVC = RepayViewController()
            repayVC.selectInfo = []
            repayVC.flag = 1
            self?.navigationController?.pushViewController(repayVC, animated: true)
            
        }
        popupView.onClickKnow = { _ in
            popupController.dismiss(animated: true)
        }
    }

    //跳转还款详情界面
    func popToRepayDetailVC(){
        let repayDetailVC = RepayDetailViewController()
        repayDetailVC.orderId = self.orderId//产品id
        self.navigationController?.pushViewController(repayDetailVC, animated: true)
    }
    
    //跳转到清算界面
    func popToRepayFinalVC(){
        let vc = RepayFinalVC()
        vc.orderId = self.orderId
        vc.repayFinalType = self.repayFinalType
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //撤销提醒弹窗
    func showCancelOrderPopupView(){
        let popupView =  PopupCancelOrderView()
        popupView.cancelMonay = self.cancelMoney
        let popupController = CNPPopupController(contents: [popupView])!
        popupController.present(animated: true)
        popupView.onClickSure = { [weak self] _ in
            popupController.dismiss(animated: true)
            
            self?.cancelOrderRequestData()
        }
        popupView.onClickCancel = { _ in
            popupController.dismiss(animated: true)
        }

    }
    
    //跳转到撤销订单界面
    func popToCancelOrderVC(){
        let vc = CancelOrderVC()
        vc.orderId = self.orderId;
        self.navigationController?.pushViewController(vc, animated: true)
    }
    /* 2017.8.13 弃用
    //MARK:- 合同 请求数据
    func requestListData(){
        //添加HUD
        self.showHud(in: self.view)
        var params = NetConnect.getBaseRequestParams()
        params["orderId"] = self.orderId
        
        NetConnect.other_contract_list(parameters: params, success:
            { response in
                self.hideHud()
                let json = JSON(response)
                guard json["RET_CODE"] == "000000" else{
                    return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
                }
                
                self.seeContract(contractId: json["backList"].arrayValue[0]["contractId"].stringValue)
                
        }, failure: {error in
            //隐藏HUD
            self.hideHud()
        })
    }
    */
    //合同查看
    func seeContract(contractId: String){
        var params = NetConnect.getBaseRequestParams()
        params["orderId"] = self.orderId
        params["contractId"] = contractId
        
        NetConnect.other_contract_search(parameters: params, success:
            { response in
                //隐藏HUD
                self.hideHud()
                let json = JSON(response)
                guard json["RET_CODE"] == "000000" else{
                    return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
                }
                YHTSdk.setToken(json["backInfo"]["token"].stringValue)
                let YHTVC = YHTContractContentViewController.instance(withContractID: json["backInfo"]["contractId"].numberValue)
                YHTVC?.titleStr = "合同查看"
                self.navigationController?.pushViewController(YHTVC!, animated: true)
                
        }, failure: {error in
            //隐藏HUD
            self.hideHud()
        })
    }
    
    //撤销订单接口
    func cancelOrderRequestData(){
        var params = NetConnect.getBaseRequestParams()
        params["orderId"] = self.orderId
        
        NetConnect.pc_cancel_order(parameters: params, success:
            { response in
                //隐藏HUD
                self.hideHud()
                let json = JSON(response)
                guard json["RET_CODE"] == "000000" else{
                    return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
                }
                
                self.showHint(in: self.view, hint: "撤销成功")
                self.popToCancelOrderVC()
                
        }, failure: {error in
            //隐藏HUD
            self.hideHud()
        })
    }
}
