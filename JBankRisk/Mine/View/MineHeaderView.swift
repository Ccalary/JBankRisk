//
//  MineHeaderView.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/3.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

protocol StatusButtonClickDelegate {
    func clickStatusButtonAction(tag: Int)
}

class MineHeaderView: UICollectionReusableView {

    var delegate: StatusButtonClickDelegate?
    
    
    override init(frame: CGRect ) {
        super.init(frame: frame)
        setupUI()
    }
    
    ///初始化默认frame
    convenience init() {
        let frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 70*UIRate)
        self.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        self.backgroundColor = UIColor.white
        let viewWidth = SCREEN_WIDTH/9*2
        
        self.addSubview(holdView1)
        self.holdView1.addSubview(imageView1)
        self.imageView1.addSubview(tipImage1)
        self.tipImage1.addSubview(tipTextLabel1)
        self.holdView1.addSubview(textLabel1)
        self.holdView1.addSubview(button1)
        
        holdView1.snp.makeConstraints { (make) in
            make.width.equalTo(viewWidth)
            make.height.equalTo(60*UIRate)
            make.centerX.equalTo(self.snp.left).offset(SCREEN_WIDTH/6)
            make.top.equalTo(0)
        }
        imageView1.snp.makeConstraints { (make) in
            make.width.height.equalTo(25*UIRate)
            make.top.equalTo(7*UIRate)
            make.centerX.equalTo(holdView1)
        }

        tipImage1.snp.makeConstraints { (make) in
            make.width.height.equalTo(13*UIRate)
            make.centerX.equalTo(6*UIRate)
            make.centerY.equalTo(-6*UIRate)
        }
        
        tipTextLabel1.snp.makeConstraints { (make) in
            make.center.equalTo(tipImage1)
        }
        
        textLabel1.snp.makeConstraints { (make) in
            make.centerX.equalTo(holdView1)
            make.top.equalTo(imageView1.snp.bottom).offset(5*UIRate)
        }
        
        button1.snp.makeConstraints { (make) in
            make.size.equalTo(holdView1)
            make.center.equalTo(holdView1)
        }
        
        /******/
        self.addSubview(holdView2)
        self.holdView2.addSubview(imageView2)
        self.imageView2.addSubview(tipImage2)
        self.tipImage2.addSubview(tipTextLabel2)
        self.holdView2.addSubview(textLabel2)
        self.holdView2.addSubview(button2)
        
        holdView2.snp.makeConstraints { (make) in
            make.size.equalTo(holdView1)
            make.centerX.equalTo(holdView1).offset(viewWidth)
            make.top.equalTo(holdView1)
        }
        imageView2.snp.makeConstraints { (make) in
            make.width.height.equalTo(25*UIRate)
            make.top.equalTo(7*UIRate)
            make.centerX.equalTo(holdView2)
        }
        
        tipImage2.snp.makeConstraints { (make) in
            make.width.height.equalTo(13*UIRate)
            make.centerX.equalTo(6*UIRate)
            make.centerY.equalTo(-6*UIRate)
        }
        
        tipTextLabel2.snp.makeConstraints { (make) in
            make.center.equalTo(tipImage2)
        }
        
        
        textLabel2.snp.makeConstraints { (make) in
            make.centerX.equalTo(holdView2)
            make.top.equalTo(imageView2.snp.bottom).offset(5*UIRate)
        }
        
        button2.snp.makeConstraints { (make) in
            make.size.equalTo(holdView2)
            make.center.equalTo(holdView2)
        }
        
        /******/
        self.addSubview(holdView3)
        self.holdView3.addSubview(imageView3)
        self.imageView3.addSubview(tipImage3)
        self.tipImage3.addSubview(tipTextLabel3)
        self.holdView3.addSubview(textLabel3)
        self.holdView3.addSubview(button3)
        
        holdView3.snp.makeConstraints { (make) in
            make.size.equalTo(holdView1)
            make.centerX.equalTo(holdView2).offset(viewWidth)
            make.top.equalTo(holdView1)
        }
        
        imageView3.snp.makeConstraints { (make) in
            make.width.height.equalTo(25*UIRate)
            make.top.equalTo(7*UIRate)
            make.centerX.equalTo(holdView3)
        }
        
        tipImage3.snp.makeConstraints { (make) in
            make.width.height.equalTo(13*UIRate)
            make.centerX.equalTo(6*UIRate)
            make.centerY.equalTo(-6*UIRate)
        }
        
        tipTextLabel3.snp.makeConstraints { (make) in
            make.center.equalTo(tipImage3)
        }
        
        textLabel3.snp.makeConstraints { (make) in
            make.centerX.equalTo(holdView3)
            make.top.equalTo(imageView3.snp.bottom).offset(5*UIRate)
        }
        
        button3.snp.makeConstraints { (make) in
            make.size.equalTo(holdView3)
            make.center.equalTo(holdView3)
        }
        
        /******/
        self.addSubview(holdView4)
        self.holdView4.addSubview(imageView4)
        self.imageView4.addSubview(tipImage4)
        self.tipImage4.addSubview(tipTextLabel4)
        self.holdView4.addSubview(textLabel4)
        self.holdView4.addSubview(button4)
        
        holdView4.snp.makeConstraints { (make) in
            make.size.equalTo(holdView1)
            make.centerX.equalTo(holdView3).offset(viewWidth)
            make.top.equalTo(holdView1)
        }
        imageView4.snp.makeConstraints { (make) in
            make.width.height.equalTo(25*UIRate)
            make.top.equalTo(7*UIRate)
            make.centerX.equalTo(holdView4)
        }
        
        tipImage4.snp.makeConstraints { (make) in
            make.width.height.equalTo(13*UIRate)
            make.centerX.equalTo(6*UIRate)
            make.centerY.equalTo(-6*UIRate)
        }
        
        tipTextLabel4.snp.makeConstraints { (make) in
            make.center.equalTo(tipImage4)
        }
        
        textLabel4.snp.makeConstraints { (make) in
            make.centerX.equalTo(holdView4)
            make.top.equalTo(imageView4.snp.bottom).offset(5*UIRate)
        }
        
        button4.snp.makeConstraints { (make) in
            make.size.equalTo(holdView4)
            make.center.equalTo(holdView4)
        }
        
        /*********/
        self.addSubview(bottomHoldView)
        self.bottomHoldView.addSubview(divideLine1)
        self.bottomHoldView.addSubview(divideLine2)
        
        bottomHoldView.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.height.equalTo(10*UIRate)
            make.centerX.equalTo(self)
            make.bottom.equalTo(self)
        }
        
        divideLine1.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.height.equalTo(0.5*UIRate)
            make.top.equalTo(bottomHoldView.snp.top)
            make.centerX.equalTo(self)
        }
        divideLine2.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.height.equalTo(0.5*UIRate)
            make.bottom.equalTo(bottomHoldView.snp.bottom)
            make.centerX.equalTo(self)
            
        }
    }
    
    private lazy var holdView1: UIView = {
        let holdView = UIView()
        holdView.backgroundColor = UIColor.white
        return holdView
    }()
    
    //图片
    private lazy var imageView1: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "m_exam_25x25")
        return imageView
    }()
    
    //图片
    lazy var tipImage1: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        imageView.image = UIImage(named: "m_tips_13x13")
        return imageView
    }()
    
    private lazy var tipTextLabel1: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 12*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("f42e2f")
        label.text = "1"
        return label
    }()

    
    private lazy var textLabel1: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 12*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("848484")
        label.text = "审核中"
        return label
    }()

    //／按钮
    private lazy var button1: UIButton = {
        let button = UIButton()
        button.tag = 10000
        button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        return button
    }()
    
    /**********/
    private lazy var holdView2: UIView = {
        let holdView = UIView()
        holdView.backgroundColor = UIColor.white
        return holdView
    }()
    
    //图片
    private lazy var imageView2: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "m_forUse_25x25")
        return imageView
    }()
    
    //图片
    lazy var tipImage2: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        imageView.image = UIImage(named: "m_tips_13x13")
        return imageView
    }()
    
    private lazy var tipTextLabel2: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 12*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("f42e2f")
        label.text = "1"
        return label
    }()

    
    private lazy var textLabel2: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 12*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("848484")
        label.text = "待使用"
        return label
    }()
    
    //／按钮
    private lazy var button2: UIButton = {
        let button = UIButton()
        button.tag = 20000
        button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        return button
    }()
/********/
    private lazy var holdView3: UIView = {
        let holdView = UIView()
        holdView.backgroundColor = UIColor.white
        return holdView
    }()
    
    //图片
    private lazy var imageView3: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "m_repaying_25x25")
        return imageView
    }()
    
    //图片
    lazy var tipImage3: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        imageView.image = UIImage(named: "m_tips_13x13")
        return imageView
    }()
    
    private lazy var tipTextLabel3: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 12*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("f42e2f")
        label.text = "1"
        return label
    }()

    
    private lazy var textLabel3: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 12*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("848484")
        label.text = "还款中"
        return label
    }()
    
    //／按钮
    private lazy var button3: UIButton = {
        let button = UIButton()
        button.tag = 30000
        button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        return button
    }()
/********/
    private lazy var holdView4: UIView = {
        let holdView = UIView()
        holdView.backgroundColor = UIColor.white
        return holdView
    }()
    
    //图片
    private lazy var imageView4: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "m_submitted_25x25")
        return imageView
    }()
    
    //图片
    lazy var tipImage4: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        imageView.image = UIImage(named: "m_tips_13x13")
        return imageView
    }()
    
    private lazy var tipTextLabel4: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 12*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("f42e2f")
        label.text = "1"
        return label
    }()

    
    private lazy var textLabel4: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 12*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("848484")
        label.text = "驳回/拒绝"
        return label
    }()
    
    //／按钮
    private lazy var button4: UIButton = {
        let button = UIButton()
        button.tag = 40000
        button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        return button
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
    
    private lazy var bottomHoldView: UIView = {
        let holdView = UIView()
        holdView.backgroundColor = defaultBackgroundColor
        return holdView
    }()
    
    
    //实现代理
    func buttonAction(_ button:UIButton){
        
        if self.delegate != nil {
            self.delegate?.clickStatusButtonAction(tag: button.tag)
        }
    }
    

    
}
