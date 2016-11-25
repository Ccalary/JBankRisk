//
//  PopupNewVersionView.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/22.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

class PopupNewVersionView: UIView {

    //更新描述
    var disText = ""
    
    override init(frame: CGRect ) {
        super.init(frame: frame)
       
    }
    
    ///初始化默认frame
    convenience init(disText: String) {
        let frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH - 80*UIRate, height: 360*UIRate)
        self.init(frame: frame)
        self.setupUI()
        
        let contentText = disText
        let attibute = [NSFontAttributeName:self.noticeLabel.font]
        let height = autoLabelHeight(with: contentText, labelWidth: SCREEN_WIDTH - 140*UIRate, attributes: attibute)
        
        //重新对label布局
        self.noticeLabel.text = contentText
        self.noticeLabel.snp.remakeConstraints({ (make) in
            make.width.equalTo(self.frame.size.width - 60*UIRate)
            make.height.equalTo(height)
            make.centerX.equalTo(self)
            make.top.equalTo(titleLabel.snp.bottom).offset(15*UIRate)
        })
        
        var viewHeight = 150*UIRate + 105*UIRate + height
        //如果大于360 则按大的尺寸来，若小于则为360
        viewHeight = viewHeight > 360*UIRate ? viewHeight : 360*UIRate
        
        self.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH - 80*UIRate, height: viewHeight)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        
        self.backgroundColor = UIColor.white
        
        self.addSubview(topImageView)
        self.addSubview(titleLabel)
        self.addSubview(noticeLabel)
        self.addSubview(closeBtn)
        self.addSubview(sureBtn)
        
        topImageView.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.height.equalTo(115*UIRate)
            make.centerX.equalTo(self)
            make.top.equalTo(0)
        }

        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(topImageView.snp.bottom).offset(10*UIRate)
            make.centerX.equalTo(self)
        }
        
        noticeLabel.snp.makeConstraints { (make) in
            make.width.equalTo(self.frame.size.width - 60*UIRate)
            make.top.equalTo(titleLabel.snp.bottom).offset(15*UIRate)
            make.centerX.equalTo(self)
        }
        
        closeBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(15*UIRate)
            make.right.equalTo(-5*UIRate)
            make.top.equalTo(5*UIRate)
        }
        
        sureBtn.snp.makeConstraints { (make) in
            make.width.equalTo(118*UIRate)
            make.height.equalTo(40*UIRate)
            make.centerX.equalTo(self)
            make.bottom.equalTo(-30*UIRate)
        }
    }
    
    //图片
    private lazy var topImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "nv_top_image_300x115")
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 24*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("3681da")
        label.text = "检测到新版本"
        return label
    }()
    
    private lazy var noticeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textColor = UIColorHex("7e84a3")
        label.numberOfLines = 0
        return label
    }()
    
    //／按钮
    private lazy var closeBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "nv_close_15x15"), for: .normal)
        button.addTarget(self, action: #selector(closeBtnAction), for: .touchUpInside)
        return button
    }()
    
    ///升级按钮
    private lazy var sureBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "nv_circle_btn_118x40"), for: .normal)
        button.setTitle("立即升级", for: UIControlState.normal)
        button.titleLabel?.font = UIFontBoldSize(size: 15*UIRate)
        button.addTarget(self, action: #selector(sureBtnAction), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Action
    
    var onClickCancle : (()->())?
    var onClickSure: (()->())?
    
    //取消
    func closeBtnAction(){
        if let onClickCancle = onClickCancle {
            onClickCancle()
        }
    }
    //升级
    func sureBtnAction(){
        if let onClickSure = onClickSure {
            onClickSure()
        }
    }
}
