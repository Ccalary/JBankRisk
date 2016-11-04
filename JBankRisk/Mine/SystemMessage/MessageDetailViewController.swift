//
//  MessageDetailViewController.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/4.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

class MessageDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       self.setupUI()
        
        
        let contentText = "就是对雷锋精神动力大幅降低肌肤啦圣诞节放大老师家看电视了附近的伤口附近丢失哦双节快乐对方角度来说 家里的沙发经历多少附近丢失了附近丢失了几行法师看对方发 三闾大夫就是大了发动机拉萨的激发了三十分 的士力架飞机似的 附近的伤口分 风急浪大开始见风使舵两附近分 时间的浪费教室里的风景"
        
        let attibute = [NSFontAttributeName:self.contentTextLabel.font]
        let height = autoLabelHeight(with: contentText, labelWidth: SCREEN_WIDTH - 50*UIRate, attributes: attibute)
        //重新对label布局
        self.contentTextLabel.text = contentText
        self.contentTextLabel.snp.remakeConstraints({ (make) in
            make.width.equalTo(SCREEN_WIDTH - 50*UIRate)
            make.height.equalTo(height)
            make.centerX.equalTo(self.view)
            make.top.equalTo(divideLine1).offset(11*UIRate)
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupUI(){
        self.navigationController!.navigationBar.isTranslucent = true;
        self.automaticallyAdjustsScrollViewInsets = false;
        self.view.backgroundColor = defaultBackgroundColor
        self.title = "消息"
        
        self.view.addSubview(titleTextLabel)
        self.view.addSubview(timeTextLabel)
        self.view.addSubview(divideLine1)
        self.view.addSubview(contentTextLabel)
        self.view.addSubview(divideLine2)
        self.view.addSubview(bottomTextLabel)
        
        titleTextLabel.snp.makeConstraints { (make) in
            make.left.equalTo(20*UIRate)
            make.top.equalTo(20*UIRate + 64)
        }
        
        timeTextLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleTextLabel)
            make.top.equalTo(titleTextLabel.snp.bottom).offset(5*UIRate)
        }

        divideLine1.snp.makeConstraints { (make) in
            make.width.equalTo(SCREEN_WIDTH - 40*UIRate)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(64 + 70*UIRate)
        }

        contentTextLabel.snp.makeConstraints { (make) in
            make.width.equalTo(SCREEN_WIDTH - 50*UIRate)
            make.height.equalTo(SCREEN_HEIGHT - 200*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(divideLine1).offset(11*UIRate)
        }

        divideLine2.snp.makeConstraints { (make) in
            make.width.equalTo(SCREEN_WIDTH - 150*UIRate)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(-35*UIRate)
        }
        
        bottomTextLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(divideLine2)
        }
    }

    private lazy var titleTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontBoldSize(size: 20*UIRate)
        label.textColor = UIColorHex("666666")
        label.text = "借款进度提醒"
        return label
    }()
    
    private lazy var timeTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("d4d4d4")
        label.text = "2016-11-01 18:43:00"
        return label
    }()
    
    //分割线
    private lazy var divideLine1: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()

    private lazy var contentTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textColor = UIColorHex("666666")
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = ""
        return label
    }()

    //分割线
    private lazy var divideLine2: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()
    
    private lazy var bottomTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 18*UIRate)
        label.textAlignment = .center
        label.backgroundColor = defaultBackgroundColor
        label.textColor = UIColorHex("d4d4d4")
        label.text = "中诚消费团队"
        return label
    }()
}
