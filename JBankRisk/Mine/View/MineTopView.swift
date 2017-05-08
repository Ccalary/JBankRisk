//
//  MineTopView.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/18.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit
import SnapKit

protocol MineTioViewClickDelegate {
    
    func mineTopViewOnClick(tag: Int)
}

class MineTopView: UIView {

    //逾期提醒
    var tipsHoldViewContraint: Constraint!
    //本月待还
    var repayHoldViewContraint: Constraint!
    
    var delegate: MineTioViewClickDelegate?
    
    override init(frame: CGRect ) {
        super.init(frame: frame)
        setupUI()
    }
    
    ///初始化默认frame
    convenience init() {
        let frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 315*UIRate)
        self.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   func setupUI() {
    
        self.backgroundColor = defaultBackgroundColor
    
        self.addSubview(topImageView)
        self.addSubview(messageBtn)
        self.messageBtn.addSubview(messageRedDot)
        self.addSubview(settingBtn)
        self.addSubview(headerHolderView)
        self.addSubview(headerImageView)
        self.addSubview(headerButton)
        self.addSubview(sayHelloTextLabel)
        
        /*****************/
        self.addSubview(tipsHoldView)
        self.tipsHoldView.addSubview(tipsTextLabel)
        self.addSubview(overdueBtn)
        
        /*************/
        self.addSubview(repayHoldView)
        self.repayHoldView.addSubview(repayDivideLine)
        self.repayHoldView.addSubview(repayDivideLine2)
        self.repayHoldView.addSubview(repayVerDivideLine)
        self.repayHoldView.addSubview(moneyLabel)
        self.repayHoldView.addSubview(moneyTextLabel)
        self.repayHoldView.addSubview(dateLabel)
        self.repayHoldView.addSubview(dateTextLabel)
        self.repayHoldView.addSubview(reBottomHoldView)
    
        
        topImageView.snp.makeConstraints { (make) in
        make.width.equalTo(self)
        make.height.equalTo(220*UIRate)
        make.top.equalTo(self)
        }
        
        messageBtn.snp.makeConstraints { (make) in
        make.width.height.equalTo(25*UIRate)
        make.left.equalTo(10*UIRate)
        make.top.equalTo(30*UIRate)
        }
        
        messageRedDot.snp.makeConstraints { (make) in
        make.width.height.equalTo(6*UIRate)
        make.centerX.equalTo(6.5*UIRate)
        make.centerY.equalTo(-6.5*UIRate)
        }
        
        settingBtn.snp.makeConstraints { (make) in
        make.width.height.equalTo(25*UIRate)
        make.right.equalTo(topImageView.snp.right).offset(-10*UIRate)
        make.top.equalTo(30*UIRate)
        }
    
       headerHolderView.snp.makeConstraints { (make) in
        make.width.height.equalTo(96*UIRate)
        make.centerX.equalTo(self)
        make.top.equalTo(62*UIRate)
       }
    
        headerImageView.snp.makeConstraints { (make) in
        make.width.height.equalTo(90*UIRate)
        make.center.equalTo(headerHolderView)
        }
    
        headerButton.snp.makeConstraints { (make) in
        make.size.equalTo(headerImageView)
        make.center.equalTo(headerImageView)
    }

    
        sayHelloTextLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(topImageView.snp.bottom).offset(-30*UIRate)
            make.centerX.equalTo(self)
        }
        
        /********/
        tipsHoldView.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            self.tipsHoldViewContraint = make.height.equalTo(25*UIRate).constraint
            make.centerX.equalTo(self)
            make.top.equalTo(topImageView.snp.bottom)
        }
        
        tipsTextLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(tipsHoldView)
        }
    
       overdueBtn.snp.makeConstraints { (make) in
            make.size.equalTo(tipsHoldView)
            make.center.equalTo(tipsHoldView)
    }
    
        /*********/
        repayHoldView.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            self.repayHoldViewContraint = make.height.equalTo(70*UIRate).constraint
            make.centerX.equalTo(self)
            make.top.equalTo(tipsHoldView.snp.bottom)
        }
        
        repayDivideLine.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(repayHoldView)
            make.top.equalTo(60*UIRate)
        }
        
        repayDivideLine2.snp.makeConstraints { (make) in
        make.width.equalTo(self)
        make.height.equalTo(0.5*UIRate)
        make.centerX.equalTo(repayHoldView)
        make.bottom.equalTo(70*UIRate)
        }
        
        repayVerDivideLine.snp.makeConstraints { (make) in
        make.width.equalTo(0.5*UIRate)
        make.height.equalTo(60*UIRate)
        make.centerX.equalTo(repayHoldView)
        make.top.equalTo(repayHoldView)
        }
        
        moneyTextLabel.snp.makeConstraints { (make) in
        make.centerX.equalTo(-SCREEN_WIDTH/4)
        make.top.equalTo(33*UIRate)
        }
        
        moneyLabel.snp.makeConstraints { (make) in
        make.width.equalTo(SCREEN_WIDTH/2)
        make.centerX.equalTo(moneyTextLabel)
        make.bottom.equalTo(moneyTextLabel.snp.top)
        }
        
        dateTextLabel.snp.makeConstraints { (make) in
        make.centerX.equalTo(SCREEN_WIDTH/4)
        make.centerY.equalTo(moneyTextLabel)
        }
        
        dateLabel.snp.makeConstraints { (make) in
        make.width.equalTo(SCREEN_WIDTH/2)
        make.centerX.equalTo(dateTextLabel)
        make.centerY.equalTo(moneyLabel)
        }
        
        reBottomHoldView.snp.makeConstraints { (make) in
        make.width.equalTo(repayHoldView)
        make.height.equalTo(10*UIRate)
        make.centerX.equalTo(repayHoldView)
        make.top.equalTo(repayDivideLine.snp.bottom)
        }
    }
    
    private lazy var topImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "m_banner_image_375x220")
        return imageView
    }()
    
    //／消息按钮
    lazy var messageBtn: UIButton = {
        let button = UIButton()
        button.tag = 10000
        button.setBackgroundImage(UIImage(named: "m_message_25x25"), for: .normal)
        button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        return button
    }()
    
    //／消息小红点
    lazy var messageRedDot: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named:"m_red_point_6x6")
        imageView.isHidden = true
        return imageView
    }()
    
    //／设置按钮
    private lazy var settingBtn: UIButton = {
        let button = UIButton()
        button.tag = 20000
        button.setBackgroundImage(UIImage(named: "m_setting_25x25"), for: .normal)
        button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        return button
    }()
    
    //头像
    lazy var headerHolderView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 48*UIRate
        imageView.image = UIImage(named: "m_header_round_96x96")
        return imageView
    }()
    
    //头像
    lazy var headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 45*UIRate
        imageView.image = UIImage(named: "m_heder_icon_90x90")
        return imageView
    }()
    
    //／按钮
    private lazy var headerButton: UIButton = {
        let button = UIButton()
        button.tag = 30000
        button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var sayHelloTextLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.font = UIFontSize(size: 15*UIRate)
        textLabel.textAlignment = .center
        textLabel.textColor = UIColor.white
        return textLabel
    }()
    
    /*****************/
    lazy var tipsHoldView: UIView = {
        let holdView = UIView()
        holdView.backgroundColor = UIColorHex("ffe0df")
        return holdView
    }()
    
    lazy var tipsTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("e9342d")
        label.text = ""
        return label
    }()
    
    //／逾期
    lazy var overdueBtn: UIButton = {
        let button = UIButton()
        button.tag = 40000
        button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        return button
    }()
    
    /*************/
    lazy var repayHoldView: UIView = {
        let holdView = UIView()
        holdView.backgroundColor = UIColor.white
        return holdView
    }()
    
    //分割线
    private lazy var repayDivideLine: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()
    
    private lazy var repayDivideLine2: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()
    
    //分割线
    private lazy var repayVerDivideLine: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()
    
    private lazy var moneyTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("848484")
        label.text = "本月待还(元)"
        return label
    }()
    
    lazy var moneyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 20*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("f42e2f")
        label.text = "0.00"
        return label
    }()
    
    lazy var dateTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("848484")
        return label
    }()
    
   lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 20*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("f42e2f")
        label.text = ""
        return label
    }()
    
    private lazy var reBottomHoldView: UIView = {
        let holdView = UIView()
        holdView.backgroundColor = defaultBackgroundColor
        return holdView
    }()

    func buttonAction(_ button: UIButton){
        if self.delegate != nil {
            self.delegate?.mineTopViewOnClick(tag: button.tag)
        }
    }
}
