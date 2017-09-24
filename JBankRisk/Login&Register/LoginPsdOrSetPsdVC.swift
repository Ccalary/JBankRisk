//
//  LoginPsdOrSetPsdVC.swift
//  JBankRisk
//
//  Created by 曹后红 on 16/10/12.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//  密码登录与设置密码

import UIKit
import SwiftyJSON

class LoginPsdOrSetPsdVC: UIViewController{

    ///密码登录与设置密码
    enum LoginPsdOrSetPsdViewType{
        ///密码登录
        case loginPassword
        ///未注册的设置密码
        case setPassword
    }
    
    var isPush: Bool = true
    
    var viewType = LoginPsdOrSetPsdViewType.loginPassword
    var phoneNum = ""
    var randCode = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       self.setupUI()
       self.showView()
    }

    init(viewType: LoginPsdOrSetPsdViewType, phoneNum: String) {
        super.init(nibName: nil, bundle: nil)
        self.viewType = viewType
        self.phoneNum = phoneNum
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        mTextField.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    func showView(){
        switch viewType {
        case .loginPassword:
            self.navigationItem.title = "登录"
            self.view.addSubview(forgetPsdBtn)
            
            forgetPsdBtn.snp.makeConstraints { (make) in
                make.top.equalTo(loginBtn.snp.bottom).offset(10*UIRate)
                make.right.equalTo(loginBtn)
            }

        case .setPassword:
            self.navigationItem.title = "设置密码"
            loginBtn.setTitle("确认", for: .normal)
            mTextField.placeholder = "请输入6-16位密码"
        }
    }
    
    func setupUI(){
        
        self.view.backgroundColor = defaultBackgroundColor
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"navigation_right_phone_18x21"), style: .plain, target: self, action: #selector(rightNavigationBarBtnAction))
        
        let aTap = UITapGestureRecognizer(target: self, action: #selector(tapViewAction))
        aTap.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(aTap)
        
        self.view.addSubview(holdView)
        self.view.addSubview(mTextField)
        
        self.view.addSubview(clearImage)
        self.view.addSubview(seePsdImage)
        self.view.addSubview(clearBtn)
        self.view.addSubview(seePsdBtn)
        
        self.view.addSubview(loginBtn)
    
        holdView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(45*UIRate)
            make.top.equalTo(8*UIRate)
        }
        mTextField.snp.makeConstraints { (make) in
            make.width.equalTo(SCREEN_WIDTH - 90*UIRate)
            make.height.equalTo(holdView)
            make.left.equalTo(15*UIRate)
            make.centerY.equalTo(holdView)
        }
        
        clearImage.snp.makeConstraints { (make) in
            make.width.height.equalTo(15*UIRate)
            make.right.equalTo(-50*UIRate)
            make.centerY.equalTo(holdView)
        }
        
        clearBtn.snp.makeConstraints { (make) in
            make.width.equalTo(25*UIRate)
            make.height.equalTo(holdView)
            make.center.equalTo(clearImage)
        }
        
        seePsdImage.snp.makeConstraints { (make) in
            make.width.equalTo(18*UIRate)
            make.height.equalTo(13*UIRate)
            make.left.equalTo(clearImage.snp.right).offset(10*UIRate)
            make.centerY.equalTo(holdView)
        }
        
        seePsdBtn.snp.makeConstraints { (make) in
            make.width.equalTo(28*UIRate)
            make.height.equalTo(holdView)
            make.center.equalTo(seePsdImage)
        }
        
        loginBtn.snp.makeConstraints { (make) in
            make.width.equalTo(SCREEN_WIDTH - 30*UIRate)
            make.height.equalTo(44*UIRate)
            make.left.equalTo(15*UIRate)
            make.top.equalTo(holdView.snp.bottom).offset(40*UIRate)
            
        }
    }
    
    private lazy var holdView: UIView = {
        let holdView = UIView()
        holdView.backgroundColor = UIColor.white
        return holdView
    }()
    
    //输入框
    private lazy var mTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "请输入密码"
        textField.keyboardType = .asciiCapable
        textField.isSecureTextEntry = true
        textField.addTarget(self, action: #selector(mTextFieldAction(_:)), for: .editingChanged)
        return textField
    }()
    
    //清除按钮
    private lazy var clearImage: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        imageView.image = UIImage(named: "login_btn_clear_15x15")
        return imageView
    }()
    
    private lazy var clearBtn: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(clearBtnAction), for: .touchUpInside)
        return button
    }()
    
    //查看密码
    private lazy var seePsdImage: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        imageView.image = UIImage(named: "login_btn_close_eyes_18x13")
        return imageView
    }()

    private lazy var seePsdBtn: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(seePsdBtnAction), for: .touchUpInside)
        return button
    }()
    
    //登录按钮
    private lazy var loginBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "login_btn_grayred_345x44"), for: .normal)
        button.isUserInteractionEnabled = false
        button.setTitle("登录", for: UIControlState.normal)
        button.titleLabel?.font = UIFontBoldSize(size: 18*UIRate)
        button.addTarget(self, action: #selector(loginBtnAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var forgetPsdBtn: UIButton = {
        let button = UIButton()
        button.setTitle("忘记密码？", for: UIControlState.normal)
        button.titleLabel?.font = UIFontBoldSize(size: 12*UIRate)
        button.setTitleColor(UIColorHex("00b2ff"), for: .normal)
        button.addTarget(self, action: #selector(forgetPsdBtnAction), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: - action
    //电话按钮点击
    func rightNavigationBarBtnAction(){
        
        self.view.endEditing(true)
        
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
    
    func tapViewAction(){
        self.view.endEditing(true)
    }
    
    //清除按钮
    func clearBtnAction(){
        mTextField.text = ""
        clearImage.isHidden = true
        seePsdImage.isHidden = true
        seePsdBtn.isUserInteractionEnabled = false
    }
    //显示密码
    func seePsdBtnAction(){
        
        if mTextField.isSecureTextEntry {
            seePsdImage.image = UIImage(named: "login_btn_open_eyes_18x10.5")
            mTextField.isSecureTextEntry = false
        }else
        {
            seePsdImage.image = UIImage(named: "login_btn_close_eyes_18x13")
            mTextField.isSecureTextEntry = true
        }
    }
    
    //登录
    func loginBtnAction(){
        self.view.endEditing(true)
        
        switch self.viewType {
        case .loginPassword:
            let psd = mTextField.text!
            
            var params = NetConnect.getBaseRequestParams()
            params["mobile"] = self.phoneNum
            params["password"] = psd
            
            NetConnect.rl_normalLogin(parameters: params, success:
                { response in
                    let json = JSON(response)
                    guard json["RET_CODE"] == "000000" else{
                        return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
                    }
                    UserHelper.setLoginInfo(dic: json)
                    JPUSHService.setTags(["user"], aliasInbackground: UserHelper.getUserId())
                    
                    if !self.isPush{
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: notificationLoginSuccess), object: self)
                    }
                    
                    _ = self.navigationController?.popToRootViewController(animated: true)
                    self.showHintInKeywindow(hint: "登录成功",yOffset: SCREEN_HEIGHT/2 - 100*UIRate)
                    
            }, failure: {error in
            })

        case .setPassword:
            
            let psd = mTextField.text!
            
            var params = NetConnect.getBaseRequestParams()
            params["mobile"] = self.phoneNum
            params["password"] = psd
            params["randCode"] = self.randCode
            
            NetConnect.rl_register(parameters: params, success:
                { response in
                    let json = JSON(response)
                    guard json["RET_CODE"] == "000000" else{
                        return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
                    }
                    UserHelper.setLoginInfo(dic: json)
                     JPUSHService.setTags(["user"], aliasInbackground: UserHelper.getUserId())
                    
                    if !self.isPush{
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: notificationLoginSuccess), object: self)
                    }
                    
                    _ = self.navigationController?.popToRootViewController(animated: true)
                    self.showHintInKeywindow(hint: "注册并登录成功",yOffset: SCREEN_HEIGHT/2 - 100*UIRate)
                    
            }, failure: {error in
                
            })
        }
    }
    //忘记密码
    func forgetPsdBtnAction(){
        
        self.view.endEditing(true)
        let registerVC = RegisterOrResetPsdVC(viewType: .resetPsd, phoneNum: self.phoneNum)
        registerVC.isPush = self.isPush
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    
    func mTextFieldAction(_ textField: UITextField){
       
        //6-16位
        if (textField.text?.characters.count)! < 6{
            loginBtn.setBackgroundImage(UIImage(named: "login_btn_grayred_345x44"), for: .normal)
            loginBtn.isUserInteractionEnabled = false
            clearImage.isHidden = true
            seePsdImage.isHidden = true
            seePsdBtn.isUserInteractionEnabled = false
            
        }else
        {
            loginBtn.setBackgroundImage(UIImage(named: "login_btn_red_345x44"), for: .normal)
            loginBtn.isUserInteractionEnabled = true
            
            clearImage.isHidden = false
            seePsdImage.isHidden = false
            seePsdBtn.isUserInteractionEnabled = true
        }
        
        //限制输入的长度，最长为16位
        if (textField.text?.characters.count)! > 16{
            let index = textField.text?.index((textField.text?.startIndex)!, offsetBy: 16)//到offsetBy的前一位
            textField.text = textField.text?.substring(to: index!)
        }
    }
}

