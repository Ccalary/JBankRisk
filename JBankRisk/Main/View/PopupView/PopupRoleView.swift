//
//  PopupRoleView.swift
//  JBankRisk
//
//  Created by 曹后红 on 16/10/13.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

class PopupRoleView: UIView {

    //职业类型
    enum RoleType: String{
        //白领、学生、自由职业者
        case worker = "成熟干练/收入稳定"
        case student = "朝气蓬勃/勤奋好学"
        case freedom = "无拘无束/悠闲自得"
    }
    
    var mRoleType: RoleType = .worker
    
    ///默认frame
    init(roleType: RoleType) {
        let frame = CGRect(x: 0, y: 0, width: 250*UIRate, height: 330*UIRate)
        super.init(frame: frame)
        self.mRoleType = roleType
        
        setupUI()
        
        showViewWithRole()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func showViewWithRole(){
        
        infoTextLabel.text = mRoleType.rawValue
        
        switch mRoleType {
        case .worker:
            roleImageView.image = UIImage(named: "pop_role_worker_125x130")
            typeTextLabel.attributedText = self.changeTextColor(text: "我是白领", color: UIColorHex("00b2ff"), range: NSRange(location: 2, length: 2))
            break
        case .student:
            roleImageView.image = UIImage(named: "pop_role_student_125x130")
            typeTextLabel.attributedText = self.changeTextColor(text: "我是学生", color: UIColorHex("f9db55"), range: NSRange(location: 2, length: 2))
            break
        case .freedom:
            roleImageView.image = UIImage(named: "pop_role_free_125x130")
            typeTextLabel.attributedText = self.changeTextColor(text: "我是自由族", color: UIColorHex("e9342d"), range: NSRange(location: 2, length: 3))
            break
        }
    }
    
    func setupUI(){
        
        self.backgroundColor = UIColor.white
        
        self.addSubview(roleImageView)
        self.addSubview(typeTextLabel)
        self.addSubview(infoTextLabel)
        self.addSubview(selectBtn)
        
        roleImageView.snp.makeConstraints { (make) in
            make.width.equalTo(125*UIRate)
            make.height.equalTo(130*UIRate)
            make.top.equalTo(27*UIRate)
            make.centerX.equalTo(self)
        }
        
        typeTextLabel.snp.makeConstraints { (make) in
            make.top.equalTo(175*UIRate)
            make.centerX.equalTo(self)
        }
        
        infoTextLabel.snp.makeConstraints { (make) in
            make.top.equalTo(typeTextLabel.snp.bottom).offset(12*UIRate)
            make.centerX.equalTo(self)
        }

        selectBtn.snp.makeConstraints { (make) in
            make.width.equalTo(150*UIRate)
            make.height.equalTo(40*UIRate)
            make.top.equalTo(infoTextLabel.snp.bottom).offset(30*UIRate)
            make.centerX.equalTo(self)
        }
        
    }
    
    //人型
    private lazy var roleImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    

    private lazy var typeTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontBoldSize(size: 18*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        return label
    }()
    
    private lazy var infoTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 12*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("c5c5c5")
        return label
    }()

    
    ///选择按钮
    private lazy var selectBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "btn_select_white_150x40"), for: .normal)
        button.addTarget(self, action: #selector(selectBtnAction), for: .touchUpInside)
        return button
    }()
    
    
    ///富文本，改变字体颜色
    func changeTextColor(text: String, color: UIColor, range: NSRange) -> NSAttributedString {
        let attributeStr = NSMutableAttributedString(string: text)
        attributeStr.addAttribute(NSForegroundColorAttributeName, value:color , range: range)
        
        return attributeStr
    }
    
    //MARK: - Action
    var onClickSelectBtn : (()->())?
    
    //选择按钮
    func selectBtnAction(){
        
        selectBtn.setBackgroundImage(UIImage(named:"btn_selected_red_150x40"), for: .normal)
        
        if let onClickSelectBtn = onClickSelectBtn{
            onClickSelectBtn()
        }
    }
}
