//
//  RepayWayViewController.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/3.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//  还款渠道

import UIKit

class RepayWayViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        let str = "收款方帐号：6222 6202 1001 4076 003"
        accountTextLabel.attributedText = changeTextColor(text: str, color: UIColorHex("666666"), range: NSRange(location: 0, length: 6))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupUI(){
        self.title = "还款"
        self.view.backgroundColor = defaultBackgroundColor
        
        self.view.addSubview(topHoldView)
        
        self.view.addSubview(titleTextLabel)
        self.view.addSubview(imageView1)
        self.view.addSubview(imageView2)
        self.view.addSubview(imageView3)
        self.view.addSubview(textLabel1)
        self.view.addSubview(textLabel2)
        self.view.addSubview(textLabel3)
        self.view.addSubview(divideLine1)
        
        /*********/
        self.view.addSubview(centerHoldView)
        self.centerHoldView.addSubview(divideLine2)
        self.centerHoldView.addSubview(divideLine3)
        self.centerHoldView.addSubview(tipsTextLabel)
        self.centerHoldView.addSubview(nameTextLabel)
        self.centerHoldView.addSubview(accountTextLabel)
        self.centerHoldView.addSubview(bankTextLabel)
        
        self.centerHoldView.addSubview(copyBtn)

        topHoldView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(144*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(64)
        }
        
        titleTextLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(64 + 15*UIRate)
        }
        
        imageView2.snp.makeConstraints { (make) in
            make.width.height.equalTo(50*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(64 + 55*UIRate)
        }
        
        imageView1.snp.makeConstraints { (make) in
            make.width.height.equalTo(50*UIRate)
            make.centerX.equalTo(imageView2).offset(-110*UIRate)
            make.top.equalTo(imageView2)
        }
        
        imageView3.snp.makeConstraints { (make) in
            make.width.height.equalTo(50*UIRate)
            make.centerX.equalTo(imageView2).offset(110*UIRate)
            make.top.equalTo(imageView2)
        }
        
        textLabel2.snp.makeConstraints { (make) in
            make.centerX.equalTo(imageView2)
            make.top.equalTo(imageView2.snp.bottom).offset(4*UIRate)
        }
        
        textLabel1.snp.makeConstraints { (make) in
            make.centerX.equalTo(imageView1)
            make.top.equalTo(imageView1.snp.bottom).offset(4*UIRate)
        }
        
        textLabel3.snp.makeConstraints { (make) in
            make.centerX.equalTo(imageView3)
            make.top.equalTo(imageView3.snp.bottom).offset(4*UIRate)
        }
        
        divideLine1.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(topHoldView)
        }
        
        /*******/
        centerHoldView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(168*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(topHoldView.snp.bottom).offset(7*UIRate)
        }

        divideLine2.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(centerHoldView.snp.top)
        }
        
        divideLine3.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(centerHoldView.snp.bottom)
        }

        tipsTextLabel.snp.makeConstraints { (make) in
            make.width.equalTo(SCREEN_WIDTH - 30*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(15*UIRate)
        }

        nameTextLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15*UIRate)
            make.top.equalTo(tipsTextLabel.snp.bottom).offset(15*UIRate)
        }

        accountTextLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15*UIRate)
            make.top.equalTo(nameTextLabel.snp.bottom).offset(6*UIRate)
        }
        
        bankTextLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15*UIRate)
            make.top.equalTo(accountTextLabel.snp.bottom).offset(6*UIRate)
        }
        
        copyBtn.snp.makeConstraints { (make) in
            make.width.equalTo(50*UIRate)
            make.height.equalTo(25*UIRate)
            make.left.equalTo(accountTextLabel.snp.right)
            make.centerY.equalTo(accountTextLabel)
        }
    }
    
    private lazy var topHoldView: UIView = {
        let holdView = UIView()
        holdView.backgroundColor = UIColor.white
        return holdView
    }()
    
    private lazy var titleTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "支持渠道"
        return label
    }()

    //图片
    private lazy var imageView1: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "m_alipay_50x50")
        return imageView
    }()
    
    //图片
    private lazy var imageView2: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "m_ebank_50x50")
        return imageView
    }()
    
    //图片
    private lazy var imageView3: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "m_upgrading_50x50")
        return imageView
    }()
    
    private lazy var textLabel1: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "支付宝"
        return label
    }()
    
    private lazy var textLabel2: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "网银"
        return label
    }()
    
    private lazy var textLabel3: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "升级中"
        return label
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

    /**********/    
    private lazy var centerHoldView: UIView = {
        let holdView = UIView()
        holdView.backgroundColor = UIColor.white
        return holdView
    }()
    
    private lazy var tipsTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.numberOfLines = 0
        label.textColor = UIColorHex("666666")
        label.text = "   您可以使用您的银行卡，通过支付宝转账、银行转账（银行柜台转账、网银转账、手机银行转账）的方式将资金充值以下账户："
        return label
    }()
    
    private lazy var nameTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "收款方姓名：金星玥"
        return label
    }()
    
    private lazy var accountTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("fdb300")
        return label
    }()

    private lazy var bankTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "收款方开户行：交通银行南京广州路支行"
        return label
    }()

    //／按钮
    private lazy var copyBtn: UIButton = {
        let button = UIButton()
        button.setTitle("复制", for: UIControlState.normal)
        button.titleLabel?.font = UIFontSize(size: 15*UIRate)
        button.setTitleColor(UIColorHex("00b2ff"), for: .normal)
        button.addTarget(self, action: #selector(copyBtnAction), for: .touchUpInside)
        return button
    }()

    func copyBtnAction(){
        let pastboard = UIPasteboard.general
        pastboard.string = "6222620210014076003"
        self.showHint(in: self.view, hint: "帐号已复制到剪切板")
    }

}
