//
//  RepayBillViewController.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/4.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

class RepayBillViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    
    func setupUI(){
        self.title = "还款账单"
        self.view.backgroundColor = defaultBackgroundColor
        
        self.view.addSubview(topImageView)
        self.topImageView.addSubview(totalTextLabel)
        self.topImageView.addSubview(totalMoneyLabel)
        self.topImageView.addSubview(arrowImageView)
        
        /*******/
        self.view.addSubview(repayHoldView)
        self.repayHoldView.addSubview(reBottomHoldView)
        self.repayHoldView.addSubview(repayDivideLine)
        self.repayHoldView.addSubview(repayDivideLine2)
        self.repayHoldView.addSubview(repayVerDivideLine)
        
        self.repayHoldView.addSubview(moneyTextLabel)
        self.repayHoldView.addSubview(moneyLabel)
        self.repayHoldView.addSubview(moneyArrowImageView)
        self.repayHoldView.addSubview(amountTextLabel)
        self.repayHoldView.addSubview(amountLabel)
        self.repayHoldView.addSubview(amountArrowImageView)
        self.repayHoldView.addSubview(monthBtn)
        self.repayHoldView.addSubview(amountBtn)
        
        topImageView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(156*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(64*UIRate)
        }
        
        totalTextLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(topImageView)
            make.top.equalTo(40*UIRate)
        }
        
        totalMoneyLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(80*UIRate)
        }

        arrowImageView.snp.makeConstraints { (make) in
            make.width.equalTo(7*UIRate)
            make.height.equalTo(12*UIRate)
            make.right.equalTo(-75*UIRate)
            make.centerY.equalTo(topImageView)
        }
        
        /******/
        repayHoldView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(70*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(topImageView.snp.bottom)
        }
        
        repayDivideLine.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(60*UIRate)
        }
        repayDivideLine2.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(repayHoldView)
        }

        repayVerDivideLine.snp.makeConstraints { (make) in
            make.width.equalTo(0.5*UIRate)
            make.height.equalTo(60*UIRate)
            make.centerX.equalTo(repayHoldView)
            make.top.equalTo(repayHoldView)
        }

        moneyTextLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(-SCREEN_WIDTH/4)
            make.top.equalTo(35*UIRate)
        }
        
        moneyLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(moneyTextLabel)
            make.top.equalTo(12*UIRate)
        }

        moneyArrowImageView.snp.makeConstraints { (make) in
            make.width.equalTo(7*UIRate)
            make.height.equalTo(12*UIRate)
            make.right.equalTo(repayHoldView.snp.centerX).offset(-15*UIRate)
            make.centerY.equalTo(repayHoldView.snp.top).offset(30*UIRate)
        }

        amountTextLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(SCREEN_WIDTH/4)
            make.centerY.equalTo(moneyTextLabel)
        }

        amountLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(amountTextLabel)
            make.centerY.equalTo(moneyLabel)
        }

        amountArrowImageView.snp.makeConstraints { (make) in
            make.width.equalTo(7*UIRate)
            make.height.equalTo(12*UIRate)
            make.right.equalTo(-15*UIRate)
            make.centerY.equalTo(moneyArrowImageView)
        }
        
        monthBtn.snp.makeConstraints { (make) in
            make.width.equalTo(SCREEN_WIDTH/2)
            make.height.equalTo(60*UIRate)
            make.left.equalTo(repayHoldView)
            make.top.equalTo(0)
        }
        
        amountBtn.snp.makeConstraints { (make) in
            make.size.equalTo(monthBtn)
            make.centerY.equalTo(monthBtn)
            make.right.equalTo(repayHoldView)
        }

        reBottomHoldView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(10*UIRate)
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(repayHoldView)
        }


    }

    //图片
    private lazy var topImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "m_banner_image2_375x156")
        return imageView
    }()
    
    private lazy var totalTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.text = "应还总额(元)"
        return label
    }()
    
    private lazy var totalMoneyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 36*UIRate)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.text = "1599,009.00"
        return label
    }()

    //箭头
    private lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "home_right_arrow_7x12")
        return imageView
    }()
    
    /*************/
    private lazy var repayHoldView: UIView = {
        let holdView = UIView()
        holdView.backgroundColor = UIColor.white
        return holdView
    }()
    
    //分割线
    private lazy var repayDivideLine: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()
    
    private lazy var repayDivideLine2: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()
    
    //分割线
    private lazy var repayVerDivideLine: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()
    
    private lazy var moneyTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("848484")
        label.text = "本月待还(元)"
        return label
    }()
    
    private lazy var moneyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 20*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("f42e2f")
        label.text = "0.00"
        return label
    }()
    
    private lazy var amountTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("848484")
        label.text = "累计已还(元)"
        return label
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 20*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("f42e2f")
        label.text = "100.00"
        return label
    }()
    
    private lazy var reBottomHoldView: UIView = {
        let holdView = UIView()
        holdView.backgroundColor = defaultBackgroundColor
        return holdView
    }()
    
    //箭头
    private lazy var moneyArrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "home_right_arrow_7x12")
        return imageView
    }()
    
    //箭头
    private lazy var amountArrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "home_right_arrow_7x12")
        return imageView
    }()

    //／按钮
    private lazy var monthBtn: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(monthBtnAction), for: .touchUpInside)
        return button
    }()
    
    //／按钮
    private lazy var amountBtn: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(amountBtnAction), for: .touchUpInside)
        return button
    }()
    
    /************/
    //图片
    private lazy var monthIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "m_repay_bill_20x20")
        return imageView
    }()
    
    private lazy var monthBillTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "本月待还账单"
        return label
    }()
    
    private lazy var recentTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "最近还款日10.01"
        return label
    }()

    
    //分割线
    private lazy var divideLine1: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()

    
    
    
}

extension RepayBillViewController {
    
    //本月待还
    func monthBtnAction(){
        
    }
    
    //累计还款
    func amountBtnAction(){
        
    }
}
