//
//  PopupRegisterTipsView.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/17.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

class PopupRegisterTipsView: UIView {

    
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
        
        sureBtn.snp.makeConstraints { (make) in
            make.width.equalTo(150*UIRate)
            make.height.equalTo(40*UIRate)
            make.centerX.equalTo(self)
            make.bottom.equalTo(self).offset(-20*UIRate)
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 18*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "友情提示"
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
        label.numberOfLines = 0
        label.text = "您已加入中诚消费，账户密码默认\n为身份证后6位"
        return label
    }()
    
    ///拨打按钮
    private lazy var sureBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "btn_red_150x40"), for: .normal)
        button.setTitle("知道了", for: UIControlState.normal)
        button.titleLabel?.font = UIFontBoldSize(size: 18*UIRate)
        button.addTarget(self, action: #selector(sureBtnAction), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Action
    var onClickSure: (()->())?
    

    //拨打电话
    func sureBtnAction(){
        if let onClickSure = onClickSure {
            onClickSure()
        }
    }
}
