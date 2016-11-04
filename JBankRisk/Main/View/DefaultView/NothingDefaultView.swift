//
//  NothingDefaultView.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/4.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

class NothingDefaultView: UIView {

    enum DefaultViewType:String {
        case nothing = "什么都没有诶～"
        case netError = "加载失败请检查你的网络"
    }
    override init(frame: CGRect ) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    ///初始化默认frame
    convenience init(viewType: DefaultViewType) {
        let frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 175*UIRate)
        self.init(frame: frame)
        switch viewType {
        case .nothing:
            imageView.image = UIImage(named: "s_nothing_150x150")
        case .netError:
            imageView.image = UIImage(named: "s_nothing_150x150")
        }
        textLabel.text = viewType.rawValue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI(){
        self.backgroundColor = defaultBackgroundColor
        
        self.addSubview(imageView)
        self.addSubview(textLabel)
        
        imageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(150*UIRate)
            make.top.equalTo(0)
            make.centerX.equalTo(self)
        }
        
        textLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(imageView.snp.bottom)
        }
    }
    
    //图片
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "s_net_error_150x150")
        return imageView
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("d4d4d4")
        return label
    }()


}
