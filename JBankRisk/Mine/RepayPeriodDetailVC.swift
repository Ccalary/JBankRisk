//
//  RepayPeriodDetailVC.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/13.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

class RepayPeriodDetailVC: UIViewController {

    var repayStatusType: RepayStatusType = .advance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func setupUI(){
        self.title = "还款明细"
        self.view.backgroundColor = defaultBackgroundColor
        self.navigationController!.navigationBar.isTranslucent = true
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.view.addSubview(topImageView)
        self.topImageView.addSubview(titleTextLabel)
        self.topImageView.addSubview(divideLine1)
        self.topImageView.addSubview(moneyTextLabel)
        self.topImageView.addSubview(moneyLabel)
        
        self.view.addSubview(detailView)
        
        topImageView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(156*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(64)
        }
        
        titleTextLabel.snp.makeConstraints { (make) in
            make.height.equalTo(35*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(0)
        }
        
        divideLine1.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(35*UIRate)
        }

        moneyTextLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(topImageView.snp.top).offset(70*UIRate)
        }
        
        moneyLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(topImageView.snp.top).offset(110*UIRate)
        }
        
        detailView.snp.makeConstraints { (make) in
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(300)
            make.left.equalTo(0)
            make.top.equalTo(topImageView.snp.bottom)
        }
    }
    
    //图片
    private lazy var topImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "m_banner_image3_375x156")
        return imageView
    }()
    
    private lazy var titleTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.text = "隆鼻第三期"
        return label
    }()
    
    //分割线
    private lazy var divideLine1: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.white
        return lineView
    }()
    
    private lazy var moneyTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.text = "已还款(元)"
        return label
    }()

    private lazy var moneyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 36*UIRate)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.text = "0.00"
        return label
    }()

    private lazy var detailView: RepayPeriodDetailView = {
        let holdView = RepayPeriodDetailView(viewType: RepayStatusType.finish)
        return holdView
    }()
    

}
