//
//  BorrowDefaultView.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/18.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//  缺省界面

import UIKit

class BorrowDefaultView: UIView {

    enum BorrowDefaultViewType {
        case borrowRecord  //借款纪录
        case repayBill     //还款账单
        case applyStatus1   //审核中，待使用，驳回
        case applyStatus2   //还款中
    }
    
    var viewType: BorrowDefaultViewType!
    var disText = ""
    
    var onClickApplyAction:(()->())?
    
    override init(frame: CGRect ) {
        super.init(frame: frame)
        
    }
    
    ///初始化默认frame
    convenience init(viewType: BorrowDefaultViewType) {
        let frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 100*UIRate)
        self.init(frame: frame)
        
        self.viewType = viewType
        switch self.viewType! {
        case .borrowRecord:
            disText = "您还未提交任何借款申请哦～"
        case .repayBill:
            disText = "当前暂无欠款～\n据说会借钱的人更能赚钱哦！"
        case .applyStatus1:
            disText = "当前暂无借款信息～"
            self.nextStepBtn.isHidden = true
        case .applyStatus2:
            disText = "当前暂无还款信息～"
            self.nextStepBtn.isHidden = true
        }
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        self.backgroundColor = defaultBackgroundColor
        
        self.addSubview(statusImageView)
        self.addSubview(textLabel)
        self.addSubview(nextStepBtn)
        
        statusImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(132*UIRate)
            make.centerX.equalTo(self)
            make.top.equalTo(26*UIRate)
        }
  
        textLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(statusImageView.snp.bottom).offset(20*UIRate)
        }

        nextStepBtn.snp.makeConstraints { (make) in
            make.width.equalTo(254*UIRate)
            make.height.equalTo(44*UIRate)
            make.centerX.equalTo(self)
            make.top.equalTo(textLabel.snp.bottom).offset(20*UIRate)
        }
        
    }
    
    //图片
    private lazy var statusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "m_status_bg_132x132")
        return imageView
    }()

    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = UIColorHex("666666")
        label.text = self.disText
        return label
    }()
    
    //／按钮
    private lazy var nextStepBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "btn_red_254x44"), for: .normal)
        
        button.setTitle("去申请", for: UIControlState.normal)
        button.titleLabel?.font = UIFontSize(size: 18*UIRate)
        button.addTarget(self, action: #selector(nextStepBtnAction), for: .touchUpInside)
        return button
    }()

    func nextStepBtnAction(){
        if let onClickApplyAction = onClickApplyAction {
            onClickApplyAction()
        }
    }
    
}
