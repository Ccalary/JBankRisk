//
//  RepayFinalVC.swift
//  JBankRisk
//
//  Created by caohouhong on 17/7/27.
//  Copyright © 2017年 jingjinsuo. All rights reserved.
//  账单清算

import UIKit
import SwiftyJSON

enum RepayFinalType { //账单清算状态
    case cannotApply  //不可申请
    case canApply     // 可申请
    case applying     //申请中
    case success      //通过
//    case sucRepaying  //通过－未还款、还款中
//    case sucRepayed   //通过－已还清、已结束
}


class RepayFinalVC: UIViewController {

    var repayFinalType: RepayFinalType = .canApply
    //产品id
    var orderId = ""
    ///是否从还款界面而来
    var isFromRepayVC = false
    
    //立即支付传值
    private var selectInfo: [Dictionary<String,Any>] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.gotoRepay()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.requestData()
    }
    
    func setupUI(){
        self.navigationItem.title = "账单清算"
        self.view.backgroundColor = defaultBackgroundColor
        self.navigationController!.navigationBar.isTranslucent = true
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"nav_notice_20x20"), style: .plain, target: self, action: #selector(rightNavigationBarBtnAction))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColorHex("666666")
        
        self.view.addSubview(topImageView)
        self.topImageView.addSubview(moneyTextLabel)
        self.topImageView.addSubview(moneyLabel)
        
        self.view.addSubview(detailView)
        
        topImageView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(156*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(64)
        }
        
        moneyTextLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(topImageView).offset(40*UIRate)
        }
        
        moneyLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(moneyTextLabel.snp.bottom).offset(25*UIRate)
        }
        
        detailView.snp.makeConstraints { (make) in
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(300)
            make.left.equalTo(0)
            make.top.equalTo(topImageView.snp.bottom)
        }
    }
    
    //图片
    private lazy var topImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "m_banner_image4_375x156")
        return imageView
    }()
    
    private lazy var moneyTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.text = "清算后需支付(元)"
        return label
    }()
    
    private lazy var moneyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 36*UIRate)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.text = "0.00"
        return label
    }()
    
    private lazy var detailView: RepayFinalDetailView = {
        let holdView = RepayFinalDetailView(viewType: self.repayFinalType)
        return holdView
    }()
    
    //按钮点击
    func gotoRepay(){
        
        detailView.onClickNextStepBtn = {[unowned self] _ in
         
            switch self.repayFinalType {
            case .canApply:
                self.repayFinalApplyWithFlag(0)
            case .applying:
                self.repayFinalApplyWithFlag(1)
            case .success:
                let vc = RepayViewController()
                vc.selectInfo = self.selectInfo
                vc.flag = 2
                self.navigationController?.pushViewController(vc, animated: true)
                break
            default:
                break
            }
        }
    }
    
    //注意事项
    func rightNavigationBarBtnAction(){
         self.navigationController?.pushViewController(RepayFinalNoticeVC(), animated: true)
    }
    
    //MARK: - 申请（取消）结算
    func repayFinalApplyWithFlag(_ payFlag:Int){
     
        var params = NetConnect.getBaseRequestParams()
        params["orderId"] = self.orderId//产品id
        params["pay_flag"] = payFlag //可申请传0， 取消申请传1
        NetConnect.pc_repay_final_apply(parameters: params, success: { (response) in
            
            //隐藏HUD
            self.hideHud()
            let json = JSON(response)
            guard json["RET_CODE"] == "000000" else{
                return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
            }
            
            self.requestData()
            
        }) { (error) in
            //隐藏HUD
            self.hideHud()
        }
    }
    
    //MARK: - 请求数据
    func requestData(){
        //添加HUD
        self.showHud(in: self.view, hint: "加载中...")
        
        var params = NetConnect.getBaseRequestParams()
        params["orderId"] = self.orderId//产品id
        NetConnect.pc_repay_final(parameters: params, success: { response in
            //隐藏HUD
            self.hideHud()
            let json = JSON(response)
            guard json["RET_CODE"] == "000000" else{
                return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
            }
            
            self.refreshUI(json: json["backMap"])
            
        }, failure:{ error in
            //隐藏HUD
            self.hideHud()
        })
    }
    
    func refreshUI(json: JSON){
        
        moneyLabel.text =  toolsChangeMoneyStyle(amount: json["payTotal"].doubleValue)
        
        //清算期数
        let repayTerm = "清算期数:    \(json["restTerm"].intValue)期"
        //清算本金
        let restRepay = "清算本金:    " + toolsChangeMoneyStyle(amount: json["needPay"].doubleValue) + "元"
        //违约金
        let penalty = "违约金:        " + toolsChangeMoneyStyle(amount: json["penalty"].doubleValue) + "元"
        //审核时间
        let auditTime = "审核时间:    3日内"
        
        let endTime = "还款截止:    \(toolsChangeDateStyle(toYYYYMMDD: json["cutOffTime"].stringValue))"
        //审核状态
        let payFlag = json["pay_flag"].intValue
        var payState = ""
        switch payFlag {
        case 0:
            self.repayFinalType = .canApply
        case 1:
            payState = "结算申请中"
            self.repayFinalType = .applying
        case 2:
            self.repayFinalType = .success
            payState = "支付结算金额"
            selectInfo.removeAll()
            var dic = [String:Any]()
            dic["orderId"] = self.orderId
            dic["repayment_id"] = json["repayment_id"].stringValue
            selectInfo.append(dic)
        default:
            break
        }
        let auditState = "订单状态:    \(payState)"
        
        switch self.repayFinalType {
        case .canApply:
            self.detailView.dataArray = [repayTerm, restRepay, penalty, auditTime]
        case .applying:
            self.detailView.dataArray = [repayTerm, restRepay, penalty, auditTime, auditState]
        case .success:
            self.detailView.dataArray = [repayTerm, restRepay, penalty, endTime, auditState]
        default:
            break
        }
        //设置状态更改按钮
        self.detailView.viewType = self.repayFinalType
        
    }
}
