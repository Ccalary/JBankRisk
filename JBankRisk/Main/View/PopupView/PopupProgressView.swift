//
//  PopupProgressView.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/23.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit
import SnapKit

class PopupProgressView: UIView {

    var sureRightConstraint: Constraint!
    
    var statusType: OrderStausType = .defaultStatus
    
    override init(frame: CGRect ) {
        super.init(frame: frame)
    }
    
    ///初始化默认frame
    convenience init(status: String) {
        let frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH - 40*UIRate, height: 200*UIRate)
        self.init(frame: frame)
        setupUI()
        //进度通知
        switch status {
        case "0"://订单完结
            statusType = .finish
            noticeLabel.text = "恭喜您，借款已全部还款完成！"
        case "2": //审核中
            statusType = .examing
            noticeLabel.text = "您有一笔借款已进入\n审核状态了！"
           
        case "3"://满额通过
            statusType = .fullSuccess
            noticeLabel.text = "您的借款申请已审核通过\n请前去使用吧！"
            
        case "4"://校验中
            statusType = .checking
            noticeLabel.text = "您上传的服务单正在校验中！"
           
        case "5"://还款中
            statusType = .repaying
            noticeLabel.text = "恭喜您，借款已生效，赶紧\n让自己美起来吧！"
           
        case "7"://审核未通过
            statusType = .fail
            noticeLabel.text = "很遗憾，您的借款申请\n审核未通过！"
            
        case "8": //重新上传服务单
            statusType = .upLoadBill
            noticeLabel.text = "服务确认单校验不通过请上\n传正确的服务确认单！"
            
        case "9": //补交材料
            statusType = .reUploadData
            noticeLabel.text = "您的借款申请被驳回\n请补充更多材料！"
            
        default:
            statusType = .defaultStatus
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        
        self.backgroundColor = UIColor.white
        
        self.addSubview(titleLabel)
        self.addSubview(divideLine1)
        self.addSubview(noticeLabel)
        self.addSubview(sureBtn)
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.top).offset(25*UIRate)
            make.centerX.equalTo(self)
        }
        
        divideLine1.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(self)
            make.top.equalTo(50*UIRate)
        }
        
        noticeLabel.snp.makeConstraints { (make) in
            make.width.equalTo(200*UIRate)
            make.centerY.equalTo(self.snp.top).offset(85*UIRate)
            make.centerX.equalTo(self)
        }
        
        sureBtn.snp.makeConstraints { (make) in
            make.width.equalTo(100*UIRate)
            make.height.equalTo(40*UIRate)
            make.centerX.equalTo(self)
            make.bottom.equalTo(-20*UIRate)
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 18*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "进度通知"
        return label
    }()
    
    //分割线
    private lazy var divideLine1: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()
    
    private lazy var noticeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = UIColorHex("666666")
        return label
    }()
    
    ///按钮
    private lazy var sureBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "btn_red_100x40"), for: .normal)
        button.setTitle("知道了", for: UIControlState.normal)
        button.titleLabel?.font = UIFontBoldSize(size: 18*UIRate)
        button.addTarget(self, action: #selector(sureBtnAction), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Action
    
    var onClickSure: (()->())?
    
    //知道了
    func sureBtnAction(){
        if let onClickSure = onClickSure {
            onClickSure()
        }
    }

}
