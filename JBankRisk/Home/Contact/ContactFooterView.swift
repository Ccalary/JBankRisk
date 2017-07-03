//
//  ContactFooterView.swift
//  JBankRisk
//
//  Created by caohouhong on 17/6/30.
//  Copyright © 2017年 jingjinsuo. All rights reserved.
//

import UIKit

class ContactFooterView: UIView,UITextViewDelegate{

    override init(frame: CGRect ) {
        super.init(frame: frame)
        setupUI()
    }
    
    ///初始化默认frame
    convenience init() {
        let frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 80*UIRate)
        self.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        
        self.backgroundColor = UIColor.white
        
        self.addSubview(textLabel)
        self.addSubview(holderTextLabel)
        self.addSubview(mTextView)
        self.addSubview(divideLine1)
        self.addSubview(divideLine2)
        
        textLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15*UIRate)
            make.top.equalTo(10*UIRate)
        }
        
        mTextView.snp.makeConstraints { (make) in
            make.right.equalTo(-15*UIRate)
            make.left.equalTo(97*UIRate)
            make.top.equalTo(3*UIRate)
            make.bottom.equalTo(10*UIRate)
        }
        
        holderTextLabel.snp.makeConstraints { (make) in
            make.right.equalTo(25*UIRate)
            make.left.equalTo(100*UIRate)
            make.centerY.equalTo(textLabel)
        }

        divideLine1.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.top.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(0.5*UIRate)
        }
        
        divideLine2.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.bottom.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(0.5*UIRate)
        }
    }
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size:15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "备注信息"
        return label
    }()
    
    private lazy var holderTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textColor = UIColorHex("c5c5c5")
        label.text = "备注（选填）"
        return label
    }()

    lazy var mTextView: UITextView = {
        let textField = UITextView()
        textField.font = UIFontSize(size: 15*UIRate)
        textField.textColor = UIColorHex("666666")
        textField.backgroundColor = UIColor.clear
        textField.isScrollEnabled = false
        textField.delegate = self
        return textField
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


    
    //MARK: - TextViewDelegate
    func textViewDidChange(_ textView: UITextView) {
        
        if textView.text.characters.count != 0 {
            holderTextLabel.isHidden = true
            
        }else {
            holderTextLabel.isHidden = false
        }
    }
}
