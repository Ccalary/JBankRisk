//
//  BorrowMoneyDoneView.swift
//  JBankRisk
//
//  Created by 曹后红 on 16/10/14.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

class BorrowMoneyDoneView: UIView {
 
   override init(frame: CGRect) {
        super.init(frame: frame)
    
        self.setupUI()
    }
    
    ///我要借款界面－icon显示
    convenience init() {
        let frame = CGRect(x: 0, y: 0, width: 30*UIRate, height: 30*UIRate)
        self.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //基本UI
    func setupUI(){
       
        self.addSubview(imageView)
        self.addSubview(finishImageView)
        
        imageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(self)
            make.center.equalTo(self)
        }
        
        finishImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(14*UIRate)
            make.top.equalTo(imageView.snp.centerY)
            make.right.equalTo(imageView.snp.right)
        }
    }
    
    ///显示的图片
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    ///完成标志（对勾）,默认隐藏
    lazy var finishImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "data_finish_green_14x14")
        imageView.isHidden = true
        return imageView
    }()

    
}
