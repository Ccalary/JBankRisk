//
//  BorrowStatusView.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/18.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

class BorrowStatusView: UIView {
    
    override init(frame: CGRect ) {
        super.init(frame: frame)
    }
    
    ///初始化默认frame
    convenience init(statusType: OrderStausType) {
        let frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 250*UIRate)
        self.init(frame: frame)
        /*
        case finish      //订单完结
        case examing     //审核中
        case fullSuccess //满额通过
        case checking    //校验中
        case repaying    //还款中
        case fail        //审核未通过
        case upLoadBill  //上传服务单
        case reUploadData//补交材料
        case defaultStatus //缺省
       */
        switch statusType {
            case .finish://订单完结
                self.statusImageView.image = UIImage(named:"bs_finish_110x90")
            case .examing: //审核中
                self.statusImageView.image = UIImage(named:"bs_examing_110x90")
            case .fullSuccess://满额通过
                self.statusImageView.image = UIImage(named:"bs_fullSuccess_110x90")
            case .checking://校验中
                self.statusImageView.image = UIImage(named:"bs_checking_110x90")
            case .repaying://还款中
                self.statusImageView.image = UIImage(named:"bs_repaying_110x90")
            case .fail://审核未通过
                self.statusImageView.image = UIImage(named:"bs_fail_110x90")
            case .upLoadBill: //上传服务单
                break
            case .reUploadData: //补交材料
                break
            case .defaultStatus:
                break
        }
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        self.backgroundColor = UIColor.white
        
        self.addSubview(bgImageView)
        self.bgImageView.addSubview(statusImageView)
        self.addSubview(disTextLabel)
        self.addSubview(nextStepBtn)
        self.addSubview(tipsTextLabel)
        self.addSubview(divideLine1)
        
        bgImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(132*UIRate)
            make.centerX.equalTo(self)
            make.top.equalTo(22*UIRate)
        }
        
        statusImageView.snp.makeConstraints { (make) in
            make.width.equalTo(110*UIRate)
            make.height.equalTo(90*UIRate)
            make.centerX.equalTo(bgImageView)
            make.centerY.equalTo(-5*UIRate)
        }
        
        disTextLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(bgImageView.snp.bottom).offset(10*UIRate)
        }
        
        nextStepBtn.snp.makeConstraints { (make) in
            make.width.equalTo(254*UIRate)
            make.height.equalTo(44*UIRate)
            make.centerX.equalTo(self)
            make.top.equalTo(disTextLabel.snp.bottom).offset(15*UIRate)
        }

        tipsTextLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(nextStepBtn.snp.bottom).offset(10*UIRate)
        }
        
        divideLine1.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(self)
            make.bottom.equalTo(self)
        }
    }

    //图片
    private lazy var bgImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "m_status_bg_132x132")
        return imageView
    }()
    
    //状态图片
    private lazy var statusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bs_examing_110x90")
        return imageView
    }()
    
    private lazy var disTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "部分资料不合格，请上传真实正确的资料"
        return label
    }()
    
    //／按钮
    private lazy var nextStepBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "btn_red_254x44"), for: .normal)
        
        button.setTitle("下一步", for: UIControlState.normal)
        button.titleLabel?.font = UIFontSize(size: 18*UIRate)
        button.addTarget(self, action: #selector(nextStepBtnAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var tipsTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("e9342d")
        label.text = "借款有效期30天"
        return label
    }()

    //分割线
    private lazy var divideLine1: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()

    func nextStepBtnAction(){
        
    }
    
}
