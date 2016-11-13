//
//  RepayPeriodDetailView.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/13.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

enum RepayStatusType {
    case finish  //还款完成
    case overdue // 逾期
    case advance //提前
    case not //未还
}

class RepayPeriodDetailView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    var finishData:[String] = ["应还本息：  ","还款时间：  ","到期时间：  "]
    var overdueData:[String] = ["应还本息：  ","剩余未还：  ","到期时间：  ","逾期天数：  ","逾期罚金：  "]
    var advanceData:[String] = ["应还本息：  ","剩余未还：  ","还款时间：  ","到期时间：  "]
    var notData:[String] = ["应还本息：  ","剩余未还：  ","到期时间：  "]
    
    var dataArray: [String] = []
    var viewType: RepayStatusType = .finish
    
    override init(frame: CGRect ) {
        super.init(frame: frame)
    }
    
    ///初始化默认frame
    convenience init(viewType: RepayStatusType) {
        let frame = CGRect()
        self.init(frame: frame)
        self.viewType = viewType
        switch self.viewType {
        case .finish:
            dataArray = finishData
        case .overdue:
            dataArray = overdueData
        case .advance:
            dataArray = advanceData
        case .not:
            dataArray = notData
        }
        
        let height = CGFloat(dataArray.count)*30*UIRate + 85*UIRate
        self.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: height)
        
        self.setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI(){
        self.backgroundColor = defaultBackgroundColor
        
        self.addSubview(holdView)
        self.holdView.addSubview(aTableView)
        self.holdView.addSubview(nextStepBtn)
        self.holdView.addSubview(divideLine1)
        
        holdView.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.height.equalTo(CGFloat(dataArray.count)*30*UIRate + 85*UIRate)
            make.centerX.equalTo(self)
            make.top.equalTo(0)
        }
        
        aTableView.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.height.equalTo(CGFloat(dataArray.count)*30*UIRate)
            make.centerX.equalTo(self)
            make.top.equalTo(10*UIRate)
        }
        
        nextStepBtn.snp.makeConstraints { (make) in
            make.width.equalTo(254*UIRate)
            make.height.equalTo(44*UIRate)
            make.centerX.equalTo(self)
            make.top.equalTo(aTableView.snp.bottom).offset(10*UIRate)
        }
        
        divideLine1.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(self)
            make.bottom.equalTo(holdView)
        }
        
        if viewType == .finish {
        self.nextStepBtn.setBackgroundImage(UIImage(named:"pop_btn_gray_85x40"), for: .normal)
            self.nextStepBtn.setTitle("还款完成", for: .normal)
            self.nextStepBtn.isUserInteractionEnabled = false
        }
    }
    
    private lazy var holdView: UIView = {
        let holdView = UIView()
        holdView.backgroundColor = UIColor.white
        return holdView
    }()
    
    //分割线
    private lazy var divideLine1: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()
    
    private lazy var aTableView: UITableView = {
        
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.register(RepayDetailTableViewCell.self, forCellReuseIdentifier: "CellID")
        
        return tableView
    }()
    
    //按钮
    private lazy var nextStepBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "btn_red_254x44"), for: .normal)
        button.setTitle("去还款", for: UIControlState.normal)
        button.titleLabel?.font = UIFontSize(size: 18*UIRate)
        button.addTarget(self, action: #selector(nextStepBtnAction), for: .touchUpInside)
        return button
    }()
    
    //MARK: - UITableView Delegate&&DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID") as!
        RepayDetailTableViewCell
  
        cell.selectionStyle = .none
        cell.arrowImageView.isHidden = true
        cell.centerLabel.text = dataArray[indexPath.row] + "100元"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30*UIRate
    }
    
    //MARK: - Action
    func nextStepBtnAction(){
        
    }
}
