//
//  PopupPhoneCallView.swift
//  JBankRisk
//
//  Created by 曹后红 on 16/10/13.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

class PopupPhoneCallView: UIView {
    
    override init(frame: CGRect ) {
        super.init(frame: frame)
        setupUI()
    }

    ///初始化默认frame
    convenience init() {
       let frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH - 40*UIRate, height: 175*UIRate)
        self.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        
        self.backgroundColor = UIColor.white
        
        self.addSubview(textLabel)
        self.addSubview(phoneNumLabel)
        self.addSubview(cancelBtn)
        self.addSubview(sureBtn)
        
        textLabel.snp.makeConstraints { (make) in
            make.top.equalTo(20*UIRate)
            make.centerX.equalTo(self)
        }
        
        phoneNumLabel.snp.makeConstraints { (make) in
            make.top.equalTo(textLabel.snp.bottom).offset(25*UIRate)
            make.centerX.equalTo(self)
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
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "点击拨打联系中诚消费客服"
        return label
    }()
    
    private lazy var phoneNumLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontBoldSize(size: 20*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "400-9669-636"
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
        button.setTitle("拨打", for: UIControlState.normal)
        button.titleLabel?.font = UIFontBoldSize(size: 18*UIRate)
        button.addTarget(self, action: #selector(sureBtnAction), for: .touchUpInside)
        return button
    }()

    //MARK: - Action
    
    var onClickCancel : (()->())?
    var onClickCall: (()->())?
    
    //取消
    func cancelBtnAction(){
        if let onClickCancel = onClickCancel {
           onClickCancel()
        }
    }
    
    //拨打电话
    func sureBtnAction(){
        if let onClickCall = onClickCall {
            onClickCall()
        }
       UIApplication.shared.openURL(URL(string: "tel://4009669636")!)
    }

}
