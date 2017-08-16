//
//  RepayBillViewController.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/4.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//  

import UIKit
import SwiftyJSON

class RepayBillViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    //是否有数据
    var isHaveData = false
    //月还款状态
    var monthRepayStatus: RepayStatusType = .finish
    
    var monthDataArray = [JSON]()
    var allDataArray = [JSON]()
    
    //清算id
    fileprivate var payOrderId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.requestData()
    }
    
    ///MARK: - 基本UI
    func setupUI(){
        self.navigationController!.navigationBar.isTranslucent = true
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationItem.title = "还款账单"
        self.view.backgroundColor = defaultBackgroundColor
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
        defaultView.onClickApplyAction = {[unowned self] _ in
            if UserHelper.getUserRole() == nil {
                UserHelper.setUserRole(role: "白领")
            }
            let borrowMoneyVC = BorrowMoneyViewController()
            borrowMoneyVC.currentIndex = 0
            self.navigationController?.pushViewController(borrowMoneyVC, animated: false)
        }
    }
    
    func setupNormalUI(){
        self.navigationItem.title = "还款账单"
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = defaultBackgroundColor
        
        self.view.addSubview(aTableView)
        self.view.addSubview(preRepayBtn)
        self.view.addSubview(monthRepayBtn)
        
        self.aTableView.tableHeaderView = self.headerHoldView
        
        aTableView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(SCREEN_HEIGHT - 64 - 60*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(64)
        }
        
        preRepayBtn.snp.makeConstraints { (make) in
            make.width.equalTo(150*UIRate)
            make.height.equalTo(40*UIRate)
            make.centerX.equalTo(self.view).offset(-95*UIRate)
            make.bottom.equalTo(-10*UIRate)
        }
        
        monthRepayBtn.snp.makeConstraints { (make) in
            make.size.equalTo(preRepayBtn)
            make.centerX.equalTo(self.view).offset(95*UIRate)
            make.bottom.equalTo(preRepayBtn)
        }
        
        //刷新
        self.aTableView.addPullRefreshHandler({[weak self] _ in
            self?.requestData()
            self?.aTableView.stopPullRefreshEver()
        })
    }
    //MARK:月头部
    func monthTableViewHeader() -> UIView {
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
    }
    //MARK:全部头部
    func allTableViewHeader() -> UIView{
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
    /********/
    //还款账单缺省页
    private lazy var defaultView: BorrowDefaultView = {
        let holdView = BorrowDefaultView(viewType: BorrowDefaultView.BorrowDefaultViewType.repayBill)
        return holdView
    }()
    
    private lazy var headerHoldView: RepayBillHeaderView = {
        let holdView = RepayBillHeaderView()
        holdView.delegate = self
        return holdView
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
        tableView.backgroundColor = defaultBackgroundColor
        tableView.tableFooterView = UIView()
        tableView.register(BorrowRecordTableViewCell.self, forCellReuseIdentifier: "borrowCellID")
        tableView.register(RepayBillTableVeiwCell.self, forCellReuseIdentifier: "repayCellID")
        
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
    
    //／按钮
    private lazy var preRepayBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "btn_red_150x40"), for: .normal)
        button.setTitle("提前还款", for: UIControlState.normal)
        button.titleLabel?.font = UIFontSize(size: 18*UIRate)
        button.addTarget(self, action: #selector(preRepayBtnAction), for: .touchUpInside)
        return button
    }()
    
    //／按钮
    private lazy var monthRepayBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "btn_red_150x40"), for: .normal)
        button.setTitle("本月还款", for: UIControlState.normal)
        button.titleLabel?.font = UIFontSize(size: 18*UIRate)
        button.addTarget(self, action: #selector(monthRepayBtnAction), for: .touchUpInside)
        return button
    }()
    
    //MARK: - UITableView Delegate&&DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            //如果无数据则加载缺省页
          return (monthDataArray.count == 0) ?  1 : monthDataArray.count
            
        }else {
            return allDataArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "borrowCellID") as! BorrowRecordTableViewCell
            
            if monthDataArray.count == 0 {
                cell.leftTextLabel.textColor = UIColorHex("999999")
                cell.leftTextLabel.text = "暂无待还借款"
                cell.rightSecondTextLabel.text = ""
                cell.rightTextLabel.text = ""
                cell.arrowImageView.isHidden = true
            }else {
                cell.leftTextLabel.textColor = UIColorHex("666666")
                cell.arrowImageView.isHidden = false
                cell.cellWithMonthData(dic: monthDataArray[indexPath.row])
            }
            
            return cell
            
        }else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "repayCellID") as! RepayBillTableVeiwCell
            //填充数据
            cell.refreshWithAllDataArray(allDataArray[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            let payFlag = allDataArray[indexPath.row]["pay_flag"].intValue
            if payFlag == 1 || payFlag == 2 {
                return 70*UIRate
            }
        }
        return 45*UIRate
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 { //月详情
            //必须有还款
            guard monthDataArray.count > 0 else {
                return
            }
            //0-已支付 1-未支付 2-提前支付 3-逾期未支付 4-逾期已支付
            let repayStatus = monthDataArray[indexPath.row]["is_pay"].stringValue
            if repayStatus == "0" ||  repayStatus == "2" || repayStatus == "4"{
                monthRepayStatus = .finish
            }else {
                //有逾期
                if monthDataArray[indexPath.row]["penalty_day"].intValue > 0 {
                    monthRepayStatus = .overdue
                }else {
                    monthRepayStatus = .not
                }
            }
            let repayDetailVC = RepayPeriodDetailVC()
            repayDetailVC.repaymentId = monthDataArray[indexPath.row]["repayment_id"].stringValue
            repayDetailVC.repayStatusType = monthRepayStatus //还款状态
            self.navigationController?.pushViewController(repayDetailVC, animated: true)
            
        }else {
            
            let repayDetailVC = RepayDetailViewController()
            repayDetailVC.orderId = allDataArray[indexPath.row]["orderId"].stringValue//产品id
            self.navigationController?.pushViewController(repayDetailVC, animated: true)
        }
    }
    
    //Header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return section == 0 ? monthTableViewHeader() : allTableViewHeader()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 50*UIRate : 60*UIRate
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
    
    //MARK: - 请求数据
    func requestData(){
        //添加HUD
        self.showHud(in: self.view, hint: "加载中...")
        
        var params = NetConnect.getBaseRequestParams()
        params["userId"] = UserHelper.getUserId()
        NetConnect.pc_repayment_bill(parameters: params, success: { response in
            //隐藏HUD
            self.hideHud()
            let json = JSON(response)
            guard json["RET_CODE"] == "000000" else{
                return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
            }
            self.refreshUI(json: json["backMap"])
            
        }, failure:{ error in
            //隐藏HUD
            self.hideHud()
        })
    }
    
    func refreshUI(json: JSON){
        //应还总额
        headerHoldView.totalMoneyLabel.text = toolsChangeMoneyStyle(amount: json["currentPayMoney"].doubleValue)
        if json["currentPayMoney"].doubleValue > 0{
            self.recentTimeLabel.text = "最近还款日" + toolsChangeDateStyle(toMMDD: json["RecentPayDate"].stringValue)
        }else{
            self.recentTimeLabel.text = ""
        }
        //是否有清算的id
        payOrderId = json["payOrderId"].stringValue
        
        self.monthDataArray.removeAll()
        self.allDataArray.removeAll()
        
        self.monthDataArray = json["monthAccountList"].arrayValue
        self.allDataArray = json["menuAccountList"].arrayValue
        
        //如果没有加载过，则加载界面
        if !isHaveData {
            if self.monthDataArray.isEmpty && self.allDataArray.isEmpty {
                self.setupDefaultUI()
            }else {
                self.setupNormalUI()
                isHaveData = true
            }
        }
        self.aTableView.reloadData()
    }
}

extension RepayBillViewController:RepayBillHeaderViewDelegate {
    
    //MARK: - RepayBillHeaderViewDelegate
    func clickHeaderBtnAction(){
      self.navigationController?.pushViewController(NeedRepayViewController(), animated: true)
    }
    
    //提前还款
    func preRepayBtnAction(){
        
        let repayBillVC = RepayBillSelectVC()
        if self.payOrderId.characters.count > 0 {
            repayBillVC.payOrderId = self.payOrderId
        }
        self.navigationController?.pushViewController(repayBillVC, animated: true)
    }
    //本月还款
    func monthRepayBtnAction(){
        if self.monthDataArray.count > 0 {
            
            var selectInfo: [Dictionary<String,Any>] = []
            
            selectInfo = monthDataArray.reduce(selectInfo) { (selectInfo, jsonObject) -> [Dictionary<String,Any>] in
                var dic = [String:Any]()
                dic["orderId"] = jsonObject["orderId"].stringValue
                dic["repayment_id"] = jsonObject["repayment_id"].stringValue
                
                var dicArray = selectInfo
                dicArray.append(dic)
                return dicArray
            }
            
            let repayVC = RepayViewController()
            repayVC.selectInfo = selectInfo
            self.navigationController?.pushViewController(repayVC, animated: true)
            
        }else {
            self.navigationController?.pushViewController(NoNeedRepayVC(), animated: true)
        }
    }
}

