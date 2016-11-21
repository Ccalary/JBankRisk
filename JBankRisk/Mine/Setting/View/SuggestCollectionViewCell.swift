//
//  SuggestCollectionViewCell.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/4.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

class SuggestCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        self.backgroundColor = defaultBackgroundColor
        
        self.addSubview(imageView)
        self.addSubview(holdView)
        self.addSubview(cameraImageView)
        self.addSubview(textLabel)
        self.addSubview(deleteImageView)
        self.addSubview(deleteBtn)
        
        holdView.snp.makeConstraints { (make) in
            make.size.equalTo(self)
            make.center.equalTo(self)
        }
        
        imageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(60*UIRate)
            make.left.equalTo(self)
            make.top.equalTo(6*UIRate)
        }
        
        cameraImageView.snp.makeConstraints { (make) in
            make.width.equalTo(35*UIRate)
            make.height.equalTo(28*UIRate)
            make.centerX.equalTo(self)
            make.top.equalTo(14*UIRate*UIRate)
        }
        
        textLabel.snp.makeConstraints { (make) in
            make.top.equalTo(cameraImageView.snp.bottom).offset(5*UIRate)
            make.centerX.equalTo(cameraImageView)
        }
        
        deleteImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(12*UIRate)
            make.centerX.equalTo(imageView.snp.right)
            make.centerY.equalTo(imageView.snp.top)

        }
        
        deleteBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(30*UIRate)
            make.center.equalTo(deleteImageView.snp.right)
        }
    }
    
    //图片
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = defaultBackgroundColor
        return imageView
    }()
    
    lazy var holdView: UIView = {
        let holdView = UIView()
        holdView.isHidden = true
        holdView.backgroundColor = UIColor.white
        return holdView
    }()
    
    lazy var cameraImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "s_camera_35x28")
        imageView.isHidden = true
        return imageView
    }()
    
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 12*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        return label
    }()
    
    lazy var deleteImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bm_close_red_12x12")
        return imageView
    }()
    
    lazy var deleteBtn : UIButton = {
        let button = UIButton()
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
