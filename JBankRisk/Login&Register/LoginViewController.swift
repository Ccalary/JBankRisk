//
//  LoginViewController.swift
//  JBankRisk
//
//  Created by 曹后红 on 16/10/11.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//  登录首页

import UIKit
import SnapKit
import SwiftyJSON
import Alamofire

class LoginViewController: UIViewController {

    var errorContraints: Constraint?
    
    //是push 还是present
    var isPush = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

    override func viewDidAppear(_ animated: Bool) {
       mTextField.becomeFirstResponder()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   
    deinit {
        if !isPush{
            NotificationCenter.default.removeObserver(self)
        }
    }
    
    
    //MARK: - 基本UI
    func setupUI(){
        self.title = "登录"
        self.view.backgroundColor = defaultBackgroundColor
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"navigation_right_phone_18x21"), style: .plain, target: self, action: #selector(rightNavigationBarBtnAction))
        
        if !isPush{
            //左侧返回按钮
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"navigation_left_back_13x21"), style: .plain, target: self, action: #selector(navigationBack))
            
            NotificationCenter.default.addObserver(self, selector: #selector(LoginSuccessAction), name: NSNotification.Name(rawValue: notificationLoginSuccess), object: nil)
        }
        
        let aTap = UITapGestureRecognizer(target: self, action: #selector(tapViewAction))
        aTap.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(aTap)
        
        self.view.addSubview(textLabel)
        
        self.view.addSubview(holdView)
        self.view.addSubview(divideLine1)
        self.view.addSubview(divideLine2)
        
        self.view.addSubview(mTextField)
        self.view.addSubview(clearImage)
        self.view.addSubview(clearBtn)
        
        self.view.addSubview(nextStepBtn)
        self.view.addSubview(codeLoginBtn)
        self.view.addSubview(errorTextLabel)

        
        holdView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(45*UIRate)
            make.top.equalTo(textLabel.snp.bottom)
        }
        
        divideLine1.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(0.5*UIRate)
            make.top.equalTo(holdView)
        }
        
        divideLine2.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(0.5*UIRate)
            make.bottom.equalTo(holdView)
        }
        
        mTextField.snp.makeConstraints { (make) in
            make.width.equalTo(SCREEN_WIDTH - 30*UIRate)
            make.height.equalTo(holdView)
            make.left.equalTo(15*UIRate)
            make.centerY.equalTo(holdView)
        }
        
        clearImage.snp.makeConstraints { (make) in
            make.width.height.equalTo(15*UIRate)
            make.right.equalTo(-15*UIRate)
            make.centerY.equalTo(mTextField)
        }
        
        clearBtn.snp.makeConstraints { (make) in
            make.width.equalTo(25*UIRate)
            make.height.equalTo(holdView)
            make.center.equalTo(clearImage)
        }
        
        nextStepBtn.snp.makeConstraints { (make) in
            make.width.equalTo(SCREEN_WIDTH - 30*UIRate)
            make.height.equalTo(44*UIRate)
            make.left.equalTo(15*UIRate)
            make.top.equalTo(holdView.snp.bottom).offset(40*UIRate)
            
        }
        codeLoginBtn.snp.makeConstraints { (make) in
           make.top.equalTo(nextStepBtn.snp.bottom).offset(10*UIRate)
           make.right.equalTo(nextStepBtn)
        }
        
        errorTextLabel.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(40*UIRate)
            self.errorContraints = make.top.equalTo(0).constraint
        }
    }
    
    
   /*********/
   private lazy var textLabel: UILabel = {
       let label = UILabel(frame: CGRect(x: 0, y: 64, width: SCREEN_WIDTH, height: 60*UIRate))
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "请输入手机号码登录/注册"
        return label
    }()
    
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
    
    private lazy var divideLine2: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()
    
   private lazy var mTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "请输入手机号码"
        textField.keyboardType = .numberPad
    textField.addTarget(self, action: #selector(mTextFieldAction(_:)), for: .editingChanged)
        return textField
    }()
    
    ///清除按钮
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

    
    ///下一步按钮
   private lazy var nextStepBtn: UIButton = {
       let button = UIButton()
        button.setBackgroundImage(UIImage(named: "login_btn_grayred_345x44"), for: .normal)
        button.isUserInteractionEnabled = false
        button.setTitle("下一步", for: UIControlState.normal)
        button.titleLabel?.font = UIFontBoldSize(size: 18*UIRate)
        button.addTarget(self, action: #selector(nextStepBtnAction), for: .touchUpInside)
        return button
    }()
    
   /// 短信验证码登录
   private lazy var codeLoginBtn: UIButton = {
        let button = UIButton()
        button.setTitle("短信验证码登录", for: UIControlState.normal)
        button.titleLabel?.font = UIFontBoldSize(size: 12*UIRate)
        button.setTitleColor(UIColorHex("00b2ff"), for: .normal)
        button.addTarget(self, action: #selector(codeLoginBtnAction), for: .touchUpInside)
        return button
    }()
 
    /// 错误提示
    private lazy var errorTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.alpha = 0
        label.textColor = UIColorHex("e9342d")
        label.backgroundColor = UIColorHex("ffe0df")
        label.text = "请输入正确的手机号码"
        return label
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
        
        if self.errorTextLabel.alpha == 1 {
            self.hideErrorTips()
        }
    }
    
    //隐藏错误提示
    func hideErrorTips(){
        UIView.animate(withDuration: 0.5) {
            self.errorContraints?.update(offset: 0)
            self.errorTextLabel.alpha = 0
            self.view.layoutIfNeeded()
        }
    }
    
    ///清除按钮
    func clearBtnAction(){
        mTextField.text = ""
        clearImage.isHidden = true
        nextStepBtn.isUserInteractionEnabled = false
        nextStepBtn.setBackgroundImage(UIImage(named:"login_btn_grayred_345x44"), for: .normal)
        
        if self.errorTextLabel.alpha == 1 {
            self.hideErrorTips()
        }
    }
    
    //左侧返回按钮
    func navigationBack(){
        self.view.endEditing(true)
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    //下一步
    func nextStepBtnAction(){
        
        self.view.endEditing(true)
        
        let phoneNum = mTextField.text!
        
        var params = NetConnect.getBaseRequestParams()
        params["mobile"] = phoneNum
        params["password"] = "-1"
        
    NetConnect.rl_normalLogin(parameters: params, success:
            { response in
                let json = JSON(response)
                guard json["RET_CODE"] == "000000" else{
                    
                    if json["RET_CODE"] == "100101" {
                        UIView.animate(withDuration: 0.5) {
                            self.errorContraints?.update(offset: 64)
                            self.errorTextLabel.alpha = 1.0
                            self.view.layoutIfNeeded()
                        }
                        return
                    }else {
                         return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
                    }
                }
                ///0已注册1未注册
                if json["flag"] == "0" {
                    let loginPsdVC = LoginPsdOrSetPsdVC(viewType: .loginPassword, phoneNum: phoneNum)
                    loginPsdVC.isPush = self.isPush
                    self.navigationController?.pushViewController(loginPsdVC, animated: true)
                }else if json["flag"] == "1"{
                   let registerVC = RegisterOrResetPsdVC(viewType: .register, phoneNum: phoneNum)
                    registerVC.isPush = self.isPush
                    registerVC.viewType = .register
                    self.navigationController?.pushViewController(registerVC, animated: true)
                    
                    //发送验证码
                    self.sendRandomCodeTo(number: phoneNum)
                }
        }, failure: {error in
        })
    }
    //短信验证码登录
    func codeLoginBtnAction(){
    
        self.view.endEditing(true)
        let loginCodeVC = LoginCodeViewController()
        loginCodeVC.isPush = self.isPush
        self.navigationController?.pushViewController(loginCodeVC, animated: true)
    }
    
    func mTextFieldAction(_ textField: UITextField){
        
        if (textField.text?.characters.count)! == 0 {
            clearImage.isHidden = true
        }else
        {
            clearImage.isHidden = false
        }
        
        //限制输入的长度，最长为11位
        if (textField.text?.characters.count)! > 11{
            let index = textField.text?.index((textField.text?.startIndex)!, offsetBy: 11)//到offsetBy的前一位
            textField.text = textField.text?.substring(to: index!)
        }
        
        if (textField.text?.characters.count)! == 11 {
            nextStepBtn.isUserInteractionEnabled = true
            nextStepBtn.setBackgroundImage(UIImage(named:"login_btn_red_345x44"), for: .normal)
        }else
        {
            nextStepBtn.isUserInteractionEnabled = false
            nextStepBtn.setBackgroundImage(UIImage(named:"login_btn_grayred_345x44"), for: .normal)
        }
        
        if self.errorTextLabel.alpha == 1 {
            self.hideErrorTips()
        }
 
    }
    
    ///发送验证码
    func sendRandomCodeTo(number: String){
        var params = NetConnect.getBaseRequestParams()
        params["mobile"] = number
        NetConnect.rl_randomCode(parameters: params, success:
            { response in
                let json = JSON(response)
                guard json["RET_CODE"] == "000000" else{
                    return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
                }
                PrintLog("验证码发送成功")
            }, failure: {error in
        })
    }
    
    //MARK: Noticifation
    func LoginSuccessAction(){
        self.navigationController?.dismiss(animated: true, completion: nil)
        self.tabBarController?.selectedIndex = 1
    }
    
}
