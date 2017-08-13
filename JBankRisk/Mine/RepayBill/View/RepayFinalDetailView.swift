//
//  RepayFinalDetailView.swift
//  JBankRisk
//
//  Created by caohouhong on 17/7/30.
//  Copyright © 2017年 jingjinsuo. All rights reserved.
//

import UIKit

class RepayFinalDetailView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    //行数
    var cellNum = 0
    
    var totalHeight:CGFloat = 0.00
    
    var dataArray = [String]() {
        didSet{
            self.aTableView.reloadData()
        }
    }
    var viewType: RepayFinalType = .cannotApply
    
    var onClickNextStepBtn:(()->())?
    
    override init(frame: CGRect ) {
        super.init(frame: frame)
    }
    
    ///初始化默认frame
    convenience init(viewType: RepayFinalType) {
        let frame = CGRect()
        self.init(frame: frame)
        self.viewType = viewType
        var extraHeight:CGFloat = 0.00;
        switch self.viewType {
        case .cannotApply:
            cellNum = 3
        case .canApply:
            cellNum = 4
            extraHeight = 30*UIRate
        case .success:
            cellNum = 3
        case .sucRepaying:
            cellNum = 3
        default:
            cellNum = 3
        }
        
        totalHeight = CGFloat(cellNum)*30*UIRate + 65*UIRate + extraHeight
        self.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: totalHeight)
        
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
            make.height.equalTo(totalHeight)
            make.centerX.equalTo(self)
            make.top.equalTo(0)
        }
        
        aTableView.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.height.equalTo(CGFloat(cellNum)*30*UIRate)
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
        
//        if viewType == .applying {
//            self.nextStepBtn.setBackgroundImage(UIImage(named:"but_gray_254x44"), for: .normal)
//            self.nextStepBtn.setTitle("还款完成", for: .normal)
//            self.nextStepBtn.isUserInteractionEnabled = false
//        }
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
    
    lazy var aTableView: UITableView = {
        
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
        button.setTitle("申请结算", for: UIControlState.normal)
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
        cell.centerLabel.text = dataArray[indexPath.row]
        if dataArray[indexPath.row].contains("逾期"){
            cell.centerLabel.textColor = UIColorHex("e9342d")
            cell.centerLabel.attributedText = changeTextColor(text: dataArray[indexPath.row], color: UIColorHex("666666"), range: NSRange(location: 0, length: 5))
        }else{
            cell.centerLabel.textColor = UIColorHex("666666")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30*UIRate
    }
    
   
    
    //MARK: - Action
    func nextStepBtnAction(){
        //去还款
        if let onClickNextStepBtn = onClickNextStepBtn{
            onClickNextStepBtn()
        }
    }
}
