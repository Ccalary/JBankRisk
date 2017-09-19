//
//  PopupCancelOrderView.swift
//  JBankRisk
//
//  Created by chh on 2017/9/18.
//  Copyright © 2017年 jingjinsuo. All rights reserved.
//

import UIKit

class PopupCancelOrderView: UIView {

    //传入金额显示文案
    var cancelMonay: Double = 0.00 {
        didSet{
            if cancelMonay <= 0.00 {
                self.noticeLabel.text = "撤销此笔借款，您将不再享受此产品服务"
            }else {
                let str = toolsChangeMoneyStyle(amount: cancelMonay)
                self.noticeLabel.text = "现在撤销借款会收取\(str)元的违约金哦"
            }
        }
    }
    
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
        self.addSubview(cancelBtn)
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
            make.left.equalTo(35*UIRate)
            make.right.equalTo(-35*UIRate)
        }
        
        cancelBtn.snp.makeConstraints { (make) in
            make.width.equalTo(85*UIRate)
            make.height.equalTo(40*UIRate)
            make.left.equalTo(45*UIRate)
            make.bottom.equalTo(self).offset(-15*UIRate)
        }
        
        sureBtn.snp.makeConstraints { (make) in
            make.size.equalTo(cancelBtn)
            make.right.equalTo(-45*UIRate)
            make.centerY.equalTo(cancelBtn)
        }
    }
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontBoldSize(size: 20*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "撤销提醒"
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
    private lazy var cancelBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "pop_btn_gray_85x40"), for: .normal)
        button.setTitle("不申请", for: UIControlState.normal)
        button.titleLabel?.font = UIFontBoldSize(size: 18*UIRate)
        button.addTarget(self, action: #selector(cancelBtnAction), for: .touchUpInside)
        return button
    }()
    
    ///按钮
    private lazy var sureBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "pop_btn_red_85x40"), for: .normal)
        button.setTitle("申请撤销", for: UIControlState.normal)
        button.titleLabel?.font = UIFontBoldSize(size: 18*UIRate)
        button.addTarget(self, action: #selector(sureBtnAction), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Action
    var onClickSure : (()->())?
    var onClickCancel: (()->())?
    
    //取消
    func cancelBtnAction(){
        if let onClickCancel = onClickCancel {
            onClickCancel()
        }
    }
    
    //确定
    func sureBtnAction(){
        
        if let onClickSure = onClickSure {
            onClickSure()
        }
    }
}
