//
//  PopupPhotoSelectView.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/2.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

class PopupPhotoSelectView: UIView {

    override init(frame: CGRect ) {
        super.init(frame: frame)
        setupUI()
    }
    
    ///初始化默认frame
    convenience init() {
        let frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH - 40*UIRate, height: 150*UIRate)
        self.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        
        self.backgroundColor = UIColor.white
        
        self.addSubview(textLabel1)
        self.addSubview(textLabel2)
        self.addSubview(textLabel3)
        self.addSubview(divideLine1)
        self.addSubview(divideLine2)
        self.addSubview(closeBtn)
        self.addSubview(cameraBtn)
        self.addSubview(photoBtn)
        
        textLabel1.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.top).offset(25*UIRate)
            make.left.equalTo(20*UIRate)
        }
        
        textLabel2.snp.makeConstraints { (make) in
            make.centerY.equalTo(textLabel1.snp.centerY).offset(50*UIRate)
            make.left.equalTo(textLabel1)
        }
        
        textLabel3.snp.makeConstraints { (make) in
            make.centerY.equalTo(textLabel2.snp.centerY).offset(50*UIRate)
            make.left.equalTo(textLabel1)
        }
        
        divideLine1.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.height.equalTo(0.5*UIRate)
            make.left.equalTo(self)
            make.top.equalTo(50*UIRate)
        }
        
        divideLine2.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.height.equalTo(0.5*UIRate)
            make.top.equalTo(100*UIRate)
            make.left.equalTo(self)
        }
        
        closeBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(17*UIRate)
            make.right.equalTo(self).offset(-20*UIRate)
            make.centerY.equalTo(self.snp.top).offset(25*UIRate)
        }
        
        cameraBtn.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.height.equalTo(50*UIRate)
            make.centerX.equalTo(self)
            make.centerY.equalTo(textLabel2)
        }
        
        photoBtn.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.height.equalTo(50*UIRate)
            make.centerX.equalTo(self)
            make.centerY.equalTo(textLabel3)
        }
    }
    
    private lazy var textLabel1: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("e9342d")
        label.text = "请选择"
        return label
    }()
    
    private lazy var textLabel2: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "拍照"
        return label
    }()
    
    private lazy var textLabel3: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "从相册选取"
        return label
    }()
    
    ///关闭按钮
    private lazy var closeBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "bm_close_gray_17x17"), for: .normal)
        button.addTarget(self, action: #selector(closeBtnAction), for: .touchUpInside)
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

    
    ///取消按钮
    private lazy var cameraBtn: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(cameraBtnAction), for: .touchUpInside)
        return button
    }()
    
    ///拨打按钮
    private lazy var photoBtn: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(photoBtnAction), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Action
    
    var onClickCamera : (()->())?
    var onClickPhoto: (()->())?
    var onClickClose: (()->())?
    
    //相机
    func cameraBtnAction(){
        if let onClickCamera = onClickCamera {
            onClickCamera()
        }
    }
    
    //照片
    func photoBtnAction(){
        if let onClickPhoto = onClickPhoto {
            onClickPhoto()
        }
    }

    //关闭
    func closeBtnAction(){
        if let onClickClose = onClickClose {
            onClickClose()
        }
    }

}
