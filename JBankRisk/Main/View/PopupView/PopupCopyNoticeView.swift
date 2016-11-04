//
//  PopupCopyNoticeView.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/4.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

class PopupCopyNoticeView: UIView {

    enum ViewType: String {
        case web = "公司网站"
        case email = "客服邮箱"
    }
    
    var viewType = ViewType.email
    
    var noticeText = ""
    
    override init(frame: CGRect ) {
        super.init(frame: frame)
        setupUI()
    }
    
    ///初始化默认frame
    convenience init(viewType: ViewType) {
        let frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH - 40*UIRate, height: 145*UIRate)
        self.init(frame: frame)
        self.viewType = viewType
        switch self.viewType {
        case .web:
            noticeText = "已经将中诚消费\(self.viewType.rawValue)复制到剪切\n板，可以去使用了"
        case .email:
            noticeText = "已经将中诚消费\(self.viewType.rawValue)复制到剪切\n板，可以去使用了"
        }
        textLabel.text = noticeText
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        
        self.backgroundColor = UIColor.white
        
        self.addSubview(textLabel)
        self.addSubview(sureBtn)
        
        textLabel.snp.makeConstraints { (make) in
            make.top.equalTo(20*UIRate)
            make.centerX.equalTo(self)
        }
        
        sureBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 85*UIRate, height: 40*UIRate))
            make.centerX.equalTo(self)
            make.bottom.equalTo(-15*UIRate)
        }
    }
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.numberOfLines = 0
        return label
    }()
    
    ///拨打按钮
    private lazy var sureBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "pop_btn_red_85x40"), for: .normal)
        button.setTitle("知道了", for: UIControlState.normal)
        button.titleLabel?.font = UIFontBoldSize(size: 18*UIRate)
        button.addTarget(self, action: #selector(sureBtnAction), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Action
    
    var onClickCall: (()->())?

    
    func sureBtnAction(){
        if let onClickCall = onClickCall {
            onClickCall()
        }
    }
    


}
