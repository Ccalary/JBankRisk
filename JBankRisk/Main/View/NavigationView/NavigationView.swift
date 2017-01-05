//
//  NavigationView.swift
//  JBankRisk
//
//  Created by caohouhong on 16/12/27.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

class NavigationView: UIView {

    override init(frame: CGRect ) {
        super.init(frame: frame)
        setNavUI()
    }
    
    ///初始化默认frame
    convenience init() {
        let frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 64)
        self.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    ///Nav
    func setNavUI(){
        self.backgroundColor = UIColor.white
        self.addSubview(navImageView)
        self.addSubview(navTextLabel)
        self.addSubview(navDivideLine)
        
        navImageView.snp.makeConstraints { (make) in
            make.width.equalTo(13)
            make.height.equalTo(21)
            make.left.equalTo(20)
            make.centerY.equalTo(9.5)
        }
        
        navTextLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).offset(10)
        }
        
        navDivideLine.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(self)
            make.bottom.equalTo(self)
        }
    }
    
    /***Nav隐藏时使用***/
    //图片
    private lazy var navImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "navigation_left_back_13x21")
        return imageView
    }()
    
    lazy var navTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 18)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        return label
    }()
    
    //分割线
    private lazy var navDivideLine: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()
}
