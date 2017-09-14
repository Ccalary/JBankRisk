//
//  CancelOrderTableViewCell.swift
//  JBankRisk
//
//  Created by chh on 2017/9/14.
//  Copyright © 2017年 jingjinsuo. All rights reserved.
//

import UIKit

class CancelOrderTableViewCell: UITableViewCell {


    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        self.addSubview(leftLabel)
        self.addSubview(rightLabel)
        self.addSubview(leftDetailLabel)
        
        self.initFinishView()
        self.addSubview(clockImageView)
        self.addSubview(payBtn)
        
        self.addSubview(divideLine1)
        self.addSubview(divideLine2)
        self.addSubview(roundImageView)
        
        leftLabel.snp.makeConstraints { (make) in
            make.left.equalTo(60*UIRate)
            make.top.equalTo(20*UIRate)
        }

        rightLabel.snp.makeConstraints { (make) in
            make.right.equalTo(-35*UIRate)
            make.centerY.equalTo(leftLabel)
        }

        leftDetailLabel.snp.makeConstraints { (make) in
            make.left.equalTo(leftLabel)
            make.top.equalTo(leftLabel.snp.bottom).offset(6*UIRate)
        }
        
        clockImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(12*UIRate)
            make.right.equalTo(rightLabel)
            make.centerY.equalTo(finishView)
        }
        
        payBtn.snp.makeConstraints { (make) in
            make.width.equalTo(40*UIRate)
            make.height.equalTo(15*UIRate)
            make.right.equalTo(clockImageView)
            make.centerY.equalTo(clockImageView)
        }
        
        divideLine1.snp.makeConstraints { (make) in
            make.width.equalTo(2)
            make.top.equalTo(0)
            make.bottom.equalTo(leftLabel.snp.centerY)
            make.right.equalTo(leftLabel.snp.left).offset(-15*UIRate)
        }
        
        divideLine2.snp.makeConstraints { (make) in
            make.width.equalTo(divideLine1)
            make.top.equalTo(leftLabel.snp.centerY)
            make.bottom.equalTo(self)
            make.centerX.equalTo(divideLine1)
        }
        
        roundImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(7*UIRate)
            make.centerX.equalTo(divideLine1)
            make.centerY.equalTo(leftLabel)
        }
}
    
    //已完成View
    private func initFinishView(){
        self.addSubview(finishView)
        finishView.addSubview(finishImageView)
        finishView.addSubview(finishLabel)
        
        finishView.snp.makeConstraints { (make) in
            make.width.equalTo(60*UIRate)
            make.height.equalTo(30*UIRate)
            make.left.equalTo(leftLabel)
            make.centerY.equalTo(leftDetailLabel)
        }
        
        finishImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(12*UIRate)
            make.left.equalTo(finishView)
            make.centerY.equalTo(finishView)
        }
        
        finishLabel.snp.makeConstraints { (make) in
            make.left.equalTo(finishImageView.snp.right).offset(2)
            make.centerY.equalTo(finishImageView)
        }
    }
    
    private lazy var leftLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size:15*UIRate)
        label.textColor = UIColorHex("666666")
        label.text = "项目名称"
        return label
    }()
    
    private lazy var rightLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size:12*UIRate)
        label.textColor = UIColorHex("666666")
        label.text = "2017-10-10 12:00"
        return label
    }()
    
    /***✅已完成**/
    private lazy var finishView: UIView = {
        let holdView = UIView()
        holdView.backgroundColor = UIColor.clear
        return holdView
    }()
    
    //图片
    private lazy var finishImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "c_finish_12x12")
        return imageView
    }()
    private lazy var finishLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size:12*UIRate)
        label.textColor = UIColorHex("69D557")//绿色
        label.text = "已完成"
        return label
    }()
    /*********/
    private lazy var leftDetailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size:12*UIRate)
        label.textColor = UIColorHex("666666")
        label.text = "请于24小时内支付完成"
        return label
    }()
    
    //图片
    private lazy var clockImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "c_clock_12x12")
        return imageView
    }()
    
    //／按钮
    private lazy var payBtn: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColorHex("fc4146")
        button.setTitle("支付", for: UIControlState.normal)
        button.titleLabel?.font = UIFontSize(size: 12*UIRate)
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(payBtnAction), for: .touchUpInside)
        return button
    }()
    
    //分割线1
    private lazy var divideLine1: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()

    //分割线2
    private lazy var divideLine2: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()
    
    //图片
    private lazy var roundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "c_gray_7x7")
        return imageView
    }()
   
    //MARK: - Action
    func payBtnAction(){
        
    }

}
