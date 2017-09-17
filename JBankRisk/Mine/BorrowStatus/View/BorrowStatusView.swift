//
//  BorrowStatusView.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/18.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

class BorrowStatusView: UIView {
    
    //状态为9审核未通过时的描述
    var failDis = ""
    
    //审核反馈文字高度
    private var textHeight:CGFloat = 0.0
    
    override init(frame: CGRect ) {
        super.init(frame: frame)
    }
    
    //账单清算状态
    var repayFinalType: RepayFinalType = .cannotApply
    
    //撤销订单
    var revokeState: RevokeStatusType = .cannot
    
    var statusType: OrderStausType = .defaultStatus {
        didSet{
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
            tipsBtn.isHidden = true
            divideLine1.isHidden = false
            repayDetailBtn.isHidden = true
            moreBtn.isHidden = true
            switch statusType {
            case .finish://订单完结
                self.bgImageView.isHidden = false
                self.statusImageView.image = UIImage(named:"bs_finish_110x90")
                repayDetailBtn.isHidden = false
                nextStepBtn.isHidden = false
                switch repayFinalType {
                case .sucRepayed:
                    disTextLabel.text = "         "//改变还款详情布局
                    repayDetailBtn.isHidden = false
                    nextStepBtn.setTitle("账单结算已完成", for: UIControlState.normal)
                default:
                    nextStepBtn.setTitle("还款详情", for: UIControlState.normal)
                    repayDetailBtn.isHidden = true
                }
            case .examing: //审核中
                self.bgImageView.isHidden = false
                self.statusImageView.image = UIImage(named:"bs_examing_110x90")
                disTextLabel.text = "正在飞速的审核，稍等下下就好了哦！"
                nextStepBtn.isHidden = true
            case .fullSuccess://满额通过
                self.bgImageView.isHidden = false
                self.statusImageView.image = UIImage(named:"bs_fullSuccess_110x90")
                disTextLabel.text = "恭喜您借款成功"
                nextStepBtn.isHidden = false
                nextStepBtn.setTitle("立即使用", for: UIControlState.normal)
                tipsTextLabel.text = "借款有效期30天，请及时使用"
            case .checking://校验中
                self.bgImageView.isHidden = false
                self.statusImageView.image = UIImage(named:"bs_checking_110x90")
                disTextLabel.text = "正在校验，请稍后"
                nextStepBtn.isHidden = true
            case .repaying://还款中
                self.bgImageView.isHidden = false
                self.statusImageView.image = UIImage(named:"bs_repaying_110x90")
                nextStepBtn.isHidden = false
                repayDetailBtn.isHidden = false
                disTextLabel.text = "         "//改变还款详情布局
                
                switch revokeState {
                case .cannot:
                    nextStepBtn.setTitle("还款详情", for: UIControlState.normal)
                    repayDetailBtn.isHidden = true
                case .can:
                    nextStepBtn.setTitle("撤销借款", for: UIControlState.normal)
                case .pay:
                    nextStepBtn.setTitle("支付违约金", for: UIControlState.normal)
                case .upload:
                    nextStepBtn.setTitle("上传退款凭证", for: UIControlState.normal)
                case .success:
                    nextStepBtn.setTitle("撤销成功", for: UIControlState.normal)
                }
                
                switch repayFinalType {
                case .cannotApply:
                    nextStepBtn.setTitle("还款详情", for: UIControlState.normal)
                    repayDetailBtn.isHidden = true
                case .canApply:
                    nextStepBtn.setTitle("申请结算账单", for: UIControlState.normal)
                case .applying:
                    nextStepBtn.setTitle("结算账单申请中", for: UIControlState.normal)
                case .success:
                    nextStepBtn.setTitle("支付结算金额", for: UIControlState.normal)
                default:
                    break
                }
                
            case .fail://审核未通过
                self.bgImageView.isHidden = false
                self.statusImageView.image = UIImage(named:"bs_fail_110x90")
                disTextLabel.text = "如若再次申请，请联系客服人员"
                nextStepBtn.isHidden = true
                /*
                nextStepBtn.isHidden = true
                nextStepBtn.setTitle("重新申请", for: UIControlState.normal)
                */
            case .upLoadBill: //上传服务单
                self.bgImageView.isHidden = false
                self.statusImageView.image = UIImage(named:"bs_upload_bill_110x90")
                disTextLabel.text = "请上传正确的服务确认单"
                nextStepBtn.isHidden = false
                nextStepBtn.setTitle("去修改", for: UIControlState.normal)
                tipsTextLabel.text = "借款有效期30天，请及时使用"
                break
            case .reUploadData: //补交材料(申请被驳回)
                self.bgImageView.isHidden = false
                self.statusImageView.image = UIImage(named:"bs_reupload_110x90")
                if failDis == "" {
                     disTextLabel.text = "请补充材料，可帮助提\n高借款成功率哦"
                }else {
                    let attibute = [NSFontAttributeName:UIFontSize(size: 15*UIRate)]
                    textHeight = autoLabelHeight(with: failDis, labelWidth: disTextLabel.frame.size.width , attributes: attibute)
                    if (textHeight > disTextLabel.frame.size.height) {
                        moreBtn.isHidden = false
                    }
                    disTextLabel.text = failDis
                }
                nextStepBtn.isHidden = false
                nextStepBtn.setTitle("补交材料", for: UIControlState.normal)
                tipsBtn.isHidden = false
                break
            case .defaultStatus:
                self.bgImageView.isHidden = true
                break
            }
        }
    }
    
    ///初始化默认frame
    convenience init() {
        let frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 250*UIRate)
        self.init(frame: frame)
        
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
        self.addSubview(moreBtn)
        self.addSubview(nextStepBtn)
        self.addSubview(tipsTextLabel)
        self.addSubview(tipsBtn)
        self.addSubview(divideLine1)
        self.addSubview(repayDetailBtn)
        
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
            make.width.equalTo(SCREEN_WIDTH - 100*UIRate)
            make.centerX.equalTo(self)
            make.top.equalTo(bgImageView.snp.bottom).offset(10*UIRate)
            make.height.equalTo(40*UIRate)
        }
        
        moreBtn.snp.makeConstraints { (make) in
            make.width.equalTo(45*UIRate)
            make.height.equalTo(20*UIRate)
            make.bottom.equalTo(disTextLabel)
            make.right.equalTo(self).offset(-5*UIRate)
        }
        
        nextStepBtn.snp.makeConstraints { (make) in
            make.width.equalTo(254*UIRate)
            make.height.equalTo(44*UIRate)
            make.centerX.equalTo(self)
            make.top.equalTo(disTextLabel.snp.bottom).offset(13*UIRate)
        }

        tipsTextLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(nextStepBtn.snp.bottom).offset(10*UIRate)
        }
        
        tipsBtn.snp.makeConstraints { (make) in
            make.width.equalTo(150*UIRate)
            make.height.equalTo(20*UIRate)
            make.centerX.equalTo(self)
            make.top.equalTo(nextStepBtn.snp.bottom).offset(10*UIRate)
        }
        
        repayDetailBtn.snp.makeConstraints { (make) in
            make.width.equalTo(150*UIRate)
            make.height.equalTo(20*UIRate)
            make.centerX.equalTo(self)
            make.top.equalTo(nextStepBtn.snp.top).offset(-30*UIRate)
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
        imageView.isHidden = true
        imageView.image = UIImage(named: "m_status_bg_132x132")
        return imageView
    }()
    
    //状态图片
    private lazy var statusImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var disTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = UIColorHex("666666")
        return label
    }()
    
    //／按钮
    lazy var moreBtn: UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.backgroundColor = UIColor.white
        button.setTitleColor(UIColorHex("00b2ff"), for: .normal)
        button.setTitle(">全部", for: UIControlState.normal)
        button.titleLabel?.font = UIFontSize(size: 15*UIRate)
        button.addTarget(self, action: #selector(moreBtnAction), for: .touchUpInside)
        return button
    }()
    
    //／按钮
    private lazy var nextStepBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "btn_red_254x44"), for: .normal)
        button.isHidden = true
        button.setTitle("", for: UIControlState.normal)
        button.titleLabel?.font = UIFontSize(size: 18*UIRate)
        button.addTarget(self, action: #selector(nextStepBtnAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var tipsTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("e9342d")
        return label
    }()
    
    //／按钮
    private lazy var tipsBtn: UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.titleLabel?.font = UIFontSize(size: 15*UIRate)
        button.setTitle("非图片资料修改>", for: .normal)
        button.setTitleColor(UIColorHex("3caafa"), for: .normal)
        button.addTarget(self, action: #selector(tipsBtnAction), for: .touchUpInside)
        return button
    }()
    
    //／按钮
    private lazy var repayDetailBtn: UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.titleLabel?.font = UIFontSize(size: 15*UIRate)
        button.setTitle("还款详情>", for: .normal)
        button.setTitleColor(UIColorHex("3caafa"), for: .normal)
        button.addTarget(self, action: #selector(repayDetailBtnAction), for: .touchUpInside)
        return button
    }()

    //分割线
    private lazy var divideLine1: UIView = {
        let lineView = UIView()
        lineView.isHidden = true
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()

    var onClickButton:(()->())?
    var onClickTipsButton:(()->())?
    var onClickRepayDetailBtn:(()->())?
    
    func nextStepBtnAction(){
        if let onClickButton = onClickButton {
            onClickButton()
        }
    }
    
    //点击修改
    func tipsBtnAction(){
        if let onClickTipsButton = onClickTipsButton {
            onClickTipsButton()
        }
    }
    
    //还款详情
    func repayDetailBtnAction(){
        if let onClickRepayDetailBtn = onClickRepayDetailBtn{
            onClickRepayDetailBtn()
        }
    }
    
    //展示全部
    func moreBtnAction(){
        let popupView =  PopupRejectReasonView(frame: CGRect(x:0,y:0,width:SCREEN_WIDTH - 40*UIRate,height:160*UIRate + textHeight), string: failDis)
        let popupController = CNPPopupController(contents: [popupView])!
        popupController.present(animated: true)
        popupView.onClickSure = { _ in
            popupController.dismiss(animated: true)
        }
    }
}
