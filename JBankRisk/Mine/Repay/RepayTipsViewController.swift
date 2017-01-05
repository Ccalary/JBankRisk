//
//  RepayTipsViewController.swift
//  JBankRisk
//
//  Created by caohouhong on 16/12/26.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

class RepayTipsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    deinit {
        PrintLog("deinit")
    }
    
    func setupUI(){
        self.navigationController!.navigationBar.isTranslucent = true;
        self.automaticallyAdjustsScrollViewInsets = false;
        
        self.title = "还款"
        self.view.backgroundColor = defaultBackgroundColor
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
        imageView.image = UIImage(named: "repay_success_20x20")
        return imageView
    }()
    
    private lazy var statusTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("3dc133")
        label.text = "还款成功"
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
        label.text = "¥1000.00"
        return label
    }()

    private lazy var repayWayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("c5c5c5")
        label.text = "还款方式：微信支付"
        return label
    }()

    private lazy var repayTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("c5c5c5")
        label.text = "还款时间：2016-8-12 14:20:20"
        return label
    }()

    private lazy var tipsTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 13*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "再借一笔，下款更快，额度也可能更高呦～"
        return label
    }()

    //／按钮
    private lazy var nextStepBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "login_btn_red_345x44"), for: .normal)
        button.setTitle("再借一笔", for: UIControlState.normal)
        button.titleLabel?.font = UIFontSize(size: 18*UIRate)
        button.addTarget(self, action: #selector(nextStepBtnAction), for: .touchUpInside)
        return button
    }()
    
    //关闭
    func rightNavigationBarBtnAction(){
        
    }
    
    
    func nextStepBtnAction(){
        
    }
}
