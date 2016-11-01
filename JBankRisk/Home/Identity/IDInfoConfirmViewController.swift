//
//  IDInfoConfirmViewController.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/1.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

class IDInfoConfirmViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupUI(){
       self.view.backgroundColor = defaultBackgroundColor
       self.title = "身份证确认"
        
        self.view.addSubview(holdView)
        self.holdView.addSubview(divideLine1)
        self.holdView.addSubview(divideLine2)
        self.holdView.addSubview(divideLine3)
        self.holdView.addSubview(nameTextLabel)
        self.holdView.addSubview(nameTextField)
        self.holdView.addSubview(idNumTextLabel)
        self.holdView.addSubview(idTextField)
        
        self.view.addSubview(sureBtn)
        self.view.addSubview(botTextLabel)
        self.view.addSubview(newRecogBtn)
        
        holdView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(120*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(64 + 10*UIRate)
        }

        divideLine1.snp.makeConstraints { (make) in
            make.width.equalTo(holdView)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(holdView)
            make.top.equalTo(holdView)
        }

        divideLine2.snp.makeConstraints { (make) in
            make.width.equalTo(holdView)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(holdView)
            make.centerY.equalTo(holdView)
        }
        
        divideLine3.snp.makeConstraints { (make) in
            make.width.equalTo(holdView)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(holdView)
            make.bottom.equalTo(holdView)
        }
        
        nameTextLabel.snp.makeConstraints { (make) in
            make.left.equalTo(20*UIRate)
            make.top.equalTo(8*UIRate)
        }
        
        nameTextField.snp.makeConstraints { (make) in
            make.width.equalTo(200*UIRate)
            make.left.equalTo(nameTextLabel)
            make.top.equalTo(nameTextLabel.snp.bottom).offset(6*UIRate)
        }

        idNumTextLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameTextLabel)
            make.top.equalTo(divideLine2).offset(8*UIRate)
        }
        
        idTextField.snp.makeConstraints { (make) in
            make.width.equalTo(300*UIRate)
            make.left.equalTo(nameTextLabel)
            make.top.equalTo(idNumTextLabel.snp.bottom).offset(6*UIRate)
        }
        
        sureBtn.snp.makeConstraints { (make) in
            make.width.equalTo(345*UIRate)
            make.height.equalTo(44*UIRate)
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(self.view).offset(-114*UIRate)
        }

        botTextLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.view.snp.centerX)
            make.top.equalTo(sureBtn.snp.bottom).offset(10*UIRate)
        }

        newRecogBtn.snp.makeConstraints { (make) in
            make.width.equalTo(85*UIRate)
            make.height.equalTo(30*UIRate)
            make.left.equalTo(botTextLabel.snp.right)
            make.centerY.equalTo(botTextLabel)
        }
        
    }
    
    private lazy var holdView: UIView = {
        let holdView = UIView()
        holdView.backgroundColor = UIColor.white
        return holdView
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

    private lazy var nameTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "姓名"
        return label
    }()

    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "请输入姓名"
        textField.tag = 10000
        textField.font = UIFontSize(size: 20*UIRate)
        textField.addTarget(self, action: #selector(textFieldAction(_:)), for: .editingChanged)
        return textField
    }()
    private lazy var idNumTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "身份证号"
        return label
    }()

    private lazy var idTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "请输入身份证号"
        textField.tag = 10001
        textField.font = UIFontSize(size: 20*UIRate)
        textField.addTarget(self, action: #selector(textFieldAction(_:)), for: .editingChanged)
        return textField
    }()

    //／确认按钮
    private lazy var sureBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "login_btn_grayred_345x44"), for: .normal)
        button.isUserInteractionEnabled = false
        button.setTitle("确认", for: UIControlState.normal)
        button.titleLabel?.font = UIFontBoldSize(size: 18*UIRate)
        button.addTarget(self, action: #selector(sureBtnAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var botTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "识别有误？"
        return label
    }()

    private lazy var newRecogBtn: UIButton = {
        let button = UIButton()
        button.setTitle("重新识别>", for: UIControlState.normal)
        button.setTitleColor(UIColorHex("00b2ff"), for: .normal)
        button.titleLabel?.font = UIFontSize(size: 15*UIRate)
        button.addTarget(self, action: #selector(newRecogBtnAction), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Action
    func sureBtnAction(){
        
    }
    
    func newRecogBtnAction(){
        
    }
    
    func textFieldAction(_ textField: UITextField){
        
    }
}
