//
//  RepayBillHeaderView.swift
//  JBankRisk
//
//  Created by caohouhong on 17/7/29.
//  Copyright © 2017年 jingjinsuo. All rights reserved.
//

import UIKit

protocol RepayBillHeaderViewDelegate:class{
    
    func clickHeaderBtnAction()
}

class RepayBillHeaderView: UIView {

    weak var delegate:RepayBillHeaderViewDelegate?
    
    override init(frame: CGRect ) {
        super.init(frame: frame)
        setupUI()
    }
    
    ///初始化默认frame
    convenience init() {
        let frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 156*UIRate)
        self.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI(){
        
        self.backgroundColor = UIColor.clear
        self.addSubview(topImageView)
        self.addSubview(totalBtn)
        self.addSubview(totalTextLabel)
        self.addSubview(totalMoneyLabel)
        self.addSubview(arrowImageView)
        
        
        topImageView.snp.makeConstraints { (make) in
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(156*UIRate)
            make.centerX.equalTo(self)
            make.top.equalTo(0)
        }
        
        totalTextLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(topImageView)
            make.top.equalTo(40*UIRate)
        }
        
        totalMoneyLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(80*UIRate)
        }
        
        arrowImageView.snp.makeConstraints { (make) in
            make.width.equalTo(7*UIRate)
            make.height.equalTo(12*UIRate)
            make.right.equalTo(-75*UIRate)
            make.centerY.equalTo(topImageView)
        }
        
        totalBtn.snp.makeConstraints { (make) in
            make.size.equalTo(topImageView)
            make.center.equalTo(topImageView)
        }

    }
    
    //图片
    private lazy var topImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "m_banner_image2_375x156")
        return imageView
    }()
    
    //／按钮
    private lazy var totalBtn: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(totalBtnAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var totalTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.text = "本月待还(元)"
        return label
    }()
    
    lazy var totalMoneyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 36*UIRate)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.text = "0.00"
        return label
    }()
    
    //箭头
    private lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "home_right_arrow_7x12")
        return imageView
    }()
    
    
    //MARK: - Action
    func totalBtnAction(){
        if let delegate = delegate{
            delegate.clickHeaderBtnAction()
        }
    }
}
