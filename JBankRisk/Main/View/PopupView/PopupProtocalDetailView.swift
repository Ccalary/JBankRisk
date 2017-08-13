//
//  PopupProtocalDetailView.swift
//  JBankRisk
//
//  Created by caohouhong on 2017/8/13.
//  Copyright © 2017年 jingjinsuo. All rights reserved.
//

import UIKit

class PopupProtocalDetailView: UIView {

    let noticeStr = "如需电子合同，请发送邮箱至postmaster@zc-cfc.com申请，邮件中注明您的姓名、手机号码、身份证号码，邮件主题请标明“申请电子合同”字样。"
    let addressStr = "postmaster@zc-cfc.com"
    
    override init(frame: CGRect ) {
        super.init(frame: frame)
        setupUI()
    }
    
    ///初始化默认frame
    convenience init() {
        let frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH - 40*UIRate, height: 220*UIRate)
        self.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        
        self.backgroundColor = UIColor.white
        
        self.addSubview(textLabel)
        self.addSubview(divideLine1)
        self.addSubview(noticeLabel)
        self.addSubview(copyBtn)
        self.addSubview(sureBtn)
        
        textLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.centerX.equalTo(self)
            make.height.equalTo(45*UIRate)
        }
        
        divideLine1.snp.makeConstraints { (make) in
            make.top.equalTo(textLabel.snp.bottom)
            make.centerX.equalTo(self)
            make.height.equalTo(1*UIRate)
            make.width.equalTo(self)
        }
        
        noticeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(textLabel.snp.bottom).offset(25*UIRate)
            make.centerX.equalTo(self)
            make.left.equalTo(25*UIRate)
            make.right.equalTo(-25*UIRate)
        }
        
        noticeLabel.attributedText = changeSomeTextColor(text: addressStr, inText: noticeStr, color: ColorTextBlue)
        
        
        copyBtn.snp.makeConstraints { (make) in
            make.width.equalTo(85*UIRate)
            make.height.equalTo(40*UIRate)
            make.left.equalTo(45*UIRate)
            make.bottom.equalTo(self).offset(-15*UIRate)
        }
        
        sureBtn.snp.makeConstraints { (make) in
            make.size.equalTo(copyBtn)
            make.right.equalTo(-45*UIRate)
            make.centerY.equalTo(copyBtn)
        }
    }
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontBoldSize(size: 20*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "提示"
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
        return label
    }()
    
    ///取消按钮
    private lazy var copyBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "pop_btn_red_85x40"), for: .normal)
        button.setTitle("复制邮箱", for: UIControlState.normal)
        button.titleLabel?.font = UIFontBoldSize(size: 18*UIRate)
        button.addTarget(self, action: #selector(copyBtnAction), for: .touchUpInside)
        return button
    }()
    
    ///拨打按钮
    private lazy var sureBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "pop_btn_red_85x40"), for: .normal)
        button.setTitle("知道了", for: UIControlState.normal)
        button.titleLabel?.font = UIFontBoldSize(size: 18*UIRate)
        button.addTarget(self, action: #selector(sureBtnAction), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Action
    var onClickCopy : (()->())?
    var onClickKnow: (()->())?
    
    //复制
    func copyBtnAction(){
        let pasteBoard = UIPasteboard.general
        pasteBoard.string = addressStr
        if let onClickCopy = onClickCopy {
            onClickCopy()
        }
    }
    
    //知道了
    func sureBtnAction(){
        if let onClickKnow = onClickKnow {
            onClickKnow()
        }
    }
}
