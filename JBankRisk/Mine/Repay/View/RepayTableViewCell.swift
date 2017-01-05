//
//  RepayTableViewCell.swift
//  JBankRisk
//
//  Created by caohouhong on 16/12/23.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

class RepayTableViewCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        self.backgroundColor = UIColor.white
        self.addSubview(topImageView)
        self.addSubview(leftTextLabel)
        self.addSubview(rightArrowImageView)
        self.addSubview(selectImageView)
        
        topImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(25*UIRate)
            make.left.equalTo(15*UIRate)
            make.centerY.equalTo(self)
        }
        
        leftTextLabel.snp.makeConstraints { (make) in
            make.left.equalTo(55*UIRate)
            make.centerY.equalTo(self)
        }
        
        rightArrowImageView.snp.makeConstraints { (make) in
            make.width.equalTo(7*UIRate)
            make.height.equalTo(12*UIRate)
            make.right.equalTo(-15*UIRate)
            make.centerY.equalTo(self)
        }
        
        selectImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(20*UIRate)
            make.right.equalTo(-15*UIRate)
            make.centerY.equalTo(self)
        }
    }
    
    //选择图片
    lazy var topImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    lazy var leftTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.text = "微信支付"
        label.textColor = UIColorHex("666666")
        return label
    }()
    
    //图片
   lazy var rightArrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "home_right_arrow_7x12")
        return imageView
    }()
    
    lazy var selectImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        imageView.image = UIImage(named: "repay_unselect_circle_20x20")
        return imageView
    }()
}
