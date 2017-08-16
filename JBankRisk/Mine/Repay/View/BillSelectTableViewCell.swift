//
//  BillSelectTableViewCell.swift
//  JBankRisk
//
//  Created by caohouhong on 16/12/23.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit
import SwiftyJSON

class BillSelectTableViewCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        self.backgroundColor = UIColor.white
        self.addSubview(selectImageView)
        self.addSubview(leftTopTextLabel)
        self.addSubview(leftBottomTextLabel)
        self.addSubview(centerTextLabel)
        self.addSubview(rightTextLabel)
        
        selectImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(20*UIRate)
            make.left.equalTo(15*UIRate)
            make.centerY.equalTo(self)
        }
        
        leftTopTextLabel.snp.makeConstraints { (make) in
            make.left.equalTo(50*UIRate)
            make.top.equalTo(15*UIRate)
        }
        
        leftBottomTextLabel.snp.makeConstraints { (make) in
            make.left.equalTo(leftTopTextLabel)
            make.top.equalTo(leftTopTextLabel.snp.bottom).offset(7*UIRate)
        }
        
        centerTextLabel.snp.makeConstraints { (make) in
            make.left.equalTo(leftBottomTextLabel.snp.right).offset(15*UIRate)
            make.centerY.equalTo(leftBottomTextLabel)
        }
        
        rightTextLabel.snp.makeConstraints { (make) in
            make.width.equalTo(150*UIRate)
            make.height.equalTo(self)
            make.centerY.equalTo(self)
            make.right.equalTo(-15*UIRate)
        }
    }
    
    //选择图片
    lazy var selectImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "repay_unselect_circle_20x20")
        return imageView
    }()
    
    lazy var leftTopTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        return label
    }()
    
    lazy var leftBottomTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 12*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("c5c5c5")
        return label
    }()
    
    lazy var centerTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 12*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("fb5c57")
        return label
    }()
    
    lazy var rightTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .right
        label.text = "0.00元"
        label.textColor = UIColorHex("fb5c57")
        return label
    }()
    
    func cellWithDate(dic: JSON){
        //100为清算的
        if dic["term"].intValue == 100 {
            leftTopTextLabel.text = dic["orderName"].stringValue + " 结算金额"
        }else {
           leftTopTextLabel.text = dic["orderName"].stringValue + " 第\(dic["term"].stringValue)期"
        }
        
        leftBottomTextLabel.text = toolsChangeDateStyle(toYYYYMMDD: dic["realpay_date"].stringValue)
        let penaltyDay = dic["penalty_day"].intValue
        if penaltyDay > 0 { //有逾期
            centerTextLabel.text = "逾期\(penaltyDay)天"
        }else {
            centerTextLabel.text = ""
        }
        rightTextLabel.text = "\(toolsChangeMoneyStyle(amount: dic["showMoney"].doubleValue))元"
    }
}
