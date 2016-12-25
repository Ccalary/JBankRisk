//
//  BorrowMoneyView.swift
//  JBankRisk
//
//  Created by 曹后红 on 16/10/14.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

class BorrowMoneyView: UIView {

    ///界面类型
    enum ViewType: String {
        case identity = "身份信息"
        case product = "产品信息"
        case work = "工作信息"
        case school = "学校信息"
        case income = "收入信息"
        case contact = "联系人信息"
        case data = "资料上传"
    }

    var mViewType: ViewType = .identity
    
    init(viewType: ViewType){
        let frame = CGRect(x: 0, y: 0, width: 250*UIRate, height: 350*UIRate)
        super.init(frame:frame)
        
        self.mViewType = viewType
        
        self.setupUI()
        self.showViewWithType()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    ///根据类型选择View
    func showViewWithType(){
        
        titleLabel.text = mViewType.rawValue
        
        switch mViewType {
        case .identity:
            holdImageView.image = UIImage(named: "info_identity_image_250x350")
            titleLabel.textColor = UIColorHex("4bc4fa")
            describeLabel.text = "请留下最真实的自己"
            writeBtn.setTitle("表明身份", for: .normal)
        case .product:
            holdImageView.image = UIImage(named: "info_product_image_250x350")
            titleLabel.textColor = UIColorHex("f5db65")
            describeLabel.text = "消费项目/借款金额/期限等信息"
            writeBtn.setTitle("填写产品", for: .normal)
        case .work:
            holdImageView.image = UIImage(named: "info_work_image_250x350")
            titleLabel.textColor = UIColorHex("64d0b1")
            describeLabel.text = "您目前在哪就职"
            writeBtn.setTitle("登记职位", for: .normal)
        case .school:
            holdImageView.image = UIImage(named: "info_school_image_250x350")
            titleLabel.textColor = UIColorHex("85b7ee")
            describeLabel.text = "您目前在哪里上学"
            writeBtn.setTitle("登记学校", for: .normal)
        case .income:
            holdImageView.image = UIImage(named: "info_income_image_250x350")
            titleLabel.textColor = UIColorHex("dfe852")
            describeLabel.text = "您的资金收入情况"
            writeBtn.setTitle("收入来源", for: .normal)
        case .contact:
            holdImageView.image = UIImage(named: "info_contact_image_250x350")
            titleLabel.textColor = UIColorHex("73dd58")
            describeLabel.text = "让身边的人支持你"
            writeBtn.setTitle("捧个人场", for: .normal)
        case .data:
            holdImageView.image = UIImage(named: "info_data_image_250x350")
            titleLabel.textColor = UIColorHex("fb9864")
            describeLabel.text = "身份证/工资流水/现场照等"
            writeBtn.setTitle("附件上传", for: .normal)
    }
}
    
    //基本UI
    func setupUI(){
        
        self.addSubview(holdImageView)
        self.addSubview(titleLabel)
        self.addSubview(describeLabel)
        self.addSubview(writeBtn)
        
        self.addSubview(holdTipsView)
        self.holdTipsView.addSubview(lockImageView)
        self.holdTipsView.addSubview(tipTextLabel)
        
        holdImageView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 250*UIRate, height: 350*UIRate))
            make.center.equalTo(self)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(23*UIRate)
            make.centerX.equalTo(holdImageView)
        }
        
        describeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10*UIRate)
            make.centerX.equalTo(holdImageView)
        }
        
        writeBtn.snp.makeConstraints { (make) in
            make.width.equalTo(150*UIRate)
            make.height.equalTo(44*UIRate)
            make.bottom.equalTo(self).offset(-20*UIRate)
            make.centerX.equalTo(holdImageView)
        }
        
        holdTipsView.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.height.equalTo(40*UIRate)
            make.bottom.equalTo(self).offset(-30*UIRate)
            make.left.equalTo(self)
        }
        
        lockImageView.snp.makeConstraints { (make) in
            make.width.equalTo(30*UIRate)
            make.height.equalTo(30*UIRate)
            make.centerY.equalTo(holdTipsView)
            make.left.equalTo(holdTipsView).offset(50*UIRate)
        }
        
        tipTextLabel.snp.makeConstraints { (make) in
            make.left.equalTo(lockImageView.snp.right).offset(7*UIRate)
            make.centerY.equalTo(lockImageView)
        }

    }
    
    private lazy var holdImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "info_identity_image_250x350")
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 20*UIRate)
        return label
    }()
    
    private lazy var describeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textColor = UIColorHex("666666")
        return label
    }()

    //按钮
    lazy var writeBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named:"btn_green_150x44"), for: .normal)
        button.titleLabel?.font = UIFontBoldSize(size: 18*UIRate)
        button.addTarget(self, action: #selector(writeBtnAction), for: .touchUpInside)
        return button
    }()
    
    ///承载锁和提示语,默认隐藏
     lazy var holdTipsView: UIView = {
        let holdView = UIView()
        holdView.isHidden = true
        return holdView
    }()
    
    //锁
    private lazy var lockImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icon_lock_30x30")
        return imageView
    }()
    
    //提示语
   private lazy var tipTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 12*UIRate)
        label.textColor = UIColorHex("919191")
        label.numberOfLines = 0
        label.text = "需完成之前的步骤\n才能进入呦"
        return label
    }()

    var onClickBtn: ((_ viewType: ViewType)->())?
    
    //MARK: - Action
    func writeBtnAction(){
        if let onClickBtn = onClickBtn {
            onClickBtn(self.mViewType)
        }
    }
}
