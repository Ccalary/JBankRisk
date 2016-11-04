//
//  SysMessageTableViewCell.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/4.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

class SysMessageTableViewCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        self.backgroundColor = UIColor.white
        
        self.addSubview(dividerView)
        self.addSubview(divideLine1)
         self.addSubview(divideLine2)
        self.addSubview(leftImageView)
        
        self.addSubview(topTextLabel)
        self.addSubview(bottomTextLabel)
        self.addSubview(timeTextLabel)
        self.leftImageView.addSubview(redImageView)
        
        
        dividerView.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.height.equalTo(6*UIRate)
            make.centerX.equalTo(self)
            make.top.equalTo(self)
        }

        divideLine1.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(self)
            make.top.equalTo(6*UIRate)
        }
        
        divideLine2.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(self)
            make.bottom.equalTo(self.snp.bottom)
        }
        
        leftImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(25*UIRate)
            make.left.equalTo(10*UIRate)
            make.centerY.equalTo(self).offset(3*UIRate)
        }
        
        topTextLabel.snp.makeConstraints { (make) in
            make.left.equalTo(53*UIRate)
            make.top.equalTo(20*UIRate)
        }
        bottomTextLabel.snp.makeConstraints { (make) in
            make.width.equalTo(240*UIRate)
            make.left.equalTo(topTextLabel)
            make.top.equalTo(topTextLabel.snp.bottom).offset(2*UIRate)
        }
        
        timeTextLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.right).offset(-15*UIRate)
            make.centerY.equalTo(topTextLabel)
        }

        redImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(4*UIRate)
            make.top.equalTo(leftImageView).offset(2*UIRate)
            make.right.equalTo(leftImageView.snp.right).offset(-2)
        }
        
    }
    
    private lazy var dividerView: UIView = {
        let holdView = UIView()
        holdView.backgroundColor = defaultBackgroundColor
        return holdView
    }()
    
    //分割线
    private lazy var divideLine1: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()
    
    //分割线
    private lazy var divideLine2: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()

    
    lazy var topTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 13*UIRate)
        label.textColor = UIColorHex("666666")
        label.text = "标题"
        return label
    }()
    
    lazy var bottomTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 13*UIRate)
        label.textColor = UIColorHex("d4d4d4")
        label.text = "消息内容"
        return label
    }()
    
    lazy var timeTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 13*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "2016/11/11"
        return label
    }()
    
    //图片
    lazy var leftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "s_message_25x25")
        return imageView
    }()
    
    //红点
    lazy var redImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "s_red_dot_4x4")
        return imageView
    }()

    
    
    

}
