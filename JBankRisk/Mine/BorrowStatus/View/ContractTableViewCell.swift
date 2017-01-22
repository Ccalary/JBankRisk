//
//  ContractTableViewCell.swift
//  JBankRisk
//
//  Created by caohouhong on 17/1/7.
//  Copyright © 2017年 jingjinsuo. All rights reserved.
//

import UIKit
import SwiftyJSON

class ContractTableViewCell: UITableViewCell {
    
    var status = "" {
        didSet {
            if status == "1" {
                rightTextLabel.text = "已签署"
                rightTextLabel.backgroundColor = UIColorHex("aaaaaa")
            }else {
                rightTextLabel.text = "未签署"
                rightTextLabel.backgroundColor = UIColorHex("e9342d")
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
        self.addSubview(leftTextLabel)
        self.addSubview(rightTextLabel)
        self.addSubview(arrowImageView)
        
        leftTextLabel.snp.makeConstraints { (make) in
            make.width.equalTo(SCREEN_WIDTH - 100*UIRate)
            make.height.equalTo(self)
            make.left.equalTo(15*UIRate)
            make.centerY.equalTo(self)
        }
        
        rightTextLabel.snp.makeConstraints { (make) in
            make.width.equalTo(60*UIRate)
            make.height.equalTo(30*UIRate)
            make.right.equalTo(-15*UIRate)
            make.centerY.equalTo(self)
        }
        
        arrowImageView.snp.makeConstraints { (make) in
            make.width.equalTo(7*UIRate)
            make.height.equalTo(12*UIRate)
            make.right.equalTo(-15*UIRate)
            make.centerY.equalTo(self)
        }
    }

    lazy var leftTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.text = "合同名称"
        label.textColor = UIColorHex("666666")
        return label
    }()
    
    lazy var rightTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.layer.cornerRadius = 4.0
        label.layer.masksToBounds = true
        label.textColor = UIColor.white
        return label
    }()

    
    lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        imageView.image = UIImage(named: "home_right_arrow_7x12")
        return imageView
    }()

}
