//
//  BorrowMoneyTopTipsView.swift
//  JBankRisk
//
//  Created by caohouhong on 16/12/30.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

class BorrowMoneyTopTipsView: UIView {

    enum TipsType: String {
        case tips1 = "填写真实资料有助于提高您的贷款额度哦！"
        case tips2 = "请上传真实资料，乱填或误填将会影响借款申请！"
    }
    
    var viewType = TipsType.tips1
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(viewType: TipsType) {
        let frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 30*UIRate)
        self.init(frame: frame)
        topTextLabel.text = viewType.rawValue
        self.setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //基本UI
    func setupUI(){
        self.backgroundColor = UIColorHex("fbfbfb")
        
        self.addSubview(topTextLabel)
        self.addSubview(starImageView)
        self.addSubview(divideLine1)
        
        topTextLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.centerX.equalTo(self).offset(9*UIRate)
        }
        
        starImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(15*UIRate)
            make.right.equalTo(topTextLabel.snp.left).offset(-3*UIRate)
            make.centerY.equalTo(topTextLabel)
        }
        
        divideLine1.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.height.equalTo(0.5*UIRate)
            make.bottom.equalTo(self)
        }
    }
    
    ///顶部文字
    private lazy var topTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textColor = UIColorHex("666666")
        return label
    }()
    
    private lazy var starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icon_star_15x15")
        return imageView
    }()
    
    //分割线
    private lazy var divideLine1: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()
}
