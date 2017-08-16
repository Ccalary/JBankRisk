//
//  RepayPeriodDetailVC.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/13.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//  还款账单（还款明细）

import UIKit
import SwiftyJSON

class RepayPeriodDetailVC: UIViewController {

    var repayStatusType: RepayStatusType = .finish
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
        self.navigationItem.title = "还款明细"
        self.view.backgroundColor = defaultBackgroundColor
        self.navigationController!.navigationBar.isTranslucent = true
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "关闭", style: UIBarButtonItemStyle.plain, target: self, action: #selector(rightNavigationBarBtnAction))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColorHex("666666")
        
        self.view.addSubview(topImageView)
        self.topImageView.addSubview(titleTextLabel)
        self.topImageView.addSubview(divideLine1)
        self.topImageView.addSubview(moneyTextLabel)
        self.topImageView.addSubview(moneyLabel)
        
        self.view.addSubview(detailView)
        
        topImageView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(156*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(64)
        }
        
        titleTextLabel.snp.makeConstraints { (make) in
            make.height.equalTo(35*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(0)
        }
        
        divideLine1.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(35*UIRate)
        }

        moneyTextLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(topImageView.snp.top).offset(70*UIRate)
        }
        
        moneyLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(topImageView.snp.top).offset(110*UIRate)
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
        imageView.image = UIImage(named: "m_banner_image3_375x156")
        return imageView
    }()
    
    private lazy var titleTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColor.white
        return label
    }()
    
    //分割线
    private lazy var divideLine1: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.white
        return lineView
    }()
    
    private lazy var moneyTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.text = "已还款(元)"
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

    private lazy var detailView: RepayPeriodDetailView = {
        let holdView = RepayPeriodDetailView(viewType: self.repayStatusType)
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
            repayVC.payOrderId = self.orderId
            repayVC.periodInfo = (self.orderId, self.repaymentId)
            self.navigationController?.pushViewController(repayVC, animated: true)
        }
    }
    
    //后退两个界面
    func rightNavigationBarBtnAction(){
        
      let i = self.navigationController?.viewControllers.count ?? 0
        if i >= 3 {
             _ = self.navigationController?.popToViewController((self.navigationController?.viewControllers[(self.navigationController?.viewControllers.count)! - 3])! , animated: true)
        }else {
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
    
    //MARK: - 请求数据
    func requestData(){
        //添加HUD
        self.showHud(in: self.view, hint: "加载中...")
        
        var params = NetConnect.getBaseRequestParams()
        params["userId"] = UserHelper.getUserId()
        params["repayment_id"] = self.repaymentId
        NetConnect.pc_repayment_month_detail(parameters: params, success: { response in
            //隐藏HUD
            self.hideHud()
            let json = JSON(response)
            guard json["RET_CODE"] == "000000" else{
                return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
            }
            
            self.refreshUI(json: json["detail"])
            
        }, failure:{ error in
            //隐藏HUD
            self.hideHud()
        })
    }
    
    func refreshUI(json: JSON){
        
        orderId = json["orderId"].stringValue
        //清算
        if json["term"].intValue == 100 {
            titleTextLabel.text = json["orderName"].stringValue + "账单清算"
        }else{
            titleTextLabel.text = json["orderName"].stringValue + "第" + json["term"].stringValue + "期"
        }
       
        moneyLabel.text =  toolsChangeMoneyStyle(amount: json["pay_amt_total"].doubleValue)
        
        //应还本息
        let shouldRepay = "应还本息:    " + toolsChangeMoneyStyle(amount: json["amt_total"].doubleValue) + "元"
        //剩余未还 = 应还本息 ＋ 逾期罚金 ＋ 滞纳金 － 已还
        let restRepay = "剩余未还:    " + toolsChangeMoneyStyle(amount: json["amt_total"].doubleValue + json["penalty_amt"].doubleValue + json["demurrage"].doubleValue - json["pay_amt_total"].doubleValue) + "元"
        //到期时间
        let repayTime = "到期时间:    " + toolsChangeDateStyle(toYYYYMMDD: json["realpay_date"].stringValue)
        //逾期天数
        let overDay = "逾期天数:    " + json["penalty_day"].stringValue + "天"
        //逾期罚金
        let overFee = "逾期罚金:    " + toolsChangeMoneyStyle(amount: json["penalty_amt"].doubleValue + json["demurrage"].doubleValue) + "元"
        
        let backTime = json["back_stamp"].stringValue
        
        switch self.repayStatusType {
        case .finish://完成
            if backTime.characters.count > 0 {
                let backDate = "还款时间:    " + toolsChangeDataStyle(toDateStyle: json["back_stamp"].stringValue)
                self.detailView.dataArray = [shouldRepay, repayTime, backDate]
            }else {
                self.detailView.dataArray = [shouldRepay, repayTime, ""]
            }
            
        case .overdue://逾期
            self.detailView.dataArray = [shouldRepay, restRepay, repayTime, overDay, overFee]
        case .not://未还
            self.detailView.dataArray = [shouldRepay, restRepay, repayTime]
        default:
            break
        }
    }
}
