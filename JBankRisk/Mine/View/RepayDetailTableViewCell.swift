//
//  RepayDetailTableViewCell.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/5.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

class RepayDetailTableViewCell: UITableViewCell {

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
        self.addSubview(leftBottomTextLabel)
        self.addSubview(statusTextLabel)
        self.addSubview(noticeTextLabel)
        self.addSubview(moneyTextLabel)
        self.addSubview(arrowImageView)
        
        leftTopTextLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15*UIRate)
            make.top.equalTo(7*UIRate)
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
    }
    
    lazy var leftTopTextLabel: UILabel = {
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
    

}
