//
//  RepayBillTableVeiwCell.swift
//  JBankRisk
//
//  Created by caohouhong on 17/7/29.
//  Copyright © 2017年 jingjinsuo. All rights reserved.
//

import UIKit
import SwiftyJSON

class RepayBillTableVeiwCell: UITableViewCell {

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
        self.addSubview(rightTextLabel)
        self.addSubview(rightSecondTextLabel)
        self.addSubview(arrowImageView)
        self.addSubview(blLabel)
        self.addSubview(brLabel)
        
        leftTextLabel.snp.makeConstraints { (make) in
            make.left.equalTo(30*UIRate)
            make.top.equalTo(14*UIRate)
        }
        
        rightTextLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.right).offset(-30*UIRate)
            make.centerY.equalTo(leftTextLabel)
        }
        
        rightSecondTextLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(leftTextLabel)
            make.right.equalTo(-100*UIRate)
        }
        
        arrowImageView.snp.makeConstraints { (make) in
            make.width.equalTo(7*UIRate)
            make.height.equalTo(12*UIRate)
            make.right.equalTo(self.snp.right).offset(-15*UIRate)
            make.centerY.equalTo(leftTextLabel)
        }
        
        blLabel.snp.makeConstraints { (make) in
            make.left.equalTo(leftTextLabel)
            make.bottom.equalTo(-14*UIRate)
        }
        
        brLabel.snp.makeConstraints { (make) in
            make.right.equalTo(rightTextLabel)
            make.centerY.equalTo(blLabel)
        }
    }
    
    lazy var leftTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        return label
    }()
    
    lazy var rightTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .right
        label.textColor = UIColorHex("00b2ff")
        return label
    }()
    
    lazy var rightSecondTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        return label
    }()
    
    private lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "home_right_arrow_7x12")
        return imageView
    }()

    lazy var blLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size:15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("999999")
        label.text = "账单清算"
        label.isHidden = true
        return label
    }()

    lazy var brLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size:15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("999999")
        label.text = "申请中"
        label.isHidden = true
        return label
    }()

    func refreshWithAllDataArray(_ array:JSON){
        
        leftTextLabel.text = array["orderName"].stringValue
        rightSecondTextLabel.text = "\(array["term"].stringValue)/\(array["total"].stringValue)期"
        rightTextLabel.text = array["is_pay"].stringValue
        
        let payFlag = array["pay_flag"].intValue
        //0 可申请 隐藏  1 申请中 2 申请成功
        switch payFlag {
        case 1:
            blLabel.isHidden = false
            brLabel.isHidden = false
            brLabel.text = "申请中"
        case 2:
            blLabel.isHidden = false
            brLabel.isHidden = false
            brLabel.text = "申请成功"
        default:
            blLabel.isHidden = true
            brLabel.isHidden = true
        }
    }
}
