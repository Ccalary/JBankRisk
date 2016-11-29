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
    //月还款id
    var repaymentId = ""
    //总还款id
    var allRepayId = ""
    //月还款状态
    var monthRepayStatus: RepayStatusType = .finish
    
    var monthDataArray:[(name:String, period:String, status:String)] = [("暂无待还借款","","")]
    var allDataArray = [(name:String, period:String, status:String)]()
    
    
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
        
        self.setNavUI()
        
        if isHaveData {
            setupNormalUI()
            self.requestData()
        }else {
            setupDefaultUI()
        }
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
            if UserHelper.getUserRole() == nil {
                UserHelper.setUserRole(role: "白领")
            }
            let borrowMoneyVC = BorrowMoneyViewController()
            borrowMoneyVC.currentIndex = 0
            self.navigationController?.pushViewController(borrowMoneyVC, animated: false)
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
        /*
        self.headerHoldView.addSubview(repayHoldView)
        self.repayHoldView.addSubview(reBottomHoldView)
        self.repayHoldView.addSubview(repayDivideLine)
        self.repayHoldView.addSubview(repayDivideLine2)
        self.repayHoldView.addSubview(repayVerDivideLine)
        */
//        self.repayHoldView.addSubview(moneyTextLabel)
//        self.repayHoldView.addSubview(moneyLabel)
//        self.repayHoldView.addSubview(moneyArrowImageView)
//        self.repayHoldView.addSubview(amountTextLabel)
//        self.repayHoldView.addSubview(amountLabel)
//        self.repayHoldView.addSubview(amountArrowImageView)
//        self.repayHoldView.addSubview(monthBtn)
//        self.repayHoldView.addSubview(amountBtn)
        
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
        /*
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

        */
        //刷新
        self.aTableView.addPullRefreshHandler({ _ in
            self.requestData()
            self.aTableView.stopPullRefreshEver()
        })

        
    }
    //月头部
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
    //全部头部
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
    
    /********/
    //还款账单缺省页
    private lazy var defaultView: BorrowDefaultView = {
        let holdView = BorrowDefaultView(viewType: BorrowDefaultView.BorrowDefaultViewType.repayBill)
        return holdView
    }()
    
    private lazy var headerHoldView: UIView = {
        let holdView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 156*UIRate))
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
        label.text = "本月待还(元)"
        return label
    }()
    
    private lazy var totalMoneyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 36*UIRate)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.text = "0.00"
        return label
    }()

    //箭头
    private lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "home_right_arrow_7x12")
        return imageView
    }()
    
    /*************/
    /*去除，界面更改
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
        label.text = "0.00"
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
    */
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
            return monthDataArray.count
        }else {
            return allDataArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "borrowCellID") as! BorrowRecordTableViewCell
        
         if indexPath.section == 0 {
            cell.leftTextLabel.text = monthDataArray[indexPath.row].name
            cell.rightSecondTextLabel.text = monthDataArray[indexPath.row].period
            cell.rightTextLabel.text = monthDataArray[indexPath.row].status
            
            //如果无还款，改变左边label字体颜色
            if monthDataArray[indexPath.row].period == "" {
                cell.leftTextLabel.textColor = UIColorHex("999999")
                cell.arrowImageView.isHidden = true
            }else {
                cell.leftTextLabel.textColor = UIColorHex("666666")
                cell.arrowImageView.isHidden = false
            }
            //如果有逾期，改变右边label字体颜色
            if monthDataArray[indexPath.row].status.contains("逾期"){
                cell.rightTextLabel.textColor = UIColorHex("f42e2f")
            }else {
                cell.rightTextLabel.textColor = UIColorHex("00b2ff")
            }
           
        }else {
            cell.leftTextLabel.text = allDataArray[indexPath.row].name
            cell.rightSecondTextLabel.text = allDataArray[indexPath.row].period
            cell.rightTextLabel.text = allDataArray[indexPath.row].status
           
        }
         return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45*UIRate
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 { //月详情
            //无还款
           if monthDataArray[indexPath.row].period == "" {
             //什么都不做
            return
           }
            
            let repayDetailVC = RepayPeriodDetailVC()
            repayDetailVC.repaymentId = self.repaymentId
            
           repayDetailVC.repayStatusType = monthRepayStatus //还款状态
            self.navigationController?.pushViewController(repayDetailVC, animated: true)
        }else {
            let repayDetailVC = RepayDetailViewController()
            repayDetailVC.orderId = self.allRepayId//产品id
            self.navigationController?.pushViewController(repayDetailVC, animated: true)
        }
    }
    
    //Header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
           
            return monthTableViewHeader()
         
        }else {
            
            return allTableViewHeader()
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
    
    //MARK: - 请求数据
    func requestData(){
        //添加HUD
        self.showHud(in: self.view, hint: "加载中...")
        
        var params = NetConnect.getBaseRequestParams()
        params["userId"] = UserHelper.getUserId()!
        
        NetConnect.pc_repayment_bill(parameters: params, success: { response in
            //隐藏HUD
            self.hideHud()
            let json = JSON(response)
            guard json["RET_CODE"] == "000000" else{
                return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
            }
            
            self.refreshUI(monthJson: json["backMap"]["menu"],allJson: json["allMenu"])
            
        }, failure:{ error in
            //隐藏HUD
            self.hideHud()
        })
    }

    func refreshUI(monthJson: JSON, allJson: JSON){
        //应还总额
        totalMoneyLabel.text = toolsChangeMoneyStyle(amount: monthJson["MonthRefund"].doubleValue)
//        //本月应还
//        moneyLabel.text = toolsChangeMoneyStyle(amount: monthJson["MonthRefund"].doubleValue)
//        //累计已还
//        amountLabel.text = toolsChangeMoneyStyle(amount: monthJson["accountRefund"].doubleValue)
        self.refreshMonthList(json: monthJson)
        
        self.refreshAllList(json: allJson)
        
        self.aTableView.reloadData()
    }
    
    //本月账单
    func refreshMonthList(json: JSON){
        //本月有还款
        if json["MonthRefund"].doubleValue > 0 {
            
            self.repaymentId = json["repayment_id"].stringValue
            self.recentTimeLabel.text = "最近还款日" + toolsChangeDateStyle(toMMDD: json["realpayDate"].stringValue)
            monthDataArray.removeAll()
            
            let name = json["orderName"].stringValue
            let period = "第" + json["term"].stringValue + "期"
            var status = ""
            
            //0-已支付 1-未支付 2-提前支付 3-逾期未支付 4-逾期已支付
            let repayStatus = json["is_pay"].stringValue
            if repayStatus == "0" ||  repayStatus == "2" || repayStatus == "4"{
                status = "完成"
                monthRepayStatus = .finish
            }else {
                //有逾期
                if json["penalty_day"].intValue > 0 {
                    status = "逾期\(json["penalty_day"].stringValue)天"
                    monthRepayStatus = .overdue
                }else {
                    status = "未还清"
                    monthRepayStatus = .not
                }
            }
            monthDataArray.append((name,period,status))
        }else {
            monthDataArray = [("暂无待还借款","","")]
        }
    }
    
    func refreshAllList(json: JSON){
        
        allDataArray.removeAll()
        
        //现在有问题，后台已一单来做的，没有包成list
        allRepayId = json["orderId"].stringValue
        
        let name = json["orderName"].stringValue
        var period = ""
        var status = ""
        
        let term = json["term"].stringValue
        let total = json["total"].stringValue
        //5-还款中   0-已完结
        if json["jstatus"].stringValue == "5" {
            period = "第" + term + "/" + total + "期"
            status = "还款中"
        }else if json["jstatus"].stringValue == "0"{
            period = total + "期"
            status = "已结束"
        }
        
        allDataArray.append((name,period,status))
    }
}

extension RepayBillViewController {
    
    //应还总额
    func totalBtnAction(){
        let needRepayVC = NeedRepayViewController()
        self.navigationController?.pushViewController(needRepayVC, animated: true)
    }
    
//    //本月待还
//    func monthBtnAction(){
//        let needRepayVC = NeedRepayViewController()
//        self.navigationController?.pushViewController(needRepayVC, animated: true)
//    }
//    
//    //累计还款
//    func amountBtnAction(){
//        let repayListVC = RepayListViewController()
//        self.navigationController?.pushViewController(repayListVC, animated: true)
//    }
}
