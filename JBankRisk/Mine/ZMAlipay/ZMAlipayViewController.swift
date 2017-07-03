//
//  ZMAlipayViewController.swift
//  JBankRisk
//
//  Created by caohouhong on 17/5/4.
//  Copyright © 2017年 jingjinsuo. All rights reserved.
//

import UIKit
import SwiftyJSON

class ZMAlipayViewController: UIViewController {
    
    //芝麻认证授权状态
    var authorized = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.setupUI()
        self.showViewWithStatus()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //根据授权结果展示界面
    func showViewWithStatus(){
        
        if authorized == "true"{//授权成功
           imageView.image = UIImage(named:"zhima_success_45x45")
           textLabel.text = "您已授权成功！"
        }else if (authorized == "false" && UserHelper.getIsShowedZhiMa()){
            imageView.image = UIImage(named:"zhima_fail_45x45")
            textLabel.text = "您还未授权芝麻信用认证！"
            nextStepBtn.isHidden = false;
            nextStepBtn.setTitle("点击去授权", for: .normal)
            nextStepBtn.tag = 10000
        }else {
            imageView.image = UIImage(named:"zhima_fail_45x45")
            textLabel.text = "请先进行身份认证！"
            nextStepBtn.isHidden = false
            nextStepBtn.setTitle("点击去认证", for: .normal)
            nextStepBtn.tag = 10001;
        }
    }
    
    func setupUI(){
        self.navigationItem.title = "授权结果"
        self.view.backgroundColor = defaultBackgroundColor
        
        self.view.addSubview(imageView)
        self.view.addSubview(textLabel)
        self.view.addSubview(nextStepBtn)
        self.nextStepBtn.addSubview(divideLine1)
        
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.width.height.equalTo(45*UIRate)
            make.top.equalTo(45*UIRate + 64)
        }
        
        textLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.view)
            make.height.equalTo(20*UIRate)
            make.top.equalTo(imageView.snp.bottom).offset(25*UIRate)
        }
        
        nextStepBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.width.equalTo(80*UIRate)
            make.height.equalTo(16*UIRate)
            make.top.equalTo(textLabel.snp.bottom).offset(10*UIRate)
        }

        divideLine1.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.width.equalTo(nextStepBtn)
            make.height.equalTo(1)
            make.bottom.equalTo(nextStepBtn)
        }
    }
    
    //图片
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 18*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = ""
        return label
    }()
    
    //／按钮
    private lazy var nextStepBtn: UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.setTitle("点击去认证", for: UIControlState.normal)
        button.titleLabel?.font = UIFontSize(size: 15*UIRate)
        button.setTitleColor(ColorTextBlue, for: .normal)
        button.addTarget(self, action: #selector(nextStepBtnAction(_:)), for: .touchUpInside)
        return button
    }()
    
    //分割线
    private lazy var divideLine1: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = ColorTextBlue
        return lineView
    }()

    //MARK: - Action
    func nextStepBtnAction(_ button: UIButton){
        
        if button.tag == 10000 {//未授权
            self.requestZhiMaUrl()
            
        }else if button.tag == 10001{ //未身份认证
            if UserHelper.getUserRole() == nil {
                UserHelper.setUserRole(role: "白领")
            }
            let borrowMoneyVC = BorrowMoneyViewController()
            borrowMoneyVC.currentIndex = 0
            self.navigationController?.pushViewController(borrowMoneyVC, animated: false)
        }
    }
    
    //MARK: - 芝麻信用授权数据请求
    func requestZhiMaUrl(){
        
        let params = NetConnect.getBaseRequestParams()
        
        NetConnect.bm_income_get_zhima_url(parameters: params, success: { response in
            //隐藏HUD
            self.hideHud()
            let json = JSON(response)
            guard json["RET_CODE"] == "000000" else{
                return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
            }
            let url = json["zmxyUrl"].stringValue
            self.doVerify(url)
            
        }, failure:{ error in
            //隐藏HUD
            self.hideHud()
            self.showHint(in: self.view, hint: "网络请求失败")
        })
    }
    
    //MARK: - 芝麻信用授权
    func doVerify(_ url: String){
        // 这里使用固定appid 20000067
        let urlEncode = OCTools.urlEncodedString(withUrl: url);
        var alipayUrl = "alipays://platformapi/startapp?appId=20000067&url=";
        if let urlEncode = urlEncode {
            alipayUrl = alipayUrl + urlEncode
        }
        
        if self.canOpenAlipay(){
            //返回
            _ = self.navigationController?.popViewController(animated: true)
            //延时执行
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3){
                 UIApplication.shared.openURL(URL(string: alipayUrl)!)
            }
            
        }else {
            let alertViewVC = UIAlertController(title: "", message: "是否下载并安装支付宝完成认证?", preferredStyle: UIAlertControllerStyle.alert)
            
            let cancel = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler:nil)
            let confirm = UIAlertAction(title: "好的", style: .default, handler: { _ in
                let appstoreUrl = "itms-apps://itunes.apple.com/app/id333206289";
                UIApplication.shared.openURL(URL(string: appstoreUrl)!)
            })
            alertViewVC.addAction(cancel)
            alertViewVC.addAction(confirm)
            self.present(alertViewVC, animated: true, completion: nil)
        }
    }
    
    
    func canOpenAlipay() -> Bool{
        return UIApplication.shared.canOpenURL(URL(string: "alipays://")!)
    }
}
