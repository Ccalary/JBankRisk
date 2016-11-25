//
//  ChangePhoneNumVC.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/4.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit
import SwiftyJSON

//默认倒计时时间
private var defaultSeconds: Int = 60

class ChangePhoneNumVC: UIViewController {

    var mTimer: Timer!
    var seconds: Int = defaultSeconds
    
    //手机号修改成功
    var onClickChangeSuccess:(()->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        oldPhoneNumLabel.text = UserHelper.getUserMobile()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        phoneNumField.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func setupUI(){
        self.title = "修改手机号码"
        self.view.backgroundColor = defaultBackgroundColor
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"navigation_right_phone_18x21"), style: .plain, target: self, action: #selector(rightNavigationBarBtnAction))
        
        let aTap = UITapGestureRecognizer(target: self, action: #selector(tapViewAction))
        aTap.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(aTap)
        
        self.view.addSubview(phoneNumLabel)
        self.view.addSubview(oldPhoneNumLabel)
        self.view.addSubview(holdView)
        
        self.holdView.addSubview(phoneNumField)
        self.holdView.addSubview(clearImage)
        self.holdView.addSubview(clearBtn)
        
        self.holdView.addSubview(codeTextField)
        
        self.holdView.addSubview(sendCodeBtn)
        
        //分割线
        self.holdView.addSubview(divideLine1)
        self.holdView.addSubview(divideLine2)
        self.holdView.addSubview(divideLine3)
        self.holdView.addSubview(verticalLine)
        
        self.view.addSubview(sureBtn)
        
        
        phoneNumLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(60 + 20*UIRate)
        }
        
        oldPhoneNumLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(phoneNumLabel.snp.bottom).offset(15*UIRate)
        }
        
        holdView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(90*UIRate)
            make.top.equalTo(90*UIRate + 64)
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
        
        phoneNumField.snp.makeConstraints { (make) in
            make.width.equalTo(280*UIRate)
            make.left.equalTo(15*UIRate)
            make.centerY.equalTo(holdView).offset(-22.5*UIRate)
        }
        
        clearImage.snp.makeConstraints { (make) in
            make.width.height.equalTo(15*UIRate)
            make.right.equalTo(-15*UIRate)
            make.centerY.equalTo(phoneNumField)
        }
        
        clearBtn.snp.makeConstraints { (make) in
            make.width.equalTo(25*UIRate)
            make.height.equalTo(45*UIRate)
            make.center.equalTo(clearImage)
        }
        
        codeTextField.snp.makeConstraints { (make) in
            make.width.equalTo(200*UIRate)
            make.left.equalTo(15*UIRate)
            make.centerY.equalTo(holdView).offset(22.5*UIRate)
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
        
        sureBtn.snp.makeConstraints { (make) in
            make.width.equalTo(SCREEN_WIDTH - 30*UIRate)
            make.height.equalTo(44*UIRate)
            make.left.equalTo(15*UIRate)
            make.top.equalTo(holdView.snp.bottom).offset(40*UIRate)
        }
        
    }
    
    private lazy var phoneNumLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "当前手机号"
        return label
    }()
    
    private lazy var oldPhoneNumLabel: UILabel = {
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
    
    ///手机号码输入框
    private lazy var phoneNumField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "请输入手机号码"
        textField.keyboardType = .numberPad
        textField.tag = 10000
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
    
    
    ///验证码输入框
    private lazy var codeTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "请输入验证码"
        textField.keyboardType = .numberPad
        textField.tag = 10001
        textField.addTarget(self, action: #selector(textFieldAction(_:)), for: .editingChanged)
        return textField
    }()
    
    ///发送验证码按钮
    private lazy var sendCodeBtn: UIButton = {
        let button = UIButton()
        button.setTitle("获取验证码", for: UIControlState.normal)
        button.titleLabel?.font = UIFontSize(size: 15*UIRate)
        button.setTitleColor(UIColorHex("00b2ff"), for: .normal)
        button.addTarget(self, action: #selector(sendCodeBtnAction), for: .touchUpInside)
        return button
    }()
    
    //／确认按钮
    private lazy var sureBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "login_btn_grayred_345x44"), for: .normal)
        button.isUserInteractionEnabled = false
        button.setTitle("确认修改", for: UIControlState.normal)
        button.titleLabel?.font = UIFontBoldSize(size: 18*UIRate)
        button.addTarget(self, action: #selector(sureBtnAction), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Timer
    func startCount(){
        seconds = defaultSeconds
        sendCodeBtn.isUserInteractionEnabled = false
        mTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown(_:)), userInfo: nil, repeats: true)
    }
    
    //时间倒计时
    func countDown(_ timer: Timer){
        if seconds > 0{
            seconds -= 1
            sendCodeBtn.setTitle("\(seconds)s后重发", for: .normal)
            sendCodeBtn.setTitleColor(UIColorHex("666666"), for: .normal)
        }else if seconds == 0{
            timer.invalidate()
            sendCodeBtn.isUserInteractionEnabled = true
            sendCodeBtn.setTitle("重新发送", for: UIControlState.normal)
            sendCodeBtn.setTitleColor(UIColorHex("00b2ff"), for: .normal)
        }
        
    }
    //MARK: - action
    
    //电话按钮点击
    func rightNavigationBarBtnAction(){
        
        self.view.endEditing(true)
        
        let phoneCallView = PopupPhoneCallView()
        let popupController = CNPPopupController(contents: [phoneCallView])!
        popupController.present(animated: true)
        
        phoneCallView.onClickCancle = {_ in
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
        phoneNumField.text = ""
        clearImage.isHidden = true
    }
    ///确认按钮
    func sureBtnAction(){
        self.view.endEditing(true)
        
        //添加HUD
        self.showHud(in: self.view, hint: "加载中...")
        
        let phoneNum = phoneNumField.text!
        let randCode = codeTextField.text!
        
        var params = NetConnect.getBaseRequestParams()
        params["userId"] = UserHelper.getUserId()!
        params["mobile"] = phoneNum
        params["randCode"] = randCode
        
        NetConnect.other_change_mobile(parameters: params, success: { response in
            //隐藏HUD
            self.hideHud()
            let json = JSON(response)
            guard json["RET_CODE"] == "000000" else{
                return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
            }
            UserHelper.setUserMobile(mobile: json["mobile"].stringValue)
            
            self.showHintInKeywindow(hint: "手机号码修改成功",yOffset: SCREEN_HEIGHT/2 - 150*UIRate)
            _ = self.navigationController?.popViewController(animated: true)
            
            if let onClickChangeSuccess = self.onClickChangeSuccess {
                onClickChangeSuccess()
            }
            
        }, failure:{ error in
            //隐藏HUD
            self.hideHud()
        })
    
    }
    ///发送短信验证码
    func sendCodeBtnAction(){
        
        let phoneNum = phoneNumField.text!
        guard (phoneNumField.text?.characters.count)! == 11 else {
            self.showHint(in: self.view, hint: "请输入正确的手机号码")
            return
        }
        self.startCount()
        self.sendRandomCodeTo(number: phoneNum)
        
    }
    func textFieldAction(_ textField: UITextField){
        
        // 10000:手机号   10001:验证码
        if textField.tag == 10001 {
            
            //限制输入的长度，最长为4位
            if (textField.text?.characters.count)! > 4{
                let index = textField.text?.index((textField.text?.startIndex)!, offsetBy: 4)//到offsetBy的前一位
                textField.text = textField.text?.substring(to: index!)
            }
        }else{
            
            //限制输入的长度，最长为11位
            if (textField.text?.characters.count)! > 11{
                let index = textField.text?.index((textField.text?.startIndex)!, offsetBy: 11)//到offsetBy的前一位
                textField.text = textField.text?.substring(to: index!)
            }
            
            if (textField.text?.characters.count)! == 0{
                clearImage.isHidden = true
                
            }else
            {
                clearImage.isHidden = false
            }
        }
        
        //验证码为4位，手机号位11位
        if (((phoneNumField.text?.characters.count)! == 11) && (codeTextField.text?.characters.count)! == 4){
            
            sureBtn.isUserInteractionEnabled = true
            sureBtn.setBackgroundImage(UIImage(named:"login_btn_red_345x44"), for: .normal)
        }else{
            
            sureBtn.isUserInteractionEnabled = false
        sureBtn.setBackgroundImage(UIImage(named:"login_btn_grayred_345x44"), for: .normal)
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
        }, failure: {error in
        })
    }
    
}
