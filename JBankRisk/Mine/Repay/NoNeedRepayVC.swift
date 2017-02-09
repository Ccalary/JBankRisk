//
//  NoNeedRepayVC.swift
//  JBankRisk
//
//  Created by caohouhong on 16/12/28.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

class NoNeedRepayVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //nav
    func setNavUI(){
        self.view.addSubview(navHoldView)
        navHoldView.navTextLabel.text = self.title
        
        navHoldView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(64)
            make.centerX.equalTo(self.view)
            make.top.equalTo(0)
        }
    }

    func setupUI(){
        self.title = "还款"
        self.setNavUI()
        
        self.view.backgroundColor = defaultBackgroundColor

        self.view.addSubview(topHoldView)
        self.topHoldView.addSubview(topImageView)
        self.topHoldView.addSubview(topTextLabel)
        
        self.view.addSubview(centerHoldView)
        self.centerHoldView.addSubview(divideLine1)
        self.centerHoldView.addSubview(divideLine2)
        
        self.view.addSubview(bottomHoldView)
        self.bottomHoldView.addSubview(titleTextLabel)
        self.bottomHoldView.addSubview(divideLine3)
        self.bottomHoldView.addSubview(divideLine4)
        self.bottomHoldView.addSubview(imageView1)
        self.bottomHoldView.addSubview(imageView2)
        self.bottomHoldView.addSubview(imageView3)
        self.bottomHoldView.addSubview(textLabel1)
        self.bottomHoldView.addSubview(textLabel2)
        self.bottomHoldView.addSubview(textLabel3)
        
        topHoldView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(200*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(64)
        }
        
        topImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(132*UIRate)
            make.centerX.equalTo(topHoldView)
            make.top.equalTo(22*UIRate)
        }

        topTextLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(topHoldView)
            make.top.equalTo(topImageView.snp.bottom).offset(10*UIRate)
        }

        centerHoldView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(10*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.topHoldView.snp.bottom)
        }

        divideLine1.snp.makeConstraints { (make) in
            make.width.equalTo(centerHoldView)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(centerHoldView)
            make.top.equalTo(centerHoldView)
        }
        
        divideLine2.snp.makeConstraints { (make) in
            make.size.equalTo(divideLine1)
            make.centerX.equalTo(centerHoldView)
            make.bottom.equalTo(centerHoldView)
        }

        bottomHoldView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(135*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(centerHoldView.snp.bottom)
        }
        
        titleTextLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(bottomHoldView)
            make.centerY.equalTo(bottomHoldView.snp.top).offset(25*UIRate)
        }
        
        divideLine3.snp.makeConstraints { (make) in
            make.size.equalTo(divideLine1)
            make.centerX.equalTo(bottomHoldView)
            make.top.equalTo(50*UIRate)
        }

        divideLine4.snp.makeConstraints { (make) in
            make.size.equalTo(divideLine1)
            make.centerX.equalTo(bottomHoldView)
            make.bottom.equalTo(bottomHoldView)
        }
        
        imageView2.snp.makeConstraints { (make) in
            make.width.height.equalTo(44*UIRate)
            make.centerX.equalTo(bottomHoldView)
            make.top.equalTo(divideLine3).offset(10*UIRate)
        }
        
        imageView1.snp.makeConstraints { (make) in
            make.size.equalTo(imageView2)
            make.centerX.equalTo(imageView2).offset(-120*UIRate)
            make.top.equalTo(imageView2)
        }
        
        imageView3.snp.makeConstraints { (make) in
            make.size.equalTo(imageView2)
            make.centerX.equalTo(imageView2).offset(120*UIRate)
            make.top.equalTo(imageView2)
        }

        textLabel2.snp.makeConstraints { (make) in
            make.centerX.equalTo(imageView2)
            make.top.equalTo(imageView2.snp.bottom).offset(5*UIRate)
        }
        
        textLabel1.snp.makeConstraints { (make) in
            make.centerX.equalTo(imageView1)
            make.top.equalTo(imageView1.snp.bottom).offset(5*UIRate)
        }
        
        textLabel3.snp.makeConstraints { (make) in
            make.centerX.equalTo(imageView3)
            make.top.equalTo(imageView3.snp.bottom).offset(5*UIRate)
        }
    }
    
    /***Nav隐藏时使用***/
    private lazy var navHoldView: NavigationView = {
        let holdView = NavigationView()
        return holdView
    }()
    
    private lazy var topHoldView: UIView = {
        let holdView = UIView()
        holdView.backgroundColor = UIColor.white
        return holdView
    }()
    
    //图片
    private lazy var topImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "m_status_bg_132x132")
        return imageView
    }()
    
    private lazy var topTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "您暂时无需还款！"
        return label
    }()

    private lazy var centerHoldView: UIView = {
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

    private lazy var bottomHoldView: UIView = {
        let holdView = UIView()
        holdView.backgroundColor = UIColor.white
        return holdView
    }()
    
    private lazy var titleTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 18*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "支持还款渠道"
        return label
    }()
    
    //分割线
    private lazy var divideLine3: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()

    //图片
    private lazy var imageView1: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "r_wechat_44x44")
        return imageView
    }()
    
    //图片
    private lazy var imageView2: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "r_alipay_44x44")
        return imageView
    }()
    
    //图片
    private lazy var imageView3: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "r_ebank_44x44")
        return imageView
    }()
    
    private lazy var textLabel1: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "微信"
        return label
    }()
    
    private lazy var textLabel2: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "支付宝"
        return label
    }()
    
    private lazy var textLabel3: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "网银"
        return label
    }()

    //分割线
    private lazy var divideLine4: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()
    
}
