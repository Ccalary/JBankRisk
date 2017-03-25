//
//  RepayTipsViewController.swift
//  JBankRisk
//
//  Created by caohouhong on 16/12/26.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit
import SwiftyJSON

class RepayTipsViewController: UIViewController {

    enum RepayResult{
        case success
        case fail
    }
    
    //支付结果
    var repayResult: RepayResult = .success

    //支付信息
    var repayInfo:(amount: String, way: String, repaymentId: String, repayCount: Int) = ("", "", "", 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //借款流程返回通知
        NotificationCenter.default.addObserver(self, selector: #selector(borrowAgainAction), name: NSNotification.Name(rawValue: noticeBorrowAgainAction), object: nil)
        
        self.setupUI()
        
        switch repayResult {
        case .success:
            statusImageView.image = UIImage(named: "repay_success_20x20")
            statusTextLabel.text = "还款成功"
            statusTextLabel.textColor = UIColorHex("3dc133")
//            tipsTextLabel.text = "本次账单共\(repayInfo.repayCount)笔"
//            nextStepBtn.setTitle("查看详情", for: UIControlState.normal)
            tipsTextLabel.text = "再借一笔，下款更快，额度也可能更高呦～"
            nextStepBtn.setTitle("再借一笔", for: UIControlState.normal)
            repayWayLabel.text = "还款方式：\(repayInfo.way)"
            self.requestSuccessData()
        case .fail:
            statusImageView.image = UIImage(named: "repay_fail_20x20")
            statusTextLabel.text = "还款失败"
            statusTextLabel.textColor = UIColorHex("ff3900")
            tipsTextLabel.text = "出了点意外，再试试吧！"
            nextStepBtn.setTitle("再试试", for: UIControlState.normal)
            moneyLabel.text = "¥\(repayInfo.amount)"
            repayWayLabel.text = "还款方式：\(repayInfo.way)"
            repayTimeLabel.text = "还款时间：\(toolsChangeCurrentDateStyle())"
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupUI(){
        self.navigationController!.navigationBar.isTranslucent = true;
        self.automaticallyAdjustsScrollViewInsets = false;
        
        self.navigationItem.title = "还款提示"
        self.view.backgroundColor = defaultBackgroundColor
          self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"navigation_left_back_13x21"), style: .plain, target: self, action: #selector(leftNavigationBarBtnAction))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "关闭", style: UIBarButtonItemStyle.plain, target: self, action: #selector(rightNavigationBarBtnAction))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColorHex("666666")
        
        self.view.addSubview(statusTextLabel)
        self.view.addSubview(statusImageView)
        self.view.addSubview(centerHoldView)
        self.centerHoldView.addSubview(divideLine1)
        self.centerHoldView.addSubview(divideLine2)
        self.centerHoldView.addSubview(divideLine3)
        self.centerHoldView.addSubview(moneyTextLabel)
        self.centerHoldView.addSubview(moneyLabel)
        self.centerHoldView.addSubview(repayWayLabel)
        self.centerHoldView.addSubview(repayTimeLabel)
        
        self.view.addSubview(tipsTextLabel)
        self.view.addSubview(nextStepBtn)
        
        statusTextLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view).offset(15*UIRate)
            make.centerY.equalTo(self.view.snp.top).offset(64 + 27.5*UIRate)
        }

        statusImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(20*UIRate)
            make.right.equalTo(self.statusTextLabel.snp.left).offset(-5*UIRate)
            make.centerY.equalTo(self.statusTextLabel)
        }
        
        centerHoldView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(175*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(64 + 55*UIRate)
        }
        
        divideLine1.snp.makeConstraints { (make) in
            make.width.equalTo(centerHoldView)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(centerHoldView)
            make.centerY.equalTo(centerHoldView)
        }
        
        divideLine2.snp.makeConstraints { (make) in
            make.size.equalTo(divideLine1)
            make.centerX.equalTo(centerHoldView)
            make.top.equalTo(centerHoldView)
        }

        divideLine3.snp.makeConstraints { (make) in
            make.size.equalTo(divideLine1)
            make.centerX.equalTo(centerHoldView)
            make.bottom.equalTo(centerHoldView)
        }

        moneyTextLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(centerHoldView)
            make.top.equalTo(20*UIRate)
        }

        moneyLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(centerHoldView)
            make.top.equalTo(moneyTextLabel.snp.bottom).offset(10*UIRate)
        }

        repayWayLabel.snp.makeConstraints { (make) in
            make.left.equalTo(25*UIRate)
            make.top.equalTo(divideLine1.snp.bottom).offset(20*UIRate)
        }

        repayTimeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(repayWayLabel)
            make.top.equalTo(repayWayLabel.snp.bottom).offset(20*UIRate)
        }
        
        tipsTextLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(centerHoldView.snp.bottom).offset(35*UIRate)
        }

        nextStepBtn.snp.makeConstraints { (make) in
            make.width.equalTo(345*UIRate)
            make.height.equalTo(44*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(tipsTextLabel.snp.bottom).offset(15*UIRate)
        }
    }
    
    //图片
    private lazy var statusImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var statusTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        return label
    }()

    //中间holdView
    private lazy var centerHoldView: UIView = {
        let holdView = UIView()
        holdView.backgroundColor = UIColor.white
        return holdView
    }()
    
    //分割线
    private lazy var divideLine1: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()
    
    //分割线
    private lazy var divideLine2: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()
    
    //分割线
    private lazy var divideLine3: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()

    private lazy var moneyTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "还款金额"
        return label
    }()

    private lazy var moneyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontBoldSize(size: 20*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "¥0.00"
        return label
    }()

    private lazy var repayWayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textColor = UIColorHex("c5c5c5")
        label.text = "还款方式："
        return label
    }()

    private lazy var repayTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textColor = UIColorHex("c5c5c5")
        label.text = "还款时间："
        return label
    }()

    private lazy var tipsTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 13*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        return label
    }()

    //／按钮
    private lazy var nextStepBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "login_btn_red_345x44"), for: .normal)
        button.titleLabel?.font = UIFontSize(size: 18*UIRate)
        button.addTarget(self, action: #selector(nextStepBtnAction), for: .touchUpInside)
        return button
    }()
    //返回键
    func leftNavigationBarBtnAction(){
        
        let vcCount = self.navigationController?.viewControllers.count
        
       _ = self.navigationController?.popToViewController((self.navigationController?.viewControllers[vcCount! - 3])!, animated: true)
    }
    
    //关闭
    func rightNavigationBarBtnAction(){
        
      _ = self.navigationController?.popToViewController((self.navigationController?.viewControllers[1])!, animated: true)
    }
    
    func nextStepBtnAction(){
        switch repayResult {
        case .success:

            let borrowMoneyVC = BorrowMoneyViewController()
            borrowMoneyVC.currentIndex = 0
            self.navigationController?.pushViewController(borrowMoneyVC, animated: false)
            
        case .fail:
            _ = self.navigationController?.popViewController(animated: true)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: noticeRepayFailAndTryAgain), object: self)
        }
    }
    
    //MARK: Notice
    func borrowAgainAction(){
       _ = self.navigationController?.popToRootViewController(animated: false)
    }
    
    //MARK: - 请求成功的数据
    func requestSuccessData(){
        //添加HUD
        self.showHud(in: self.view, hint: "加载中...")
        
        var params = NetConnect.getBaseRequestParams()
        params["repayment_id"] = repayInfo.repaymentId
        
        NetConnect.pc_repay_success_result(parameters: params, success: { response in
            //隐藏HUD
            self.hideHud()
            let json = JSON(response)
            guard json["RET_CODE"] == "000000" else{
                return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
            }
            
            self.moneyLabel.text = "¥\(toolsChangeMoneyStyle(amount: json["payInfo"]["real_pay"].doubleValue))"
            self.repayTimeLabel.text = "还款时间：\(toolsChangeDataStyle(toFullStyle: json["payInfo"]["back_stamp"].stringValue))"
            
        }, failure:{ error in
            //隐藏HUD
            self.hideHud()
        })
    }
    
}
