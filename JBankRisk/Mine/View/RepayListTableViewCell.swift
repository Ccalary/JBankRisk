//
//  RepayListTableViewCell.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/18.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

class RepayListTableViewCell: UITableViewCell {

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
        self.addSubview(centerTextLabel)
        self.addSubview(rightTextLabel)
        
        let width = (SCREEN_WIDTH - 30*UIRate)/3
        
        leftTextLabel.snp.makeConstraints { (make) in
            make.width.equalTo(width)
            make.left.equalTo(15*UIRate)
            make.centerY.equalTo(self)
        }
        
        centerTextLabel.snp.makeConstraints { (make) in
            make.width.equalTo(width)
            make.left.equalTo(leftTextLabel.snp.right)
            make.centerY.equalTo(self)
        }
        
        rightTextLabel.snp.makeConstraints { (make) in
            make.width.equalTo(width)
            make.centerY.equalTo(self)
            make.right.equalTo(-15*UIRate)
        }
   }
    
    lazy var leftTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        return label
    }()
    
    lazy var centerTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .right
        label.textColor = UIColorHex("666666")
        return label
    }()
    
    lazy var rightTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        return label
    }()
}
