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
    
    ///MARK: - 基本UI
    func setupUI(){
        self.navigationController!.navigationBar.isTranslucent = true;
        self.automaticallyAdjustsScrollViewInsets = false;
        self.title = "还款账单"
        self.view.backgroundColor = defaultBackgroundColor
        
        setupDefaultUI()
    }
    
    func setupDefaultUI(){
        self.view.addSubview(defaultView)
        
        defaultView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(SCREEN_HEIGHT - 64)
            make.centerX.equalTo(self.view)
            make.top.equalTo(64)
        }
        
        //去申请回调
        defaultView.onClickApplyAction = { _ in
            
        }
        
    }

    
    func setupNormalUI(){
        self.title = "还款账单"
        self.navigationController!.navigationBar.isTranslucent = true;
        self.automaticallyAdjustsScrollViewInsets = false;
        self.view.backgroundColor = defaultBackgroundColor
        
        self.view.addSubview(aTableView)
        
        self.aTableView.tableHeaderView = self.headerHoldView
        
        self.headerHoldView.addSubview(topImageView)
        self.headerHoldView.addSubview(totalBtn)
        self.topImageView.addSubview(totalTextLabel)
        self.topImageView.addSubview(totalMoneyLabel)
        self.topImageView.addSubview(arrowImageView)
        
        /*******/
        self.headerHoldView.addSubview(repayHoldView)
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
        
        aTableView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(SCREEN_HEIGHT - 64)
            make.centerX.equalTo(self.view)
            make.top.equalTo(64)
        }
        
        topImageView.snp.makeConstraints { (make) in
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(156*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(0)
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
        
        totalBtn.snp.makeConstraints { (make) in
            make.size.equalTo(topImageView)
            make.center.equalTo(topImageView)
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

    }
    
    //还款账单缺省页
    private lazy var defaultView: BorrowDefaultView = {
        let holdView = BorrowDefaultView(viewType: BorrowDefaultView.BorrowDefaultViewType.repayBill)
        return holdView
    }()
    
    private lazy var headerHoldView: UIView = {
        let holdView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 226*UIRate))
        holdView.backgroundColor = UIColor.black
        return holdView
    }()

    //图片
    private lazy var topImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "m_banner_image2_375x156")
        return imageView
    }()
    
    //／按钮
    private lazy var totalBtn: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(totalBtnAction), for: .touchUpInside)
        return button
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
    
    //分割线
    private lazy var totalBilldivideLine3: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()
    
    //MARK: - UITableView Delegate&&DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 2
        }else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "borrowCellID") as! BorrowRecordTableViewCell
        
         if indexPath.section == 0 {
            cell.leftTextLabel.text = "瘦脸"
            cell.rightSecondTextLabel.text = "第一期"
            cell.rightTextLabel.text = "未还清"
           
        }else {
        
            cell.selectionStyle = .none
            cell.leftTextLabel.text = "瘦脸+隆鼻"
            cell.rightSecondTextLabel.text = "第二期"
            cell.rightTextLabel.text = "还款中"
           
        }
         return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45*UIRate
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let repayDetailVC = RepayDetailViewController()
        self.navigationController?.pushViewController(repayDetailVC, animated: true)
    }
    
    //Header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
           let headerView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 50*UIRate))
            headerView.backgroundColor = UIColor.white
            
            headerView.addSubview(monthIconView)
            headerView.addSubview(monthBillTextLabel)
            headerView.addSubview(recentTimeLabel)
            headerView.addSubview(monthBilldivideLine)
            
            monthIconView.snp.makeConstraints { (make) in
                make.width.height.equalTo(20*UIRate)
                make.left.equalTo(8*UIRate)
                make.centerY.equalTo(headerView)
            }
            
            monthBillTextLabel.snp.makeConstraints { (make) in
                make.left.equalTo(30*UIRate)
                make.centerY.equalTo(headerView)
            }
            
            recentTimeLabel.snp.makeConstraints { (make) in
                make.right.equalTo(-15*UIRate)
                make.centerY.equalTo(headerView)
            }
            
            monthBilldivideLine.snp.makeConstraints { (make) in
                make.width.equalTo(headerView)
                make.height.equalTo(0.5*UIRate)
                make.centerX.equalTo(headerView)
                make.bottom.equalTo(headerView)
            }

            return headerView
         
        }else {
            let headerView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 60*UIRate))
            headerView.backgroundColor = UIColor.white
            
            headerView.addSubview(totalTopHoldView)
            headerView.addSubview(totalBilldivideLine1)
            headerView.addSubview(totalBilldivideLine2)
            headerView.addSubview(totalIconView)
            headerView.addSubview(totalBillTextLabel)
            headerView.addSubview(totalBilldivideLine3)
            
            totalTopHoldView.snp.makeConstraints { (make) in
                make.width.equalTo(headerView)
                make.height.equalTo(10*UIRate)
                make.centerX.equalTo(headerView)
                make.top.equalTo(headerView)
            }
            
            totalBilldivideLine1.snp.makeConstraints { (make) in
                make.width.equalTo(headerView)
                make.height.equalTo(0.5*UIRate)
                make.centerX.equalTo(headerView)
                make.bottom.equalTo(totalTopHoldView)
            }
            
            totalBilldivideLine2.snp.makeConstraints { (make) in
                make.width.equalTo(headerView)
                make.height.equalTo(0.5*UIRate)
                make.centerX.equalTo(headerView)
                make.top.equalTo(totalTopHoldView)
            }
            
            totalIconView.snp.makeConstraints { (make) in
                make.width.height.equalTo(20*UIRate)
                make.left.equalTo(8*UIRate)
                make.centerY.equalTo(headerView).offset(5*UIRate)
            }
            totalBillTextLabel.snp.makeConstraints { (make) in
                make.left.equalTo(30*UIRate)
                make.centerY.equalTo(totalIconView)
            }
            
            totalBilldivideLine3.snp.makeConstraints { (make) in
                make.width.equalTo(headerView)
                make.height.equalTo(0.5*UIRate)
                make.centerX.equalTo(headerView)
                make.bottom.equalTo(headerView)
            }

            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
             return 50*UIRate
        }else {
             return 60*UIRate
        }
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
    
    //应还总额
    func totalBtnAction(){
        let needRepayVC = NeedRepayViewController()
        self.navigationController?.pushViewController(needRepayVC, animated: true)
    }
    
    //本月待还
    func monthBtnAction(){
        let needRepayVC = NeedRepayViewController()
        self.navigationController?.pushViewController(needRepayVC, animated: true)
    }
    
    //累计还款
    func amountBtnAction(){
        
    }
}
