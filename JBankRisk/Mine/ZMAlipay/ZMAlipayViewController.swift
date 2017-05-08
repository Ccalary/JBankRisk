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
           imageView.image = UIImage(named:"repay_success_20x20")
           textLabel.text = "您已授权成功！"
        }else if (authorized == "false" && UserHelper.getIsShowedZhiMa()){
            imageView.image = UIImage(named:"repay_fail_20x20")
            textLabel.text = "您已授权失败！"
        }else {
            imageView.image = UIImage(named:"repay_fail_20x20")
            textLabel.text = "请先进行身份认证！"
            nextStepBtn.isHidden = false
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
            make.width.height.equalTo(20*UIRate)
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
        button.addTarget(self, action: #selector(nextStepBtnAction), for: .touchUpInside)
        return button
    }()
    
    //分割线
    private lazy var divideLine1: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = ColorTextBlue
        return lineView
    }()

    //MARK: - Action
    func nextStepBtnAction(){
        if UserHelper.getUserRole() == nil {
            UserHelper.setUserRole(role: "白领")
        }
        let borrowMoneyVC = BorrowMoneyViewController()
        borrowMoneyVC.currentIndex = 0
        self.navigationController?.pushViewController(borrowMoneyVC, animated: false)
    }
}
