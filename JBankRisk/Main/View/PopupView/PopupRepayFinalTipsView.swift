//
//  PopupRepayFinalTipsView.swift
//  JBankRisk
//
//  Created by chh on 2017/8/14.
//  Copyright © 2017年 jingjinsuo. All rights reserved.
//  账单清算提示

import UIKit

class PopupRepayFinalTipsView: UIView {

    override init(frame: CGRect ) {
        super.init(frame: frame)
        setupUI()
    }
    
    ///初始化默认frame
    convenience init() {
        let frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH - 40*UIRate, height: 200*UIRate)
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
        self.addSubview(knowBtn)
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
        
        
        knowBtn.snp.makeConstraints { (make) in
            make.width.equalTo(85*UIRate)
            make.height.equalTo(40*UIRate)
            make.left.equalTo(45*UIRate)
            make.bottom.equalTo(self).offset(-15*UIRate)
        }
        
        sureBtn.snp.makeConstraints { (make) in
            make.size.equalTo(knowBtn)
            make.right.equalTo(-45*UIRate)
            make.centerY.equalTo(knowBtn)
        }
    }
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontBoldSize(size: 20*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "账单清算提示"
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
        label.text = "您七日内有期还款，避免在等待申请时出现逾期情况，请先将最近一期账单还款后再进行申请"
        return label
    }()
    
    ///取消按钮
    private lazy var knowBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "pop_btn_gray_85x40"), for: .normal)
        button.setTitle("知道了", for: UIControlState.normal)
        button.titleLabel?.font = UIFontBoldSize(size: 18*UIRate)
        button.addTarget(self, action: #selector(knowBtnAction), for: .touchUpInside)
        return button
    }()
    
    ///按钮
    private lazy var sureBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "pop_btn_red_85x40"), for: .normal)
        button.setTitle("去还款", for: UIControlState.normal)
        button.titleLabel?.font = UIFontBoldSize(size: 18*UIRate)
        button.addTarget(self, action: #selector(sureBtnAction), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Action
    var onClickSure : (()->())?
    var onClickKnow: (()->())?
    

    //知道了
    func knowBtnAction(){
        if let onClickKnow = onClickKnow {
            onClickKnow()
        }
    }
    
    func sureBtnAction(){
        if let onClickSure = onClickSure {
            onClickSure()
        }
    }


}
