//
//  BorrowInfoView.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/18.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit
import SwiftyJSON

class BorrowInfoView: UIView , UITableViewDelegate, UITableViewDataSource{

    var dataArray = ["产品名称","所属商户","申请金额","申请期限","月还款额"]
    
    var json: JSON!
    
    override init(frame: CGRect ) {
        super.init(frame: frame)
        
    }
    
    ///初始化默认frame
    convenience init(json: JSON) {
        let frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 60*UIRate + 5*30*UIRate + 50*UIRate)
        self.init(frame: frame)
        self.json = json
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        self.backgroundColor = UIColor.white
       
        self.addSubview(dividerView)
        self.addSubview(divideLine1)
        self.addSubview(titleTextLabel)
        self.addSubview(divideLine2)
        self.addSubview(aTableView)
        self.addSubview(protocolBtn)
        
        dividerView.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.height.equalTo(10*UIRate)
            make.centerX.equalTo(self)
            make.top.equalTo(0)
        }
        
        divideLine1.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(self)
            make.top.equalTo(10*UIRate)
        }
        
        divideLine2.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(self)
            make.top.equalTo(59*UIRate)
        }

        titleTextLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self.snp.top).offset(35*UIRate)
        }
        
        aTableView.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.height.equalTo(CGFloat(dataArray.count)*30*UIRate)
            make.centerX.equalTo(self)
            make.top.equalTo(60*UIRate)
        }

        protocolBtn.snp.makeConstraints { (make) in
            make.width.equalTo(70*UIRate)
            make.height.equalTo(30*UIRate)
            make.right.equalTo(-10*UIRate)
            make.top.equalTo(self.aTableView.snp.bottom).offset(5*UIRate)
        }

    }
    
    private lazy var dividerView: UIView = {
        let holdView = UIView()
        holdView.backgroundColor = defaultBackgroundColor
        return holdView
    }()
    
    //分割线
    private lazy var divideLine1: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()

    private lazy var titleTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 18*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "借款信息"
        return label
    }()

    //分割线
    private lazy var divideLine2: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()
    
    //／按钮
    private lazy var protocolBtn: UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColorHex("00b2ff").cgColor
        button.layer.borderWidth = 0.5*UIRate
        button.layer.cornerRadius = 2*UIRate
        button.setTitleColor(UIColorHex("00b2ff"), for: .normal)
        button.setTitle("合同详情", for: UIControlState.normal)
        button.titleLabel?.font = UIFontSize(size: 15*UIRate)
        button.addTarget(self, action: #selector(protocolBtnAction), for: .touchUpInside)
        return button
    }()

    private lazy var aTableView: UITableView = {
        
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.tableFooterView = UIView()
        tableView.register(RepayListTableViewCell.self, forCellReuseIdentifier: "CellID")
        
        return tableView
        
    }()
    //MARK: - UITableView Delegate&&DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID") as! RepayListTableViewCell
        //去除选择效果
        cell.selectionStyle = .none
        cell.leftOffTextLabel.text = dataArray[indexPath.row]
        switch indexPath.row {
        case 0:
            cell.rightOffTextLabel.text = json["orderName"].stringValue
        case 1:
             cell.rightOffTextLabel.text = json["sale_name"].stringValue
        case 2:
             cell.rightOffTextLabel.text = toolsChangeMoneyStyle(amount: json["amt"].doubleValue) + "元"
        case 3:
             cell.rightOffTextLabel.text = json["total"].stringValue + "期"
        case 4:
             cell.rightOffTextLabel.text = toolsChangeMoneyStyle(amount: json["term_amt"].doubleValue) + "元"
            
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30*UIRate
    }
    
    var onClickProtocol:(()->())?
    
    //协议
    func protocolBtnAction(){
        if let onClickProtocol = onClickProtocol{
            onClickProtocol()
        }
    }

}
