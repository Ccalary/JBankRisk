//
//  RepayBillViewController.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/4.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

class RepayBillViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    
    func setupUI(){
        self.title = "还款账单"
        self.view.backgroundColor = defaultBackgroundColor
        
        self.view.addSubview(topImageView)
        self.topImageView.addSubview(totalTextLabel)
        self.topImageView.addSubview(totalMoneyLabel)
        self.topImageView.addSubview(arrowImageView)
        
        /*******/
        self.view.addSubview(repayHoldView)
        self.repayHoldView.addSubview(reBottomHoldView)
        self.repayHoldView.addSubview(repayDivideLine)
        self.repayHoldView.addSubview(repayDivideLine2)
        self.repayHoldView.addSubview(repayVerDivideLine)
        
        self.repayHoldView.addSubview(moneyTextLabel)
        self.repayHoldView.addSubview(moneyLabel)
        self.repayHoldView.addSubview(moneyArrowImageView)
        self.repayHoldView.addSubview(amountTextLabel)
        self.repayHoldView.addSubview(amountLabel)
        self.repayHoldView.addSubview(amountArrowImageView)
        self.repayHoldView.addSubview(monthBtn)
        self.repayHoldView.addSubview(amountBtn)
        
        /*******/
        self.view.addSubview(monthBillView)
        self.monthBillView.addSubview(monthIconView)
        self.monthBillView.addSubview(monthBillTextLabel)
        self.monthBillView.addSubview(recentTimeLabel)
        self.monthBillView.addSubview(monthBilldivideLine)
        self.monthBillView.addSubview(aTableView)
        
        /*********/
        self.view.addSubview(totalBillView)
        self.totalBillView.addSubview(totalTopHoldView)
        self.totalBillView.addSubview(totalBilldivideLine1)
        self.totalBillView.addSubview(totalIconView)
        self.totalBillView.addSubview(totalBillTextLabel)
        self.totalBillView.addSubview(totalBilldivideLine2)
        self.totalBillView.addSubview(mTableView)
        
        topImageView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(156*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(64*UIRate)
        }
        
        totalTextLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(topImageView)
            make.top.equalTo(40*UIRate)
        }
        
        totalMoneyLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(80*UIRate)
        }

        arrowImageView.snp.makeConstraints { (make) in
            make.width.equalTo(7*UIRate)
            make.height.equalTo(12*UIRate)
            make.right.equalTo(-75*UIRate)
            make.centerY.equalTo(topImageView)
        }
        
        /*****************/
        repayHoldView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(70*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(topImageView.snp.bottom)
        }
        
        repayDivideLine.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(60*UIRate)
        }
        repayDivideLine2.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(repayHoldView)
        }

        repayVerDivideLine.snp.makeConstraints { (make) in
            make.width.equalTo(0.5*UIRate)
            make.height.equalTo(60*UIRate)
            make.centerX.equalTo(repayHoldView)
            make.top.equalTo(repayHoldView)
        }

        moneyTextLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(-SCREEN_WIDTH/4)
            make.top.equalTo(35*UIRate)
        }
        
        moneyLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(moneyTextLabel)
            make.top.equalTo(12*UIRate)
        }

        moneyArrowImageView.snp.makeConstraints { (make) in
            make.width.equalTo(7*UIRate)
            make.height.equalTo(12*UIRate)
            make.right.equalTo(repayHoldView.snp.centerX).offset(-15*UIRate)
            make.centerY.equalTo(repayHoldView.snp.top).offset(30*UIRate)
        }

        amountTextLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(SCREEN_WIDTH/4)
            make.centerY.equalTo(moneyTextLabel)
        }

        amountLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(amountTextLabel)
            make.centerY.equalTo(moneyLabel)
        }

        amountArrowImageView.snp.makeConstraints { (make) in
            make.width.equalTo(7*UIRate)
            make.height.equalTo(12*UIRate)
            make.right.equalTo(-15*UIRate)
            make.centerY.equalTo(moneyArrowImageView)
        }
        
        monthBtn.snp.makeConstraints { (make) in
            make.width.equalTo(SCREEN_WIDTH/2)
            make.height.equalTo(60*UIRate)
            make.left.equalTo(repayHoldView)
            make.top.equalTo(0)
        }
        
        amountBtn.snp.makeConstraints { (make) in
            make.size.equalTo(monthBtn)
            make.centerY.equalTo(monthBtn)
            make.right.equalTo(repayHoldView)
        }

        reBottomHoldView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(10*UIRate)
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(repayHoldView)
        }

        /*********************/
        monthBillView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(50*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(repayHoldView.snp.bottom)
        }

        monthIconView.snp.makeConstraints { (make) in
            make.width.height.equalTo(20*UIRate)
            make.left.equalTo(8*UIRate)
            make.centerY.equalTo(monthBillView)
        }
        
        monthBillTextLabel.snp.makeConstraints { (make) in
            make.left.equalTo(30*UIRate)
            make.centerY.equalTo(monthBillView)
        }

        recentTimeLabel.snp.makeConstraints { (make) in
            make.right.equalTo(-15*UIRate)
            make.centerY.equalTo(monthBillView)
        }
        
        monthBilldivideLine.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(monthBillView)
        }
        
        aTableView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(90*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(monthBillView.snp.bottom)
        }

        /**************/
        
        totalBillView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(60*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(aTableView.snp.bottom)
        }

        totalTopHoldView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(10*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(totalBillView)
        }
        
        totalBilldivideLine1.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(totalTopHoldView)
        }
        
        totalIconView.snp.makeConstraints { (make) in
            make.width.height.equalTo(20*UIRate)
            make.left.equalTo(8*UIRate)
            make.centerY.equalTo(totalBillView).offset(5*UIRate)
        }
        totalBillTextLabel.snp.makeConstraints { (make) in
            make.left.equalTo(30*UIRate)
            make.centerY.equalTo(totalIconView)
        }

        totalBilldivideLine2.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(totalBillView)
        }

        mTableView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(45*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(totalBillView.snp.bottom)
        }


    }

    //图片
    private lazy var topImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "m_banner_image2_375x156")
        return imageView
    }()
    
    private lazy var totalTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.text = "应还总额(元)"
        return label
    }()
    
    private lazy var totalMoneyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 36*UIRate)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.text = "1599,009.00"
        return label
    }()

    //箭头
    private lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "home_right_arrow_7x12")
        return imageView
    }()
    
    /*************/
    private lazy var repayHoldView: UIView = {
        let holdView = UIView()
        holdView.backgroundColor = UIColor.white
        return holdView
    }()
    
    //分割线
    private lazy var repayDivideLine: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()
    
    private lazy var repayDivideLine2: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()
    
    //分割线
    private lazy var repayVerDivideLine: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()
    
    private lazy var moneyTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("848484")
        label.text = "本月待还(元)"
        return label
    }()
    
    private lazy var moneyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 20*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("f42e2f")
        label.text = "0.00"
        return label
    }()
    
    private lazy var amountTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("848484")
        label.text = "累计已还(元)"
        return label
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 20*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("f42e2f")
        label.text = "100.00"
        return label
    }()
    
    private lazy var reBottomHoldView: UIView = {
        let holdView = UIView()
        holdView.backgroundColor = defaultBackgroundColor
        return holdView
    }()
    
    //箭头
    private lazy var moneyArrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "home_right_arrow_7x12")
        return imageView
    }()
    
    //箭头
    private lazy var amountArrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "home_right_arrow_7x12")
        return imageView
    }()

    //／按钮
    private lazy var monthBtn: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(monthBtnAction), for: .touchUpInside)
        return button
    }()
    
    //／按钮
    private lazy var amountBtn: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(amountBtnAction), for: .touchUpInside)
        return button
    }()
    
    /************/
    
    private lazy var monthBillView: UIView = {
        let holdView = UIView()
        holdView.backgroundColor = UIColor.white
        return holdView
    }()

    //图片
    private lazy var monthIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "m_repay_bill_20x20")
        return imageView
    }()
    
    private lazy var monthBillTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "本月待还账单"
        return label
    }()
    
    private lazy var recentTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "最近还款日10.01"
        return label
    }()

    //分割线
    private lazy var monthBilldivideLine: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()

    private lazy var aTableView: UITableView = {
        
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tag = 10000
        tableView.tableFooterView = UIView()
        tableView.register(BorrowRecordTableViewCell.self, forCellReuseIdentifier: "borrowCellID")

        //tableView 单元格分割线的显示
        if tableView.responds(to:#selector(setter: UITableViewCell.separatorInset)) {
            tableView.separatorInset = .zero
        }
        
        if tableView.responds(to: #selector(setter: UITableViewCell.layoutMargins)) {
            tableView.layoutMargins = .zero
        }
        return tableView
        
    }()
    
    /******************/
    
    private lazy var totalBillView: UIView = {
        let holdView = UIView()
        holdView.backgroundColor = UIColor.white
        return holdView
    }()
    
    private lazy var totalTopHoldView: UIView = {
        let holdView = UIView()
        holdView.backgroundColor = defaultBackgroundColor
        return holdView
    }()
 
    //分割线
    private lazy var totalBilldivideLine1: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()
    
    //图片
    private lazy var totalIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "m_all_repay_bill_20x20")
        return imageView
    }()
    
    private lazy var totalBillTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "全部账单"
        return label
    }()

    //分割线
    private lazy var totalBilldivideLine2: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()
    
    private lazy var mTableView: UITableView = {
        
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tag = 10001
        tableView.tableFooterView = UIView()
        tableView.register(BorrowRecordTableViewCell.self, forCellReuseIdentifier: "borrowCellID")
        
        //tableView 单元格分割线的显示
        if tableView.responds(to:#selector(setter: UITableViewCell.separatorInset)) {
            tableView.separatorInset = .zero
        }
        
        if tableView.responds(to: #selector(setter: UITableViewCell.layoutMargins)) {
            tableView.layoutMargins = .zero
        }
        return tableView
        
    }()

    
    //MARK: - UITableView Delegate&&DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 10000 {
            return 2
        }else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView.tag == 10000 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "borrowCellID") as! BorrowRecordTableViewCell
            //去除选择效果
            cell.selectionStyle = .none
            cell.leftTextLabel.text = "瘦脸"
            cell.rightSecondTextLabel.text = "第一期"
            cell.rightTextLabel.text = "未还清"
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "borrowCellID") as! BorrowRecordTableViewCell
            //去除选择效果
            cell.selectionStyle = .none
            cell.leftTextLabel.text = "瘦脸"
            cell.rightSecondTextLabel.text = "第二期"
            cell.rightTextLabel.text = "还款中"
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45*UIRate
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    //设置分割线
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if cell.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            cell.separatorInset = .zero
        }
        if cell.responds(to: #selector(setter: UITableViewCell.layoutMargins)) {
            cell.layoutMargins = .zero
        }
    }
}

extension RepayBillViewController {
    
    //本月待还
    func monthBtnAction(){
        
    }
    
    //累计还款
    func amountBtnAction(){
        
    }
}
