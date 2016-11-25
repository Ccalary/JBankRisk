//
//  ResetPsdViewController.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/4.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit
import SwiftyJSON

class ResetPsdViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

       self.setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        }
    
    func setupUI(){
        self.view.backgroundColor = defaultBackgroundColor
        self.title = "修改密码"
        
        let aTap = UITapGestureRecognizer(target: self, action: #selector(tapViewAction))
        aTap.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(aTap)
        
        self.view.addSubview(holdView)
        self.holdView.addSubview(oldTextField)
        self.holdView.addSubview(newTextField)
        self.holdView.addSubview(againTextField)
        
        self.holdView.addSubview(clearBtn1)
        self.holdView.addSubview(seePsdImage1)
        self.holdView.addSubview(seePsdBtn1)
        
        self.holdView.addSubview(clearBtn2)
        self.holdView.addSubview(seePsdImage2)
        self.holdView.addSubview(seePsdBtn2)
        
        self.holdView.addSubview(clearBtn3)
        self.holdView.addSubview(seePsdImage3)
        self.holdView.addSubview(seePsdBtn3)
        
        self.holdView.addSubview(divideLine1)
        self.holdView.addSubview(divideLine2)
        self.holdView.addSubview(divideLine3)
        self.holdView.addSubview(divideLine4)
        
        self.view.addSubview(sureBtn)
        
        
        holdView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(135*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(10*UIRate + 64)
        }
        
        oldTextField.snp.makeConstraints { (make) in
            make.width.equalTo(SCREEN_WIDTH - 40*UIRate)
            make.height.equalTo(45*UIRate)
            make.left.equalTo(20*UIRate)
            make.top.equalTo(holdView)
        }

        newTextField.snp.makeConstraints { (make) in
            make.size.equalTo(oldTextField)
            make.left.equalTo(20*UIRate)
            make.centerY.equalTo(oldTextField).offset(45*UIRate)
        }
        
        againTextField.snp.makeConstraints { (make) in
            make.size.equalTo(oldTextField)
            make.left.equalTo(20*UIRate)
            make.centerY.equalTo(newTextField).offset(45*UIRate)
        }
        
        clearBtn1.snp.makeConstraints { (make) in
            make.width.height.equalTo(15*UIRate)
            make.right.equalTo(-50*UIRate)
            make.centerY.equalTo(oldTextField)
        }
        
        seePsdImage1.snp.makeConstraints { (make) in
            make.width.equalTo(18*UIRate)
            make.height.equalTo(13*UIRate)
            make.left.equalTo(clearBtn1.snp.right).offset(13*UIRate)
            make.centerY.equalTo(oldTextField)
        }

        seePsdBtn1.snp.makeConstraints { (make) in
            make.width.equalTo(30*UIRate)
            make.height.equalTo(30*UIRate)
            make.center.equalTo(seePsdImage1)
        }
        
        clearBtn2.snp.makeConstraints { (make) in
            make.width.height.equalTo(15*UIRate)
            make.right.equalTo(-50*UIRate)
            make.centerY.equalTo(newTextField)
        }
        
        seePsdImage2.snp.makeConstraints { (make) in
            make.width.equalTo(18*UIRate)
            make.height.equalTo(13*UIRate)
            make.left.equalTo(clearBtn2.snp.right).offset(13*UIRate)
            make.centerY.equalTo(newTextField)
        }
        
        seePsdBtn2.snp.makeConstraints { (make) in
            make.width.equalTo(30*UIRate)
            make.height.equalTo(30*UIRate)
            make.center.equalTo(seePsdImage2)
        }

        
        clearBtn3.snp.makeConstraints { (make) in
            make.width.height.equalTo(15*UIRate)
           make.right.equalTo(-50*UIRate)
            make.centerY.equalTo(againTextField)
        }
        
        
        seePsdImage3.snp.makeConstraints { (make) in
            make.width.equalTo(18*UIRate)
            make.height.equalTo(13*UIRate)
            make.left.equalTo(clearBtn3.snp.right).offset(13*UIRate)
            make.centerY.equalTo(againTextField)
        }
        
        seePsdBtn3.snp.makeConstraints { (make) in
            make.width.equalTo(30*UIRate)
            make.height.equalTo(30*UIRate)
            make.center.equalTo(seePsdImage3)
        }

        
        divideLine1.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(holdView)
        }
        
        divideLine2.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(newTextField)
        }
        
        divideLine3.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(againTextField)
        }
        
        divideLine4.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(holdView)
        }

        sureBtn.snp.makeConstraints { (make) in
            make.width.equalTo(345*UIRate)
            make.height.equalTo(44*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(holdView.snp.bottom).offset(75*UIRate)
        }
        
    }
    
    private lazy var holdView: UIView = {
        let holdView = UIView()
        holdView.backgroundColor = UIColor.white
        return holdView
    }()

    
    ///验证码输入框
    private lazy var oldTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "请输入原密码"
        textField.isSecureTextEntry = true
        textField.tag = 10000
        textField.addTarget(self, action: #selector(textFieldAction(_:)), for: .editingChanged)
        return textField
    }()
    
    ///验证码输入框
    private lazy var newTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "请输入6-16位新密码"
        textField.isSecureTextEntry = true
        textField.tag = 10001
        textField.addTarget(self, action: #selector(textFieldAction(_:)), for: .editingChanged)
        return textField
    }()
    
    ///验证码输入框
    private lazy var againTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "请再次输入新密码"
        textField.isSecureTextEntry = true
        textField.tag = 10002
        textField.addTarget(self, action: #selector(textFieldAction(_:)), for: .editingChanged)
        return textField
    }()
    
    ///查看密码
    private lazy var seePsdImage1: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        imageView.image = UIImage(named: "login_btn_close_eyes_18x13")
        return imageView
    }()
    
    
    private lazy var seePsdBtn1: UIButton = {
        let button = UIButton()
        button.tag = 20001
        button.addTarget(self, action: #selector(seePsdBtnAction), for: .touchUpInside)
        return button
    }()

    
    private lazy var clearBtn1: UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.tag = 10000
        button.setBackgroundImage(UIImage(named:"login_btn_clear_15x15"), for: .normal)
        button.addTarget(self, action: #selector(clearBtnAction(_:)), for: .touchUpInside)
        return button
    }()

    
    ///查看密码
    private lazy var seePsdImage2: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        imageView.image = UIImage(named: "login_btn_close_eyes_18x13")
        return imageView
    }()
    
    
    private lazy var seePsdBtn2: UIButton = {
        let button = UIButton()
        button.tag = 20002
        button.addTarget(self, action: #selector(seePsdBtnAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var clearBtn2: UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.tag = 10001
         button.setBackgroundImage(UIImage(named:"login_btn_clear_15x15"), for: .normal)
        button.addTarget(self, action: #selector(clearBtnAction(_:)), for: .touchUpInside)
        return button
    }()

    ///查看密码
    private lazy var seePsdImage3: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        imageView.image = UIImage(named: "login_btn_close_eyes_18x13")
        return imageView
    }()
    
    
    private lazy var seePsdBtn3: UIButton = {
        let button = UIButton()
        button.tag = 20003
        button.addTarget(self, action: #selector(seePsdBtnAction), for: .touchUpInside)
        return button
    }()

    
    private lazy var clearBtn3: UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.tag = 10002
         button.setBackgroundImage(UIImage(named:"login_btn_clear_15x15"), for: .normal)
        button.addTarget(self, action: #selector(clearBtnAction(_:)), for: .touchUpInside)
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

    //分割线
    private lazy var divideLine4: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()
    
    //／按钮
    private lazy var sureBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "login_btn_grayred_345x44"), for: .normal)
        button.isUserInteractionEnabled = false
        button.setTitle("确认修改", for: UIControlState.normal)
        button.titleLabel?.font = UIFontBoldSize(size: 18*UIRate)
        button.addTarget(self, action: #selector(sureBtnAction), for: .touchUpInside)
        return button
    }()
    
    func tapViewAction(){
        self.view.endEditing(true)
    }
    
    //判断是否可以修改
    func judgeEnableOrNot(){
        guard (oldTextField.text?.characters.count)! > 0,
              (newTextField.text?.characters.count)! >= 6,
              (againTextField.text?.characters.count)! >= 6
            else {
            sureBtn.setBackgroundImage(UIImage(named: "login_btn_grayred_345x44"), for: .normal)
            sureBtn.isUserInteractionEnabled = false
            return
        }
        
        sureBtn.setBackgroundImage(UIImage(named: "login_btn_red_345x44"), for: .normal)
        sureBtn.isUserInteractionEnabled = true
    }
    
    func textFieldAction(_ textField: UITextField){
        
        if textField.tag == 10000 {
            if (textField.text?.characters.count)! > 0 {
                clearBtn1.isHidden = false
                seePsdImage1.isHidden = false
            }
        }
        
        if textField.tag == 10001 {
            if (textField.text?.characters.count)! > 0 {
                clearBtn2.isHidden = false
                seePsdImage2.isHidden = false
            }
        }
        
        if textField.tag == 10002 {
            if (textField.text?.characters.count)! > 0 {
                clearBtn3.isHidden = false
                seePsdImage3.isHidden = false
            }
        }
        
        //限制输入的长度，最长为16位
        if (textField.text?.characters.count)! > 16{
            let index = textField.text?.index((textField.text?.startIndex)!, offsetBy: 16)//到offsetBy的前一位
            textField.text = textField.text?.substring(to: index!)
        }
        self.judgeEnableOrNot()
    }
    
    func clearBtnAction(_ button: UIButton){
        if button.tag == 10000 {
            oldTextField.text = ""
            button.isHidden = true
            seePsdImage1.isHidden = true
        }
        
        if button.tag == 10001 {
            newTextField.text = ""
            button.isHidden = true
            seePsdImage2.isHidden = true
        }
        
        if button.tag == 10002 {
            againTextField.text = ""
            button.isHidden = true
            seePsdImage3.isHidden = true
        }
        
        sureBtn.setBackgroundImage(UIImage(named: "login_btn_grayred_345x44"), for: .normal)
        sureBtn.isUserInteractionEnabled = false

    }
    
    func seePsdBtnAction(_ button: UIButton){
        if button.tag == 20001 {
            
            if oldTextField.isSecureTextEntry {
                seePsdImage1.image = UIImage(named: "login_btn_open_eyes_18x10.5")
                oldTextField.isSecureTextEntry = false
            }else
            {
                seePsdImage1.image = UIImage(named: "login_btn_close_eyes_18x13")
                oldTextField.isSecureTextEntry = true
            }
        }
        
        if button.tag == 20002 {
            
            if newTextField.isSecureTextEntry {
                seePsdImage2.image = UIImage(named: "login_btn_open_eyes_18x10.5")
                newTextField.isSecureTextEntry = false
            }else
            {
                seePsdImage2.image = UIImage(named: "login_btn_close_eyes_18x13")
                newTextField.isSecureTextEntry = true
            }
        }
        
        if button.tag == 20003 {
    
            if againTextField.isSecureTextEntry {
                seePsdImage3.image = UIImage(named: "login_btn_open_eyes_18x10.5")
                againTextField.isSecureTextEntry = false
            }else
            {
                seePsdImage3.image = UIImage(named: "login_btn_close_eyes_18x13")
                againTextField.isSecureTextEntry = true
            }
        }
    }
    
    func sureBtnAction(){
        self.view.endEditing(true)
        self.requestData()
    }
    
    //更改密码接口
    func requestData(){
        //添加HUD
        self.showHud(in: self.view, hint: "加载中...")
        
        var params = NetConnect.getBaseRequestParams()
        params["userId"] = UserHelper.getUserId()!
        params["old_password"] = oldTextField.text
        params["new_password"] = newTextField.text
        params["reset_password"] = againTextField.text
        
        NetConnect.other_change_psd(parameters: params, success: { response in
            //隐藏HUD
            self.hideHud()
            let json = JSON(response)
            guard json["RET_CODE"] == "000000" else{
                return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
            }
             self.showHintInKeywindow(hint: "密码修改成功",yOffset: SCREEN_HEIGHT/2 - 150*UIRate)
           _ = self.navigationController?.popViewController(animated: true)
            
        }, failure:{ error in
            //隐藏HUD
            self.hideHud()
        })
    }
}



    
