//
//  RepayDetailHeaderView.swift
//  JBankRisk
//
//  Created by caohouhong on 17/7/27.
//  Copyright © 2017年 jingjinsuo. All rights reserved.
//

import UIKit

class RepayDetailHeaderView: UIView {

    var onClickNextStepBtn:(()->())?
    
    override init(frame: CGRect ) {
        super.init(frame: frame)
        setupUI()
    }
    
    ///初始化默认frame
    convenience init() {
        let frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 40*UIRate)
        self.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI(){
        self.backgroundColor = UIColorHex("fd6b6d")
        
        self.addSubview(nameTextLabel)
        self.addSubview(stateLabel)
        self.addSubview(imageView)
        self.addSubview(nextStepBtn)
        
        nameTextLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15*UIRate)
            make.width.equalTo(100*UIRate)
            make.centerY.equalTo(self)
            make.height.equalTo(self)
        }
        
        stateLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(-33*UIRate)
        }
        
        imageView.snp.makeConstraints { (make) in
            make.width.equalTo(7*UIRate)
            make.height.equalTo(12*UIRate)
            make.right.equalTo(-15*UIRate)
            make.centerY.equalTo(self)
        }
        
        nextStepBtn.snp.makeConstraints { (make) in
            make.size.equalTo(self)
            make.center.equalTo(self)
        }
    }
    
    private lazy var nameTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textColor = UIColor.white
        label.text = "借款账单清算"
        return label
    }()
    
    lazy var stateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textColor = UIColor.white
        label.text = "可申请"
        return label
    }()
    
    //图片
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "home_right_arrow_7x12")
        return imageView
    }()
    
    //／按钮
    private lazy var nextStepBtn: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(nextStepBtnAction), for: .touchUpInside)
        return button
    }()
    
    
    func nextStepBtnAction(){
        if let onClickNextStepBtn = onClickNextStepBtn{
            onClickNextStepBtn()
        }
    }
}
