//
//  HomeTableViewCell.swift
//  JBankRisk
//
//  Created by 曹后红 on 16/10/11.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 设置UI和布局
    func setupUI(){
        contentView.addSubview(leftImageView)
        contentView.addSubview(topTextLabel)
        contentView.addSubview(bottomTextLabel)
        contentView.addSubview(rightImageView)
        contentView.addSubview(rightTextLabel)
        
        leftImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(50*UIRate)
            make.left.equalTo(15*UIRate)
            make.centerY.equalTo(contentView.snp.centerY)
        }
        
        topTextLabel.snp.makeConstraints { (make) in
            make.left.equalTo(leftImageView.snp.right).offset(15*UIRate)
            make.top.equalTo(contentView).offset(20*UIRate)
        }
        
        bottomTextLabel.snp.makeConstraints { (make) in
            make.left.equalTo(topTextLabel)
            make.top.equalTo(topTextLabel.snp.bottom).offset(6*UIRate)
        }
        
        rightImageView.snp.makeConstraints { (make) in
            make.width.equalTo(7*UIRate)
            make.height.equalTo(12*UIRate)
            make.right.equalTo(-15*UIRate)
            make.centerY.equalTo(contentView.snp.centerY)
        }
        
        rightTextLabel.snp.makeConstraints { (make) in
            make.right.equalTo(rightImageView.snp.left).offset(-5*UIRate)
            make.centerY.equalTo(contentView)
        }
    }
    
   lazy var leftImageView: UIImageView = {
       let imageView = UIImageView()
       return imageView
    }()
    
   lazy var topTextLabel: UILabel = {
       let textLabel = UILabel()
           textLabel.font = UIFontBoldSize(size: 18*UIRate)
           textLabel.textColor = UIColorHex("666666")
       return textLabel
    }()
    
    lazy var bottomTextLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.font = UIFontSize(size: 15*UIRate)
        textLabel.textColor = UIColorHex("c5c5c5")
        return textLabel
    }()
    
    lazy var rightTextLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.font = UIFontSize(size: 15*UIRate)
        textLabel.textColor = UIColorHex("00b2ff")
        return textLabel

    }()
    
    lazy var rightImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
}
