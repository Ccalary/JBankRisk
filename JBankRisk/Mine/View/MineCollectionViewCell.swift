//
//  MineCollectionViewCell.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/3.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

class MineCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        self.addSubview(imageView)
        self.addSubview(textLabel)
        
        imageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(28*UIRate)
            make.centerX.equalTo(self)
            make.top.equalTo(10*UIRate)
        }

        textLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(imageView.snp.bottom).offset(4*UIRate)
        }
    }
    
    //图片
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()

        return imageView
    }()
    
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        return label
    }()
    

}
