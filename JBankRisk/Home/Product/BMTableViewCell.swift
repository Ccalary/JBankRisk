//
//  BMTableViewCell.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/1.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

///cell的种类
enum CellType {
    
    case arrowType//右侧箭头
    case textType //右侧文字
    case clearType //右侧清除键
    case cameraType //右侧相机
    case defaultType //默认右侧什么都没有
}

struct CellDataInfo {
    let leftText: String
    let holdText: String
    var content: String
    let cellType: CellType
    
    init(leftText: String, holdText: String, content: String,cellType: CellType ) {
        self.leftText = leftText
        self.holdText = holdText
        self.content = content
        self.cellType = cellType
    }
}

class BMTableViewCell: UITableViewCell {

    var cellDataInfo: CellDataInfo? {
        
        didSet {
            self.rightNormalStatus()
            
            if let cellType = cellDataInfo?.cellType {
                switch cellType {
                case .textType:
                     self.rightTextLabel.isHidden = false
                case .arrowType:
                     self.rightArrowImageView.isHidden = false
                    self.centerTextField.isEnabled = false
                case .clearType:
                      self.rightClearButton.isHidden = false
                case .cameraType:
                     self.rightCameraImageView.isHidden = false
                    self.centerTextField.isEnabled = false
                case .defaultType:
                    self.centerTextField.isEnabled = false
                    break
                }
            }
        }
    }
    
    //显示状态
    func rightNormalStatus(){
        self.leftTextLabel.text = cellDataInfo?.leftText
        self.centerTextField.placeholder = cellDataInfo?.holdText
        self.centerTextField.text = cellDataInfo?.content
        self.centerTextField.isEnabled = true
        
        self.rightTextLabel.isHidden = true
        self.rightClearImageView.isHidden = true
        self.rightClearButton.isHidden = true
        self.rightArrowImageView.isHidden = true
        self.rightCameraImageView.isHidden = true
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
       self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        self.backgroundColor = UIColor.white
        self.addSubview(leftTextLabel)
        self.addSubview(centerTextField)
        self.addSubview(rightArrowImageView)
        self.addSubview(rightTextLabel)
        self.addSubview(rightClearImageView)
        self.addSubview(rightClearButton)
        self.addSubview(rightCameraImageView)
        
        leftTextLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15*UIRate)
            make.centerY.equalTo(self)
        }

        centerTextField.snp.makeConstraints { (make) in
            make.width.equalTo(225*UIRate)
            make.height.equalTo(self)
            make.left.equalTo(100*UIRate)
            make.centerY.equalTo(self)
        }
        
        rightArrowImageView.snp.makeConstraints { (make) in
            make.width.equalTo(7*UIRate)
            make.height.equalTo(12*UIRate)
            make.right.equalTo(self).offset(-15*UIRate)
            make.centerY.equalTo(self)
        }
        
        rightTextLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-15*UIRate)
            make.centerY.equalTo(self)
        }
        
        rightClearImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(15*UIRate)
            make.right.equalTo(self).offset(-15*UIRate)
            make.centerY.equalTo(self)
        }
        
        rightClearButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(30*UIRate)
            make.center.equalTo(rightClearImageView)
        }

        rightCameraImageView.snp.makeConstraints { (make) in
            make.width.equalTo(20*UIRate)
            make.height.equalTo(16*UIRate)
            make.right.equalTo(self).offset(-15*UIRate)
            make.centerY.equalTo(self)
        }

    }
    
    lazy var leftTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        return label
    }()
    
    lazy var centerTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFontSize(size: 15*UIRate)
        textField.textColor = UIColorHex("666666")
        textField.addTarget(self, action: #selector(centerTextFieldAction(_:)), for: UIControlEvents.editingChanged)
        return textField
    }()

   private lazy var rightArrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "home_right_arrow_7x12")
        imageView.isHidden = true
        return imageView
    }()

    lazy var rightTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "元"
        label.isHidden = true
        return label
    }()
    
    lazy var rightClearImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "login_btn_clear_15x15")
        imageView.isHidden = true
        return imageView
    }()
    
    lazy var rightClearButton: UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.addTarget(self, action: #selector(clearButtonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var rightCameraImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bm_camera_20x16")
        imageView.isHidden = true
        return imageView
    }()
    
    func centerTextFieldAction(_ textField: UITextField){
        
        if cellDataInfo?.cellType == .clearType{
            if textField.text?.characters.count == 0 {
                self.rightClearImageView.isHidden = true
            }else
            {
                self.rightClearImageView.isHidden = false
            }
        }
    }
    
    //清除按钮
    func clearButtonAction() {
        self.centerTextField.text = ""
        self.rightClearImageView.isHidden = true
    }
}
