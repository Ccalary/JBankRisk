//
//  TitleSelectView.swift
//  JBankRisk
//
//  Created by caohouhong on 17/1/17.
//  Copyright © 2017年 jingjinsuo. All rights reserved.
//

import UIKit

protocol TitleSelectViewDelegate: class {
    func titleButtonOnClick()
}

class TitleSelectView: UIView {
    
    weak var delegate: TitleSelectViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        
        self.addSubview(self.titleTextLabel)
        self.addSubview(titleButton)
        self.addSubview(titleArrowImgView)
        
        titleTextLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self)
        }
        
        titleButton.snp.makeConstraints { (make) in
            make.size.equalTo(self)
            make.center.equalTo(self)
        }
        
        titleArrowImgView.snp.makeConstraints { (make) in
            make.width.height.equalTo(6*UIRate)
            make.left.equalTo(titleTextLabel.snp.right).offset(2*UIRate)
            make.centerY.equalTo(titleTextLabel)
        }
    }
    
    //title
    lazy var titleTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 18)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "全部纪录"
        return label
    }()
    
    //navigationBar图片
    lazy var titleArrowImgView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "triangle_down_6x6")
        return imageView
    }()
    
    //／title按钮
    private lazy var titleButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(titleButtonAction), for: .touchUpInside)
        return button
    }()
    
    func titleButtonAction(){
        if let delegate = delegate {
            delegate.titleButtonOnClick()
        }
    }
}
