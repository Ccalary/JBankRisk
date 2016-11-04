//
//  PopupLogoutView.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/4.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

class PopupLogoutView: UIView {

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
        
        self.addSubview(titleLabel)
        self.addSubview(divideLine1)
        self.addSubview(noticeLabel)
        self.addSubview(cancelBtn)
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
            make.top.equalTo(80*UIRate)
            make.centerX.equalTo(self)
        }
        
        cancelBtn.snp.makeConstraints { (make) in
            make.width.equalTo(85*UIRate)
            make.height.equalTo(40*UIRate)
            make.left.equalTo(45*UIRate)
            make.bottom.equalTo(self).offset(-20*UIRate)
        }
        
        sureBtn.snp.makeConstraints { (make) in
            make.size.equalTo(cancelBtn)
            make.right.equalTo(-45*UIRate)
            make.centerY.equalTo(cancelBtn)
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 18*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "退出登录"
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
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "确定要退出当前账号？"
        return label
    }()
    
    ///取消按钮
    private lazy var cancelBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "pop_btn_gray_85x40"), for: .normal)
        button.setTitle("取消", for: UIControlState.normal)
        button.titleLabel?.font = UIFontBoldSize(size: 18*UIRate)
        button.addTarget(self, action: #selector(cancelBtnAction), for: .touchUpInside)
        return button
    }()
    
    ///拨打按钮
    private lazy var sureBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "pop_btn_red_85x40"), for: .normal)
        button.setTitle("确认", for: UIControlState.normal)
        button.titleLabel?.font = UIFontBoldSize(size: 18*UIRate)
        button.addTarget(self, action: #selector(sureBtnAction), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Action
    
    var onClickCancle : (()->())?
    var onClickSure: (()->())?
    
    //取消
    func cancelBtnAction(){
        if let onClickCancle = onClickCancle {
            onClickCancle()
        }
    }
    
    //拨打电话
    func sureBtnAction(){
        if let onClickSure = onClickSure {
            onClickSure()
        }
    }
    
}
