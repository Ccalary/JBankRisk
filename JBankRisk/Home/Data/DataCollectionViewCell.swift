//
//  DataCollectionViewCell.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/3.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

class DataCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        self.addSubview(imageView)
        self.addSubview(textLabel)
        self.addSubview(deleteBtn)
        
        imageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(100*UIRate)
            make.centerX.equalTo(self).offset(-6*UIRate)
            make.top.equalTo(6*UIRate)
        }
        
        textLabel.snp.makeConstraints { (make) in
            make.width.equalTo(imageView)
            make.height.equalTo(20*UIRate)
            make.top.equalTo(imageView.snp.bottom).offset(5*UIRate)
            make.centerX.equalTo(imageView)
        }
        
        deleteBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(12*UIRate)
            make.centerX.equalTo(imageView.snp.right)
            make.centerY.equalTo(imageView.snp.top)
        }
    }
    
    //图片
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.gray
        return imageView
    }()
    
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        return label
    }()
    
    private lazy var deleteBtn : UIButton = {
       let button = UIButton()
        button.setBackgroundImage(UIImage(named:"bm_close_red_12x12"), for: .normal)
        button.addTarget(self, action: #selector(deleteBtnAction), for: .touchUpInside)
        return button
    }()
    
    var onClickDelete: (() ->())?
    
    //删除
    func deleteBtnAction(){
        if let onClickDelete = onClickDelete {
            onClickDelete()
        }
        
    }
}
