//
//  BorrowProgressView.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/22.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

class BorrowProgressView: UIView {

    override init(frame: CGRect ) {
        super.init(frame: frame)
        
    }
    
    ///初始化默认frame
    convenience init() {
        let frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 75*UIRate)
        self.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        self.backgroundColor = UIColor.white
        
        self.addSubview(rectImageView1)
        self.addSubview(rectImageView2)
        self.addSubview(rectImageView3)
        
        self.addSubview(circleImageView1)
        self.addSubview(circleImageView2)
        self.addSubview(circleImageView3)
        self.addSubview(circleImageView4)
        
        self.addSubview(textLabel1)
        self.addSubview(textLabel2)
        self.addSubview(textLabel3)
        self.addSubview(textLabel4)
        
        circleImageView1.snp.makeConstraints { (make) in
            make.width.height.equalTo(20*UIRate)
            make.left.equalTo(30*UIRate)
            make.top.equalTo(17*UIRate)
        }
        
        circleImageView2.snp.makeConstraints { (make) in
            make.size.equalTo(circleImageView1)
            make.centerX.equalTo(circleImageView1.snp.centerX).offset(95*UIRate)
            make.top.equalTo(circleImageView1)
        }
        
        circleImageView3.snp.makeConstraints { (make) in
            make.size.equalTo(circleImageView1)
            make.centerX.equalTo(circleImageView2.snp.centerX).offset(95*UIRate)
            make.top.equalTo(circleImageView1)

        }
        
        circleImageView4.snp.makeConstraints { (make) in
            make.size.equalTo(circleImageView1)
            make.centerX.equalTo(circleImageView3.snp.centerX).offset(95*UIRate)
            make.top.equalTo(circleImageView1)
        }
        
        rectImageView1.snp.makeConstraints { (make) in
            make.width.equalTo(95*UIRate)
            make.height.equalTo(2*UIRate)
            make.left.equalTo(circleImageView1.snp.centerX)
            make.centerY.equalTo(circleImageView1)
        }
        
        rectImageView2.snp.makeConstraints { (make) in
            make.width.equalTo(95*UIRate)
            make.height.equalTo(2*UIRate)
            make.left.equalTo(circleImageView2.snp.centerX)
            make.centerY.equalTo(circleImageView1)
        }

        
        rectImageView3.snp.makeConstraints { (make) in
            make.width.equalTo(95*UIRate)
            make.height.equalTo(2*UIRate)
            make.left.equalTo(circleImageView3.snp.centerX)
            make.centerY.equalTo(circleImageView1)
        }


        textLabel1.snp.makeConstraints { (make) in
            make.centerX.equalTo(circleImageView1)
            make.top.equalTo(circleImageView1.snp.bottom).offset(5*UIRate)
        }
        
        textLabel2.snp.makeConstraints { (make) in
            make.centerX.equalTo(circleImageView2)
            make.top.equalTo(circleImageView2.snp.bottom).offset(5*UIRate)
        }
        textLabel3.snp.makeConstraints { (make) in
            make.centerX.equalTo(circleImageView3)
            make.top.equalTo(circleImageView3.snp.bottom).offset(5*UIRate)
        }
        
        textLabel4.snp.makeConstraints { (make) in
            make.centerX.equalTo(circleImageView4)
            make.top.equalTo(circleImageView4.snp.bottom).offset(5*UIRate)
        }

        
    }
    
    //图片
    private lazy var circleImageView1: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "m_red_circle_20x20")
        return imageView
    }()
    
    //图片
    private lazy var rectImageView1: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "m_gray_rect_95x2")
        return imageView
    }()

    
    private lazy var textLabel1: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "申请"
        return label
    }()
    
    //图片
    private lazy var circleImageView2: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "m_gray_circle_20x20")
        return imageView
    }()
    
    //图片
    private lazy var rectImageView2: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "m_gray_rect_95x2")
        return imageView
    }()

    private lazy var textLabel2: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "审核"
        return label
    }()

    
    //图片
    private lazy var circleImageView3: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "m_gray_circle_20x20")
        return imageView
    }()
    //图片
    private lazy var rectImageView3: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "m_gray_rect_95x2")
        return imageView
    }()
    
    private lazy var textLabel3: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "服务确认"
        return label
    }()
    
    //图片
    private lazy var circleImageView4: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "m_gray_circle_20x20")
        return imageView
    }()
    
    private lazy var textLabel4: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "还款"
        return label
    }()
    
    }
