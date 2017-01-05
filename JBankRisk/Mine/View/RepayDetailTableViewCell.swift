//
//  RepayDetailTableViewCell.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/5.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit
import SwiftyJSON

class RepayDetailTableViewCell: UITableViewCell {

    enum ColorTheme {
        case dark//深色
        case light//浅色
        case needReDark//应还颜色
    }
    
    //cell颜色的区分
    var textColorTheme: ColorTheme = .dark {
        didSet{
            switch textColorTheme {
            case .light:
                
                self.leftTopTextLabel.textColor = UIColorHex("c5c5c5")
                self.leftBottomTextLabel.textColor = UIColorHex("c5c5c5")
                self.statusTextLabel.textColor = UIColorHex("00b2ff")//蓝色
                self.noticeTextLabel.textColor = UIColorHex("e9342d")//红色
                self.moneyTextLabel.textColor = UIColorHex("c5c5c5")
            case .dark:
                self.leftTopTextLabel.textColor = UIColorHex("666666")
                self.leftBottomTextLabel.textColor = UIColorHex("666666")
                self.statusTextLabel.textColor = UIColorHex("fdb300")//黄色
                self.noticeTextLabel.textColor = UIColorHex("fdb300")
                self.moneyTextLabel.textColor = UIColorHex("666666")
                
            case .needReDark:
                self.leftTopTextLabel.textColor = UIColorHex("666666")
                self.leftBottomTextLabel.textColor = UIColorHex("666666")
                self.statusTextLabel.textColor = UIColorHex("00b2ff")//蓝色
                self.noticeTextLabel.textColor = UIColorHex("e9342d")//红色
                self.moneyTextLabel.textColor = UIColorHex("666666")
            }
           
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        self.backgroundColor = UIColor.white
        
        self.addSubview(leftTopTextLabel)
        self.addSubview(leftTopTextLabel2)
        self.addSubview(leftBottomTextLabel)
        self.addSubview(statusTextLabel)
        self.addSubview(noticeTextLabel)
        self.addSubview(moneyTextLabel)
        self.addSubview(arrowImageView)
        
        self.addSubview(checkImage)
        
        self.addSubview(centerLabel)
        
        leftTopTextLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15*UIRate)
            make.top.equalTo(7*UIRate)
        }
        
        leftTopTextLabel2.snp.makeConstraints { (make) in
            make.left.equalTo(leftTopTextLabel.snp.right).offset(10*UIRate)
            make.centerY.equalTo(leftTopTextLabel)
        }
        
        leftBottomTextLabel.snp.makeConstraints { (make) in
            make.left.equalTo(leftTopTextLabel)
            make.top.equalTo(leftTopTextLabel.snp.bottom).offset(6*UIRate)
        }
        
        statusTextLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(leftBottomTextLabel)
            make.left.equalTo(leftBottomTextLabel.snp.right).offset(20*UIRate)
        }
        
        noticeTextLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(leftBottomTextLabel)
            make.left.equalTo(statusTextLabel.snp.right).offset(15*UIRate)
        }
        
        moneyTextLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(self.snp.right).offset(-33*UIRate)
        }
        
        arrowImageView.snp.makeConstraints { (make) in
            make.width.equalTo(7*UIRate)
            make.height.equalTo(12*UIRate)
            make.right.equalTo(self.snp.right).offset(-15*UIRate)
            make.centerY.equalTo(self)
        }
        
        checkImage.snp.makeConstraints { (make) in
            make.width.equalTo(24*UIRate)
            make.height.equalTo(14*UIRate)
            make.right.equalTo(-15*UIRate)
            make.centerY.equalTo(self)
        }
        
        centerLabel.snp.makeConstraints { (make) in
            make.width.equalTo(250*UIRate)
            make.height.equalTo(self)
            make.left.equalTo(100*UIRate)
            make.center.equalTo(self)
        }
    }
    
    lazy var leftTopTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 12*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        return label
    }()
    
    lazy var leftTopTextLabel2: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 12*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        return label
    }()
    
    lazy var leftBottomTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        return label
    }()
    
    lazy var statusTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .right
        label.textColor = UIColorHex("00b2ff")
        return label
    }()
    
    lazy var noticeTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        return label
    }()
    
    lazy var moneyTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        return label
    }()
    
    lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "home_right_arrow_7x12")
        return imageView
    }()
    
    
    ///还款时间中用
    lazy var checkImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "right_check_24x14")
        imageView.isHidden = true
        return imageView
    }()
    
    //还款明细中用
    lazy var centerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textColor = UIColorHex("666666")
        return label
    }()
    
    
    //还款详情待还
    func waitCellWithData(dic: JSON){
        leftTopTextLabel.text = "第\(dic["term"].stringValue)期"
        leftBottomTextLabel.text = toolsChangeDateStyle(toYYYYMMDD: dic["realpay_date"].stringValue)
        statusTextLabel.text = "待还"
        let penaltyDay = dic["penalty_day"].intValue //逾期
        
        if penaltyDay > 0 {//有逾期
            noticeTextLabel.text = "逾期\(penaltyDay)天"
        }else {
            noticeTextLabel.text = ""
        }
        moneyTextLabel.text = toolsChangeMoneyStyle(amount: dic["showMoney"].doubleValue) + "元"
    }
    
    //还款详情已还
    func alreadyCellWithData(dic: JSON){
        
        leftTopTextLabel.text = "第\(dic["term"].stringValue)期"
        leftBottomTextLabel.text = toolsChangeDateStyle(toYYYYMMDD: dic["realpay_date"].stringValue)
        statusTextLabel.text = "完成"
        let penaltyDay = dic["penalty_day"].intValue //逾期
            
        if penaltyDay > 0 {//有逾期
            noticeTextLabel.text = "逾期\(penaltyDay)天"
        }else {
            noticeTextLabel.text = ""
        }
        
        moneyTextLabel.text = toolsChangeMoneyStyle(amount: dic["pay_amt_total"].doubleValue) + "元"
    }
    
    //应还
    func needRepayCellWithData(dic: JSON){
        
        leftTopTextLabel.text = dic["orderName"].stringValue
        leftTopTextLabel2.text = "第" + dic["term"].stringValue + "期"
        leftBottomTextLabel.text = toolsChangeDateStyle(toYYYYMMDD: dic["realpay_date"].stringValue)
        statusTextLabel.text = "待还"
        let penaltyDay = dic["penalty_day"].intValue //逾期
        
        if penaltyDay > 0 {//有逾期
            noticeTextLabel.text = "逾期\(penaltyDay)天"
        }else {
            noticeTextLabel.text = ""
        }
        
        moneyTextLabel.text = toolsChangeMoneyStyle(amount: dic["showMoney"].doubleValue) + "元"
    }
}
