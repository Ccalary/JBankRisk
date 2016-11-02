//
//  PopupStaticTableViewCell.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/2.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

class PopupStaticTableViewCell: UITableViewCell {

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
        self.addSubview(checkImageView)
        
        leftTextLabel.snp.makeConstraints { (make) in
            make.left.equalTo(35*UIRate)
            make.centerY.equalTo(self)
        }
        
        checkImageView.snp.makeConstraints { (make) in
            make.width.equalTo(15*UIRate)
            make.height.equalTo(15*UIRate)
            make.left.equalTo(leftTextLabel.snp.right).offset(6*UIRate)
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
    
    lazy var checkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bm_check_15x15")
        imageView.isHidden = true
        return imageView
    }()
}
