//
//  ServiceBillHeaderView.swift
//  JBankRisk
//
//  Created by caohouhong on 17/6/2.
//  Copyright © 2017年 jingjinsuo. All rights reserved.
//

import UIKit

class ServiceBillHeaderView: UIView, UITextFieldDelegate {

    //回调
    var onClick:(()->())?
    
    //是否签署
    var isSigned = false{
        
        didSet{
            if isSigned {
                self.statusLabel.textColor = UIColorHex("666666")
                self.statusLabel.text = "已签署"
            }else {
                self.statusLabel.textColor = UIColor.red
                self.statusLabel.text = "未签署"
            }
        }
    }
    
    var numText = ""{
        didSet{
            if numText.characters.count > 0 {
                self.cleanButton.isHidden = false
            }else {
                self.cleanButton.isHidden = true
                self.numTextField.text = ""
            }
        }
    }
    
    override init(frame: CGRect ) {
        super.init(frame: frame)
        
    }
    
    ///初始化默认frame
    convenience init() {
        let frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 100*UIRate)
        self.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI(){
        self.backgroundColor = UIColor.white
        
        self.addSubview(bankNumLabel)
        self.addSubview(numTextField)
        self.addSubview(contractLabel)
        self.addSubview(statusLabel)
        self.addSubview(cleanButton)
        self.addSubview(arrowImageView)
        self.addSubview(nextStepBtn)
        self.addSubview(divideLine1)
        self.addSubview(divideLine2)
        self.addSubview(divideLine3)
        
        bankNumLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15*UIRate)
            make.centerY.equalTo(self).offset(-25*UIRate)
        }
        
        numTextField.snp.makeConstraints { (make) in
            make.width.equalTo(SCREEN_WIDTH - 135*UIRate)
            make.left.equalTo(95*UIRate)
            make.centerY.equalTo(bankNumLabel)
        }
        
        cleanButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(45)
            make.right.equalTo(self)
            make.centerY.equalTo(bankNumLabel)
        }
        
        contractLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15*UIRate)
            make.centerY.equalTo(self).offset(25*UIRate)
        }

        statusLabel.snp.makeConstraints { (make) in
            make.width.equalTo(100*UIRate)
            make.left.equalTo(numTextField)
            make.centerY.equalTo(contractLabel)
        }
        
        arrowImageView.snp.makeConstraints { (make) in
            make.width.equalTo(7*UIRate)
            make.height.equalTo(12*UIRate)
            make.right.equalTo(self).offset(-15*UIRate)
            make.centerY.equalTo(contractLabel)
        }
        nextStepBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(50*UIRate)
            make.centerY.equalTo(contractLabel)
        }
        
        divideLine1.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(0.5*UIRate)
        }
        
        divideLine2.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(0.5*UIRate)
        }
        
        divideLine3.snp.makeConstraints { (make) in
            make.bottom.equalTo(self)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(0.5*UIRate)
        }
    }
    
    private lazy var bankNumLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size:15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "银行卡号"
        return label
    }()

    lazy var numTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "请填写您的银行卡号"
        textField.keyboardType = .numberPad
        textField.delegate = self
        return textField
    }()
    
    private lazy var contractLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size:15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "电子合同"
        return label
    }()

    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size:15*UIRate)
        label.textColor = UIColor.red
        label.text = "未签署"
        return label
    }()

    //图片
    private lazy var cleanButton: UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.setImage(UIImage(named: "login_btn_clear_15x15"), for: .normal)
        button.addTarget(self, action: #selector(cleanBtnAction), for: .touchUpInside)
        return button
    }()
    
    //图片
    private lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "home_right_arrow_7x12")
        return imageView
    }()
    
    //／按钮
    private lazy var nextStepBtn: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(nextStepBtnAction), for: .touchUpInside)
        return button
    }()

    //分割线
    private lazy var divideLine1: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()
    
    //分割线
    private lazy var divideLine2: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()
    
    //分割线
    private lazy var divideLine3: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()

    
    //MARK: - Action
    func nextStepBtnAction(){
        if let onClick = onClick {
            onClick()
        }
    }
    
    //清除按钮
    func cleanBtnAction(){
        numText = ""
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let b = OCTools.textField(textField, shouldChangeCharactersIn: range, replacementString: string)
        
        numText = textField.text ?? ""
        
        return b
    }
}
