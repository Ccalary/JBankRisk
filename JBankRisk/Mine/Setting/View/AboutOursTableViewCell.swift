//
//  AboutOursTableViewCell.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/4.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

class AboutOursTableViewCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        self.backgroundColor = UIColor.white
        self.addSubview(leftImageView)
        self.addSubview(leftTextLabel)
        self.addSubview(rightTextLabel)
        self.addSubview(arrowImageView)
        
        
        leftImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(20*UIRate)
            make.left.equalTo(15*UIRate)
            make.centerY.equalTo(self)
        }
        
        leftTextLabel.snp.makeConstraints { (make) in
            make.left.equalTo(leftImageView.snp.right).offset(6*UIRate)
            make.centerY.equalTo(self)
        }
        rightTextLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.right).offset(-40*UIRate)
            make.centerY.equalTo(self)
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
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = UIColorHex("666666")
        return label
    }()

    
    lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        imageView.image = UIImage(named: "home_right_arrow_7x12")
        return imageView
    }()
    
    //图片
    lazy var leftImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
}
