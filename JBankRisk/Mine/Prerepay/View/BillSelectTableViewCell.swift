//
//  BillSelectTableViewCell.swift
//  JBankRisk
//
//  Created by caohouhong on 16/12/23.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

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
        label.text = "隆鼻 第四期"
        label.textColor = UIColorHex("666666")
        return label
    }()
    
    lazy var leftBottomTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 12*UIRate)
        label.textAlignment = .center
        label.text = "2016/04/05"
        label.textColor = UIColorHex("c5c5c5")
        return label
    }()
    
    lazy var centerTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 12*UIRate)
        label.textAlignment = .center
        label.text = "逾期10天"
        label.textColor = UIColorHex("fb5c57")
        return label
    }()
    
    lazy var rightTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .right
        label.text = "600.00元"
        label.textColor = UIColorHex("fb5c57")
        return label
    }()
}
