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
    case sucRepaying  //通过－未还款、还款中
    case sucRepayed   //通过－已还清、已结束
}


class RepayFinalVC: UIViewController {

    var repayFinalType: RepayFinalType = .canApply
    //还款id(需要从前一个界面传过来)
    var repaymentId = ""
    
    //产品id
    var orderId = ""
    ///是否从还款界面而来
    var isFromRepayVC = false
    
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
    
    //去还款
    func gotoRepay(){
        
        detailView.onClickNextStepBtn = {[unowned self] _ in
            
            //是从还款界面而来
            if self.isFromRepayVC{
                _ = self.navigationController?.popViewController(animated: true)
                return
            }
            
            let repayVC = RepayBillSelectVC()
            repayVC.periodInfo = (self.orderId, self.repaymentId)
            self.navigationController?.pushViewController(repayVC, animated: true)
        }
    }
    
    //注意事项
    func rightNavigationBarBtnAction(){
         self.navigationController?.pushViewController(RepayFinalNoticeVC(), animated: true)
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
        let penalty = "违约金:     " + toolsChangeMoneyStyle(amount: json["penalty"].doubleValue) + "元"
        //审核时间
        let overDay = "审核时间:    " + json["penalty_day"].stringValue + "天"
        //逾期罚金
        let overFee = "逾期罚金:    " + toolsChangeMoneyStyle(amount: json["penalty_amt"].doubleValue + json["demurrage"].doubleValue) + "元"
        
        let backTime = json["back_stamp"].stringValue
        
        switch self.repayFinalType {
        case .cannotApply:
            if backTime.characters.count > 0 {
                let backDate = "还款时间:    " + toolsChangeDataStyle(toDateStyle: json["back_stamp"].stringValue)
                self.detailView.dataArray = [repayTerm, restRepay, penalty]
            }else {
                self.detailView.dataArray = [repayTerm, restRepay, ""]
            }
            
        case .canApply:
            self.detailView.dataArray = [repayTerm, restRepay, penalty,overDay]
        case .applying:
            self.detailView.dataArray = [repayTerm, restRepay, penalty]
        default:
            break
        }
        
    }
}
