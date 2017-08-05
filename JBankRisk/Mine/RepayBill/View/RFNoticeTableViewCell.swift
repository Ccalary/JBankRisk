//
//  RFNoticeTableViewCell.swift
//  JBankRisk
//
//  Created by caohouhong on 17/7/30.
//  Copyright © 2017年 jingjinsuo. All rights reserved.
//

import UIKit

class RFNoticeTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI(){
        self.addSubview(leftLabel)
        
        leftLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15*UIRate)
            make.top.equalTo(10*UIRate)
            make.right.equalTo(-15*UIRate)
        }
    }
    
    lazy var leftLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size:15*UIRate)
        label.textColor = UIColorHex("666666")
        label.text = ""
        label.numberOfLines = 0
        return label
    }()


}
