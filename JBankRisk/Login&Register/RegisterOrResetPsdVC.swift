//
//  RegisterOrResetPsdVC.swift
//  JBankRisk
//
//  Created by 曹后红 on 16/10/12.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//  注册与重置密码两个界面


import UIKit
import SwiftyJSON

private var defaultSeconds: Int = 60
class RegisterOrResetPsdVC: UIViewController {

    ///注册与重置密码
    enum RegisterOrResetPsdViewType{
        ///注册界面,默认为注册界面
        case register
        ///重置密码界面
        case resetPsd
    }
    
    var isPush: Bool = true
    
    var viewType: RegisterOrResetPsdViewType = .register
    
    var timerHelper: TimerHelper?
    
    var phoneNum: String = ""
    
    override func viewDidLoad() {
       super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        codeTextField.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        timerHelper?.isTimerGoOn()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        timerHelper?.invalidateTimer()
    }
    
    init(viewType:RegisterOrResetPsdViewType, phoneNum: String) {
        super.init(nibName: nil, bundle: nil)
        self.viewType = viewType
        self.phoneNum = phoneNum
        
        self.setupUI()
        timerHelper = TimerHelper(button: sendCodeBtn);
        self.showView()
        if (timerHelper?.isNeedStartCount())!{
            self.sendCodeBtnAction()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showView(){
        switch viewType {
        case .register:
            self.navigationItem.title = "注册"
            self.view.addSubview(bottomTextLabel)
            self.view.addSubview(protocolBtn)
            
            bottomTextLabel.snp.makeConstraints { (make) in
                make.top.equalTo(registerBtn.snp.bottom).offset(12*UIRate)
                make.right.equalTo(self.view.snp.centerX)
            }
            
            protocolBtn.snp.makeConstraints { (make) in
                make.height.equalTo(25*UIRate)
                make.left.equalTo(bottomTextLabel.snp.right)
                make.centerY.equalTo(bottomTextLabel)
            }

            break
        case .resetPsd:
            self.title = "重置登录密码"
            self.registerBtn.setTitle("确认", for: .normal)
            break
        }
    }
    
    //MARK: - 基本UI
    func setupUI(){
        
        self.view.backgroundColor = defaultBackgroundColor
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"navigation_right_phone_18x21"), style: .plain, target: self, action: #selector(rightNavigationBarBtnAction))
        
        let aTap = UITapGestureRecognizer(target: self, action: #selector(tapViewAction))
        aTap.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(aTap)
        
        self.view.addSubview(textLabel)
        self.view.addSubview(phoneNumLabel)
        
        self.view.addSubview(holdView)
        self.view.addSubview(codeTextField)
        self.view.addSubview(registerBtn)
        self.view.addSubview(sendCodeBtn)
        
        self.view.addSubview(psdTextField)
        self.view.addSubview(clearImage)
        self.view.addSubview(seePsdImage)
        self.view.addSubview(clearBtn)
        self.view.addSubview(seePsdBtn)
        
        //分割线
        self.view.addSubview(divideLine1)
        self.view.addSubview(divideLine2)
        self.view.addSubview(divideLine3)
        self.view.addSubview(verticalLine)
       
        
        textLabel.snp.makeConstraints { (make) in
            make.top.equalTo(20*UIRate)
            make.centerX.equalTo(self.view)
        }
        
        phoneNumLabel.snp.makeConstraints { (make) in
            make.top.equalTo(textLabel.snp.bottom).offset(15*UIRate)
            make.centerX.equalTo(self.view)
        }
        
        phoneNumLabel.text = phoneNum
        
        holdView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(90*UIRate)
            make.top.equalTo(90*UIRate)
        }
        
        divideLine1.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(0.5*UIRate)
            make.top.equalTo(holdView)
        }
        
        divideLine2.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(0.5*UIRate)
            make.top.equalTo(holdView.snp.centerY)
        }
        
        divideLine3.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(0.5*UIRate)
            make.bottom.equalTo(holdView)
        }
        
        codeTextField.snp.makeConstraints { (make) in
            make.width.equalTo(200*UIRate)
            make.left.equalTo(15*UIRate)
            make.centerY.equalTo(holdView).offset(-22.5*UIRate)
        }
        
        verticalLine.snp.makeConstraints { (make) in
            make.width.equalTo(0.5*UIRate)
            make.height.equalTo(20*UIRate)
            make.left.equalTo(275*UIRate)
            make.centerY.equalTo(codeTextField)
        }
        
        sendCodeBtn.snp.makeConstraints { (make) in
            make.width.equalTo(100*UIRate)
            make.height.equalTo(45*UIRate)
            make.right.equalTo(holdView)
            make.centerY.equalTo(codeTextField)
        }
        
        psdTextField.snp.makeConstraints { (make) in
            make.width.equalTo(280*UIRate)
            make.left.equalTo(codeTextField)
            make.centerY.equalTo(holdView).offset(22.5*UIRate)
        }
        
        clearImage.snp.makeConstraints { (make) in
            make.width.height.equalTo(15*UIRate)
            make.right.equalTo(-50*UIRate)
            make.centerY.equalTo(psdTextField)
        }
        
        clearBtn.snp.makeConstraints { (make) in
            make.width.equalTo(25*UIRate)
            make.height.equalTo(45*UIRate)
            make.center.equalTo(clearImage)
        }
        
        seePsdImage.snp.makeConstraints { (make) in
            make.width.equalTo(18*UIRate)
            make.height.equalTo(13*UIRate)
            make.left.equalTo(clearImage.snp.right).offset(10*UIRate)
            make.centerY.equalTo(psdTextField)
        }
        
        seePsdBtn.snp.makeConstraints { (make) in
            make.width.equalTo(28*UIRate)
            make.height.equalTo(45*UIRate)
            make.center.equalTo(seePsdImage)
        }

        
        registerBtn.snp.makeConstraints { (make) in
            make.width.equalTo(SCREEN_WIDTH - 30*UIRate)
            make.height.equalTo(44*UIRate)
            make.left.equalTo(15*UIRate)
            make.top.equalTo(holdView.snp.bottom).offset(40*UIRate)
        }
        
    }

    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "已发送验证短信到"
        return label
    }()
    
    private lazy var phoneNumLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontBoldSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
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
    
    private lazy var divideLine3: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()
    
    private lazy var verticalLine: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColorHex("666666")
        return lineView
    }()

    ///验证码输入框
    private lazy var codeTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "请输入验证码"
        textField.keyboardType = .numberPad
        textField.tag = 10000
        textField.addTarget(self, action: #selector(textFieldAction(_:)), for: .editingChanged)
        return textField
    }()
    
    ///发送验证码按钮
    private lazy var sendCodeBtn: UIButton = {
        let button = UIButton()
        button.setTitle("60s后重发", for: UIControlState.normal)
        button.titleLabel?.font = UIFontSize(size: 15*UIRate)
        button.setTitleColor(UIColorHex("666666"), for: .normal)
        button.addTarget(self, action: #selector(sendCodeBtnAction), for: .touchUpInside)
        return button
    }()

    ///密码输入框
    private lazy var psdTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "请输入6-16位密码"
        textField.isSecureTextEntry = true
        textField.tag = 10001
        textField.addTarget(self, action: #selector(textFieldAction(_:)), for: .editingChanged)
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
    
    ///查看密码
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

    //／注册按钮
    private lazy var registerBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "login_btn_grayred_345x44"), for: .normal)
        button.isUserInteractionEnabled = false
        button.setTitle("注册", for: UIControlState.normal)
        button.titleLabel?.font = UIFontBoldSize(size: 18*UIRate)
        button.addTarget(self, action: #selector(registerBtnAction), for: .touchUpInside)
        return button
    }()
    
    ///同意协议text
    private lazy var bottomTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 12*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "注册代表你同意"
        return label
    }()

    ///中诚消费协议按钮
    private lazy var protocolBtn: UIButton = {
        let button = UIButton()
        button.setTitle("《中诚消费协议》", for: UIControlState.normal)
        button.titleLabel?.font = UIFontSize(size: 12*UIRate)
         button.setTitleColor(UIColorHex("00b2ff"), for: .normal)
        button.addTarget(self, action: #selector(protocolBtnAction), for: .touchUpInside)
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
        psdTextField.text = ""
        clearImage.isHidden = true
        seePsdImage.isHidden = true
        seePsdBtn.isUserInteractionEnabled = false

    }
    //显示密码
    func seePsdBtnAction(){
        
        if psdTextField.isSecureTextEntry {
            seePsdImage.image = UIImage(named: "login_btn_open_eyes_18x10.5")
            psdTextField.isSecureTextEntry = false
        }else
        {
            seePsdImage.image = UIImage(named: "login_btn_close_eyes_18x13")
            psdTextField.isSecureTextEntry = true
        }
    }

    ///注册
    func registerBtnAction(){
        self.view.endEditing(true)
        
        switch viewType {
        case .register:
            
            var params = NetConnect.getBaseRequestParams()
            params["mobile"] = self.phoneNum
            params["password"] = psdTextField.text!
            params["randCode"] = codeTextField.text!
            
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
        case .resetPsd:
            
            var params = NetConnect.getBaseRequestParams()
            params["mobile"] = self.phoneNum
            params["password"] = psdTextField.text!
            params["randCode"] = codeTextField.text!
            
            NetConnect.rl_changePsw(parameters: params, success:
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
                    self.showHintInKeywindow(hint: "密码重置并登录成功",yOffset: SCREEN_HEIGHT/2 - 100*UIRate)
                    
            }, failure: {error in
                
            })
        }
    }
    ///发送短信验证码
    func sendCodeBtnAction(){
        timerHelper?.startCount()
        NetSendCodeHelper.sendCodeToNumber(phoneNum, {[weak self] (descStr) in
            self?.showHint(in: (self?.view)!, hint: descStr)
        })
    }
    
    //消费协议
    func protocolBtnAction(){
        
        let webVC = BaseWebViewController()
        webVC.requestUrl = BM_APPLY_PROTOCOL
        webVC.webTitle = "中诚消费协议"
        self.navigationController?.pushViewController(webVC, animated: false
        )
    }
    
    func textFieldAction(_ textField: UITextField){
        
        // 10000:验证码  10001:密码
        if textField.tag == 10000 {
            
            //限制输入的长度，最长为4位
            if (textField.text?.characters.count)! > 4{
                let index = textField.text?.index((textField.text?.startIndex)!, offsetBy: 4)//到offsetBy的前一位
                textField.text = textField.text?.substring(to: index!)
            }
        }else{
            
            //限制输入的长度，最长为16位
            if (textField.text?.characters.count)! > 16{
                let index = textField.text?.index((textField.text?.startIndex)!, offsetBy: 16)//到offsetBy的前一位
                textField.text = textField.text?.substring(to: index!)
            }
            
            if (textField.text?.characters.count)! == 0{
                clearImage.isHidden = true
                seePsdImage.isHidden = true
                seePsdBtn.isUserInteractionEnabled = false
                
            }else
            {
                clearImage.isHidden = false
                seePsdImage.isHidden = false
                seePsdBtn.isUserInteractionEnabled = true
            }
        }
        
        //验证码为4位，密码位6-16位按钮可点击
        if (((psdTextField.text?.characters.count)! >= 6 && (psdTextField.text?.characters.count)! <= 16 ) && (codeTextField.text?.characters.count)! == 4){
            
            registerBtn.isUserInteractionEnabled = true
            registerBtn.setBackgroundImage(UIImage(named:"login_btn_red_345x44"), for: .normal)
        }else{
            
            registerBtn.isUserInteractionEnabled = false
            registerBtn.setBackgroundImage(UIImage(named:"login_btn_grayred_345x44"), for: .normal)
        }
    }
}
