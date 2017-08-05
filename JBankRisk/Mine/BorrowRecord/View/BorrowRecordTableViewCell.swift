//
//  BorrowRecordTableViewCell.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/3.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit
import SwiftyJSON

class BorrowRecordTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        self.backgroundColor = UIColor.white
        self.addSubview(leftTextLabel)
        self.addSubview(rightTextLabel)
        self.addSubview(rightSecondTextLabel)
        self.addSubview(arrowImageView)
        
        leftTextLabel.snp.makeConstraints { (make) in
            make.left.equalTo(30*UIRate)
            make.centerY.equalTo(self)
        }
        
        rightTextLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.right).offset(-30*UIRate)
            make.centerY.equalTo(self)
        }
        
        rightSecondTextLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(-100*UIRate)
        }
        
        arrowImageView.snp.makeConstraints { (make) in
            make.width.equalTo(7*UIRate)
            make.height.equalTo(12*UIRate)
            make.right.equalTo(self.snp.right).offset(-15*UIRate)
            make.centerY.equalTo(self)
        }

    }
    
    lazy var leftTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        return label
    }()
    
    lazy var rightTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .right
        label.textColor = UIColorHex("00b2ff")
        return label
    }()

    lazy var rightSecondTextLabel: UILabel = {
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
    
    ///还款账单月数据
    func cellWithMonthData(dic: JSON){
        leftTextLabel.text = dic["orderName"].stringValue
        rightSecondTextLabel.text = "第\(dic["term"].stringValue)期"
    
        //0-已支付 1-未支付 2-提前支付 3-逾期未支付 4-逾期已支付
        let repayStatus = dic["is_pay"].stringValue
        var status = ""
        if repayStatus == "0" ||  repayStatus == "2" || repayStatus == "4"{
            status = "完成"
        }else {
            //有逾期
            if dic["penalty_day"].intValue > 0 {
                status = "逾期\(dic["penalty_day"].stringValue)天"
            }else {
                status = "未还清"
            }
        }
        rightTextLabel.text = status
        
        //如果有逾期，改变右边label字体颜色
        if status.contains("逾期"){
            rightTextLabel.textColor = UIColorHex("f42e2f")
        }else {
            rightTextLabel.textColor = UIColorHex("00b2ff")
        }

    }
}
