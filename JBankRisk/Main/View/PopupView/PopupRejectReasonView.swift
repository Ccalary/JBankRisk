//
//  PopupRejectReasonView.swift
//  JBankRisk
//
//  Created by caohouhong on 2017/9/15.
//  Copyright © 2017年 jingjinsuo. All rights reserved.
//

import UIKit

class PopupRejectReasonView: UIView {
    
    private var failDis = ""
    
    init(frame: CGRect , string: String ) {
        super.init(frame: frame)
        failDis = string
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        
        self.backgroundColor = UIColor.white
        
        self.addSubview(textLabel)
        self.addSubview(divideLine1)
        self.addSubview(noticeLabel)
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
        
        
        sureBtn.snp.makeConstraints { (make) in
            make.width.equalTo(85*UIRate)
            make.height.equalTo(40*UIRate)
            make.centerX.equalTo(self)
            make.bottom.equalTo(self).offset(-15*UIRate)
        }
    }
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontBoldSize(size: 20*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "审核反馈"
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
        label.text = self.failDis
        return label
    }()
    
    
    ///按钮
    private lazy var sureBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "pop_btn_red_85x40"), for: .normal)
        button.setTitle("知道了", for: UIControlState.normal)
        button.titleLabel?.font = UIFontBoldSize(size: 18*UIRate)
        button.addTarget(self, action: #selector(sureBtnAction), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Action
    var onClickSure : (()->())?
    
    func sureBtnAction(){
        if let onClickSure = onClickSure {
            onClickSure()
        }
    }


}
