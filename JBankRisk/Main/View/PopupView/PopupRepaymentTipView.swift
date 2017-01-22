//
//  PopupRepaymentTipView.swift
//  JBankRisk
//
//  Created by 曹后红 on 16/10/13.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit
import SwiftyJSON

class PopupRepaymentTipView: UIView {

    
    var dicInfo: JSON! {
        didSet{
            textLabel.text = dicInfo["title"].stringValue
            moneyLabel.text = "需还金额：\(toolsChangeMoneyStyle(amount: dicInfo["payMoney"].doubleValue))元"
            deadlineLabel.text = "截止日期：\(toolsChangeDateStyle(toYYYYMMDD: dicInfo["RecentPayDate"].stringValue))"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    /// 便利构造 默认frame
    convenience init(){
        let frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH - 40*UIRate, height: 200*UIRate)
        self.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        
        self.backgroundColor = UIColor.white
        
        self.addSubview(textLabel)
        self.addSubview(moneyLabel)
        self.addSubview(deadlineLabel)
        self.addSubview(sureBtn)
        self.addSubview(tipsLabel)
        
        textLabel.snp.makeConstraints { (make) in
            make.top.equalTo(17*UIRate)
            make.centerX.equalTo(self)
        }
        
        moneyLabel.snp.makeConstraints { (make) in
            make.top.equalTo(textLabel.snp.bottom).offset(15*UIRate)
            make.centerX.equalTo(self)
        }
        
        deadlineLabel.snp.makeConstraints { (make) in
            make.top.equalTo(moneyLabel.snp.bottom).offset(5*UIRate)
            make.left.equalTo(moneyLabel)
            
        }
        
        sureBtn.snp.makeConstraints { (make) in
            make.width.equalTo(150*UIRate)
            make.height.equalTo(40*UIRate)
            make.centerX.equalTo(self)
            make.top.equalTo(deadlineLabel.snp.bottom).offset(30*UIRate)
        }
        
        tipsLabel.snp.makeConstraints { (make) in
            make.top.equalTo(sureBtn.snp.bottom).offset(10*UIRate)
            make.centerX.equalTo(self)
        }
    }
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 18*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "您七日内有一期还款"
        return label
    }()
    
    private lazy var moneyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "需还金额：500.00元"
        return label
    }()
    
    private lazy var deadlineLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "截止日期：2016.12.12"
        return label
    }()

    
    ///知道了按钮
    private lazy var sureBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "btn_red_150x40"), for: .normal)
        button.setTitle("知道了", for: UIControlState.normal)
        button.titleLabel?.font = UIFontBoldSize(size: 18*UIRate)
        button.addTarget(self, action: #selector(sureBtnAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var tipsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 12*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("c5c5c5")
        label.text = "温馨提示：若到期未还款将收取逾期费哦！"
        return label
    }()
    
    //MARK: - Action

    var onClickSure: (()->())?
    
    //知道了
    func sureBtnAction(){
        if let onClickSure = onClickSure {
            onClickSure()
        }
        
    }
}
