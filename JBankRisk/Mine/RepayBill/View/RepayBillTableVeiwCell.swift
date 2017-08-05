//
//  RepayBillTableVeiwCell.swift
//  JBankRisk
//
//  Created by caohouhong on 17/7/29.
//  Copyright © 2017年 jingjinsuo. All rights reserved.
//

import UIKit

class RepayBillTableVeiwCell: UITableViewCell {

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
        self.addSubview(blLabel)
        self.addSubview(brLabel)
        
        leftTextLabel.snp.makeConstraints { (make) in
            make.left.equalTo(30*UIRate)
            make.top.equalTo(10*UIRate)
        }
        
        rightTextLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.right).offset(-30*UIRate)
            make.centerY.equalTo(leftTextLabel)
        }
        
        rightSecondTextLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(leftTextLabel)
            make.right.equalTo(-100*UIRate)
        }
        
        arrowImageView.snp.makeConstraints { (make) in
            make.width.equalTo(7*UIRate)
            make.height.equalTo(12*UIRate)
            make.right.equalTo(self.snp.right).offset(-15*UIRate)
            make.centerY.equalTo(leftTextLabel)
        }
        
        blLabel.snp.makeConstraints { (make) in
            make.left.equalTo(leftTextLabel)
            make.bottom.equalTo(-10*UIRate)
        }
        
        brLabel.snp.makeConstraints { (make) in
            make.right.equalTo(rightTextLabel)
            make.centerY.equalTo(blLabel)
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
    
    private lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "home_right_arrow_7x12")
        return imageView
    }()

    lazy var blLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size:15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("999999")
        label.text = "账单清算"
        label.isHidden = true
        return label
    }()

    lazy var brLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size:15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("999999")
        label.text = "申请中"
        label.isHidden = true
        return label
    }()
    


}
