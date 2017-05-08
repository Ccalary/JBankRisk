//
//  PopupAuthorityView.swift
//  JBankRisk
//
//  Created by caohouhong on 17/5/2.
//  Copyright © 2017年 jingjinsuo. All rights reserved.
//

import UIKit

class PopupAuthorityView: UIView {

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
        self.addSubview(tipsLabel)
        self.addSubview(cancelBtn)
        self.addSubview(sureBtn)
        
        textLabel.snp.makeConstraints { (make) in
            make.height.equalTo(20*UIRate)
            make.top.equalTo(15*UIRate)
            make.centerX.equalTo(self)
        }
        
        divideLine1.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.height.equalTo(1)
            make.centerX.equalTo(self)
            make.top.equalTo(50*UIRate)
        }

        
        tipsLabel.snp.makeConstraints { (make) in
            make.top.equalTo(divideLine1.snp.bottom).offset(20*UIRate)
            make.centerX.equalTo(self)
        }
        
        cancelBtn.snp.makeConstraints { (make) in
            make.width.equalTo(100*UIRate)
            make.height.equalTo(40*UIRate)
            make.left.equalTo(40*UIRate)
            make.bottom.equalTo(self).offset(-15*UIRate)
        }
        
        sureBtn.snp.makeConstraints { (make) in
            make.size.equalTo(cancelBtn)
            make.right.equalTo(-40*UIRate)
            make.centerY.equalTo(cancelBtn)
        }
    }
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 18*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "芝麻信用"
        return label
    }()
    
    //分割线
    private lazy var divideLine1: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()

    
    private lazy var tipsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.numberOfLines = 0;
        label.text = "授权芝麻信用认证能够帮您提高申请\n通过率哦！"
        return label
    }()
    
    ///取消按钮
    private lazy var cancelBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "btn_gray_100x40"), for: .normal)
        button.setTitle("暂不授权", for: UIControlState.normal)
        button.titleLabel?.font = UIFontBoldSize(size: 18*UIRate)
        button.addTarget(self, action: #selector(cancelBtnAction), for: .touchUpInside)
        return button
    }()
    
    ///拨打按钮
    private lazy var sureBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "btn_red_100x40"), for: .normal)
        button.setTitle("去授权", for: UIControlState.normal)
        button.titleLabel?.font = UIFontBoldSize(size: 18*UIRate)
        button.addTarget(self, action: #selector(sureBtnAction), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Action
    
    var onClickCancel : (()->())?
    var onClickSure: (()->())?
    
    //取消
    func cancelBtnAction(){
        if let onClickCancel = onClickCancel {
            onClickCancel()
        }
    }
    
    //确认
    func sureBtnAction(){
        if let onClickSure = onClickSure {
            onClickSure()
        }
    }

}
