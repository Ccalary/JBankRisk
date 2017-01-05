//
//  MineFooterView.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/3.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

class MineFooterView: UICollectionReusableView {

    override init(frame: CGRect ) {
        super.init(frame: frame)
        setupUI()
    }
    
    ///初始化默认frame
    convenience init() {
        let frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 60*UIRate)
        self.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        
        self.backgroundColor = UIColor.white
        
        self.addSubview(holdView)
        self.addSubview(textLabel)
        self.addSubview(phoneBtn)
        self.addSubview(divideLine)
        
        holdView.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.height.equalTo(10*UIRate)
            make.centerX.equalTo(self)
            make.top.equalTo(0)
        }
        
        textLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self).offset(-13*UIRate)
            make.centerY.equalTo(self).offset(5*UIRate)
        }
        
        phoneBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(25*UIRate)
            make.left.equalTo(textLabel.snp.right).offset(2*UIRate)
            make.centerY.equalTo(textLabel)
        }
        
        divideLine.snp.makeConstraints { (make) in
            make.width.equalTo(SCREEN_WIDTH/3.0*2)
            make.height.equalTo(0.5*UIRate)
            make.left.equalTo(0)
            make.top.equalTo(0)
        }
        
        textLabel.attributedText = changeTextLineSpace(text: "联系客服：400-9669-636\n工作日：9:00-17:00", lineSpace: 2*UIRate)
        textLabel.textAlignment = .center
        
    }
    
    private lazy var holdView: UIView = {
        let holdView = UIView()
        holdView.backgroundColor = defaultBackgroundColor
        return holdView
    }()
    
    //分割线
    private lazy var divideLine: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()

    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("fc4146")
        label.numberOfLines = 2
        return label
    }()

    //／按钮
    private lazy var phoneBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "m_phone_25x25"), for: .normal)
    
        button.addTarget(self, action: #selector(phoneBtnAction), for: .touchUpInside)
        return button
    }()
    
    //电话
    func phoneBtnAction(){
        let phoneCallView = PopupPhoneCallView()
        let popupController = CNPPopupController(contents: [phoneCallView])!
        popupController.present(animated: true)
        
        phoneCallView.onClickCancel = {_ in
            popupController.dismiss(animated:true)
        }
        phoneCallView.onClickCall = {_ in
            popupController.dismiss(animated: true)
        }

    }
}
