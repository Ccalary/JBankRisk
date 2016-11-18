//
//  SettingTableViewCell.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/4.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell {

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
        self.addSubview(arrowImageView)
        self.addSubview(headerImageView)
        
        leftTextLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15*UIRate)
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
        
        headerImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(45*UIRate)
            make.right.equalTo(self.snp.right).offset(-40*UIRate)
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
        label.isHidden = true
        label.textColor = UIColorHex("666666")
        return label
    }()

    
    lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "home_right_arrow_7x12")
        return imageView
    }()
    
    //图片
    lazy var headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 45*UIRate/2
        imageView.image = UIImage(named: "s_header_icon_45x45")
        return imageView
    }()
    

}
