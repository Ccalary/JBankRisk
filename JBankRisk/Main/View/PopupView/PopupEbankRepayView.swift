//
//  PopupEbankRepayView.swift
//  JBankRisk
//
//  Created by caohouhong on 16/12/26.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

class PopupEbankRepayView: UIView {

    override init(frame: CGRect ) {
        super.init(frame: frame)
        setupUI()
    }
    
    ///初始化默认frame
    convenience init() {
        let frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH - 40*UIRate, height: 290*UIRate)
        self.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        
        self.backgroundColor = UIColor.white
        
        self.addSubview(titleLabel)
        self.addSubview(divideLine1)
        self.addSubview(noticeLabel)
        self.addSubview(nameTextLabel)
        self.addSubview(accountTextLabel)
        self.addSubview(bankTextLabel)
        self.addSubview(copyBtn)
        self.addSubview(sureBtn)
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.top).offset(25*UIRate)
            make.centerX.equalTo(self)
        }
        
        divideLine1.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(self)
            make.top.equalTo(50*UIRate)
        }
        
        noticeLabel.snp.makeConstraints { (make) in
            make.width.equalTo(self.frame.size.width - 30*UIRate)
            make.top.equalTo(divideLine1).offset(10*UIRate)
            make.centerX.equalTo(self)
        }
        
        nameTextLabel.snp.makeConstraints {[unowned self] (make) in
            make.top.equalTo(self.noticeLabel.snp.bottom).offset(10*UIRate)
            make.left.equalTo(15*UIRate)
        }
        
        accountTextLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.nameTextLabel.snp.bottom).offset(10*UIRate)
            make.left.equalTo(15*UIRate)
        }

        bankTextLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.accountTextLabel.snp.bottom).offset(10*UIRate)
            make.left.equalTo(15*UIRate)
        }

        copyBtn.snp.makeConstraints {[unowned self] (make) in
            make.width.equalTo(100*UIRate)
            make.height.equalTo(40*UIRate)
            make.centerX.equalTo(self).offset(-75*UIRate)
            make.bottom.equalTo(self).offset(-20*UIRate)
        }
        
        sureBtn.snp.makeConstraints {[unowned self] (make) in
            make.size.equalTo(self.copyBtn)
            make.centerX.equalTo(self).offset(75*UIRate)
            make.bottom.equalTo(self.copyBtn)
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 18*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "网银还款"
        return label
    }()
    
    //分割线
    private lazy var divideLine1: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()
    
    private lazy var noticeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textColor = UIColorHex("666666")
        label.numberOfLines = 0
        label.text = "您可以使用你的银行卡，通过银行柜台转账、网银转账、手机银行转账的方式将资金充值以下账户："
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
        label.textColor = UIColorHex("666666")
        label.text = "收款方帐号：6222 6202 1001 4076 003"
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

    ///复制按钮
    private lazy var copyBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "btn_red_100x40"), for: .normal)
        button.setTitle("复制账号", for: UIControlState.normal)
        button.titleLabel?.font = UIFontBoldSize(size: 18*UIRate)
        button.addTarget(self, action: #selector(copyBtnAction), for: .touchUpInside)
        return button
    }()
    
    ///复制按钮
    private lazy var sureBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "btn_red_100x40"), for: .normal)
        button.setTitle("确认", for: UIControlState.normal)
        button.titleLabel?.font = UIFontBoldSize(size: 18*UIRate)
        button.addTarget(self, action: #selector(sureBtnAction), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Action
    var onClickSure: (()->())?
    var onClickCopy: (()->())?
    
    
    //复制
    func copyBtnAction(){
        let pastboard = UIPasteboard.general
        pastboard.string = "6222620210014076003"
        if let onClickCopy = onClickCopy {
            onClickCopy()
        }
    }
    
    //确认
    func sureBtnAction(){
        if let onClickSure = onClickSure {
            onClickSure()
        }
    }
}
