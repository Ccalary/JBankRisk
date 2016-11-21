//
//  BorrowStatusVC.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/18.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit
import SwiftyJSON

///借款状态
enum OrderStausType {
    case finish      //订单完结
    case examing     //审核中
    case fullSuccess //满额通过
    case checking    //校验中
    case repaying    //还款中
    case fail        //审核未通过
    case upLoadBill  //上传服务单
    case reUploadData//补交材料
    case defaultStatus //缺省
}

class BorrowStatusVC: UIViewController {
    
    var statusType: OrderStausType = .defaultStatus
    
    var orderInfo: JSON?
    
    var topHeight: CGFloat = 0
    
    var isHaveData = true //是否加载缺省页
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let status = orderInfo?["jstatus"].stringValue {
            
            switch status {
            case "0"://订单完结
                statusType = .finish
                infoView.isHidden = true
                topHeight = 280*UIRate
            case "2": //审核中
                statusType = .examing
                topHeight = 200*UIRate
            case "3"://满额通过
                statusType = .fullSuccess
                topHeight = 280*UIRate
            case "4"://校验中
                statusType = .checking
                topHeight = 200*UIRate
            case "5"://还款中
                 statusType = .repaying
                 topHeight = 280*UIRate
                infoView.isHidden = true
            case "7"://审核未通过
                statusType = .fail
                topHeight = 280*UIRate
            case "8": //上传服务单
                statusType = .upLoadBill
            case "9": //补交材料
                statusType = .reUploadData
            default:
                statusType = .defaultStatus
            }
        }
        setupUI()
        
        self.onClickButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Nav
    func setNavUI(){
        self.view.addSubview(navHoldView)
        self.navHoldView.addSubview(navImageView)
        self.navHoldView.addSubview(navTextLabel)
        self.navHoldView.addSubview(navDivideLine)
        
        navTextLabel.text = self.title
        
        navHoldView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(64)
            make.centerX.equalTo(self.view)
            make.top.equalTo(0)
        }
        
        navImageView.snp.makeConstraints { (make) in
            make.width.equalTo(13)
            make.height.equalTo(21)
            make.left.equalTo(19)
            make.centerY.equalTo(10)
        }
        
        navTextLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(navImageView)
        }
        
        navDivideLine.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(navHoldView)
        }
    }
    
    func setupUI(){
        self.view.backgroundColor = defaultBackgroundColor
        self.title = self.orderInfo?["orderName"].stringValue
        self.setNavUI()
        
        self.view.addSubview(statusView)
        self.view.addSubview(infoView)
        
        statusView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(topHeight)
            make.centerX.equalTo(self.view)
            make.top.equalTo(64)
        }

        infoView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(300*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.statusView.snp.bottom)
        }
        
        //协议
        infoView.onClickProtocol = {
            let webView = BaseWebViewController()
            webView.requestUrl = PC_PROTOCOL_DETAIL + "&" + (self.orderInfo?["order_id"].stringValue)!
            self.navigationController?.pushViewController(webView, animated: true)
        }
    }
    
    /***Nav隐藏时使用***/
    private lazy var navHoldView: UIView = {
        let holdView = UIView()
        holdView.backgroundColor = UIColor.white
        return holdView
    }()
    
    //图片
    private lazy var navImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "navigation_left_back_13x21")
        return imageView
    }()
    
    private lazy var navTextLabel: UILabel = {
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
    
    /*********/

    private lazy var statusView: BorrowStatusView = {
        let holdView = BorrowStatusView(statusType: self.statusType)
        return holdView
    }()
    
    private lazy var infoView: BorrowInfoView = {
        let holdView = BorrowInfoView(json: self.orderInfo!)
        return holdView
    }()
    
    
    //点击按钮
    func onClickButton(){
        
        statusView.onClickButton = {
            
        }
    }
    
}
