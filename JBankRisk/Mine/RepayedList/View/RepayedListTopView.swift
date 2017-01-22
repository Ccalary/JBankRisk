//
//  RepayedListTopView.swift
//  JBankRisk
//
//  Created by caohouhong on 17/1/17.
//  Copyright © 2017年 jingjinsuo. All rights reserved.
//

import UIKit

class RepayedListTopView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        self.backgroundColor = UIColor.white
        
        self.addSubview(timeTextLabel)
        self.addSubview(naemTextLabel)
        self.addSubview(moneyTextLabel)
        self.addSubview(divideLine1)
    
        timeTextLabel.snp.makeConstraints { (make) in
            make.width.equalTo(SCREEN_WIDTH/3.0)
            make.height.equalTo(45*UIRate)
            make.left.equalTo(0)
            make.centerY.equalTo(self)
        }
        
        naemTextLabel.snp.makeConstraints { (make) in
            make.size.equalTo(timeTextLabel)
            make.left.equalTo(timeTextLabel.snp.right)
            make.centerY.equalTo(self)
        }
        
        moneyTextLabel.snp.makeConstraints { (make) in
            make.size.equalTo(timeTextLabel)
            make.right.equalTo(0)
            make.centerY.equalTo(self)
        }
        
        divideLine1.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(self)
            make.bottom.equalTo(self)
        }
        
    }
    
    private lazy var timeTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "时间"
        return label
    }()
    
    private lazy var naemTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "产品名称"
        return label
    }()
    
    private lazy var moneyTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "金额(元)"
        return label
    }()
    
    //分割线
    private lazy var divideLine1: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()
}
