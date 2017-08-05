//
//  RepayDetailViewController.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/5.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
// 

import UIKit
import SwiftyJSON

class RepayDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UIGestureRecognizerDelegate {

    //是否从推送而来
    var isPush = false
    
    //产品id
    var orderId = ""
    //筛选
    var selectIndex = 1
    
    var waitDataArray: [JSON] = []
    
    var alreadyDataArray: [JSON] = []
    
    var dataArray: [[JSON]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //如果是从推送而来
        if isPush {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(leftBarButton))
        }
        self.setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         self.aTableView.startPullRefresh()
    }
    
    deinit {
         self.popBgHoldView.removeFromSuperview()
    }
    
    func setupUI(){
        self.navigationController!.navigationBar.isTranslucent = true
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.navigationItem.title = "还款详情"
        self.view.backgroundColor = defaultBackgroundColor
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "筛选", style: UIBarButtonItemStyle.plain, target: self, action: #selector(rightNavigationBarBtnAction))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColorHex("00b2ff")
        
        UIApplication.shared.keyWindow?.addSubview(popBgHoldView)
        let aTap = UITapGestureRecognizer(target: self, action: #selector(tapViewAction))
        aTap.numberOfTapsRequired = 1
        aTap.delegate = self
        self.popBgHoldView.addGestureRecognizer(aTap)
        self.popBgHoldView.addSubview(popView)
        
        self.view.addSubview(aTableView)
        
        self.aTableView.tableHeaderView = self.headerView
        
        aTableView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(SCREEN_HEIGHT - 64)
            make.centerX.equalTo(self.view)
            make.top.equalTo(64)
        }
        
        popView.snp.makeConstraints { (make) in
            make.width.equalTo(80*UIRate)
            make.height.equalTo(125*UIRate)
            make.top.equalTo(55)
            make.right.equalTo(-8*UIRate)
        }
        
        self.aTableView.addPullRefreshHandler({ [weak self] in
            self?.requestData()
        })
        
        //头部按钮点击回调
        self.headerView.onClickNextStepBtn = {[weak self] in
            let vc = RepayFinalVC()
            self?.navigationController?.pushViewController(vc, animated: true)
        }
  }
    
    private lazy var aTableView: UITableView = {
        
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(RepayDetailTableViewCell.self, forCellReuseIdentifier: "repayDetailCellID")
        //tableView 单元格分割线的显示
        if tableView.responds(to:#selector(setter: UITableViewCell.separatorInset)) {
            tableView.separatorInset = .zero
        }
        
        if tableView.responds(to: #selector(setter: UITableViewCell.layoutMargins)) {
            tableView.layoutMargins = .zero
        }
        return tableView
    }()
    
    //图片
    private lazy var headerView: RepayDetailHeaderView = {
        let headerView = RepayDetailHeaderView()
        return headerView
    }()
    
    //section分割线
    private lazy var divideLine1: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()

    //分割线
    private lazy var divideLine2: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()
 
    /*****筛选*****/
    //MARK: - 筛选
    private lazy var popBgHoldView: UIView = {
        let holdView = UIView(frame: self.view.bounds)
        holdView.alpha = 0
        holdView.backgroundColor = UIColorHex("000000", 0.5)
        return holdView
    }()
    
    private lazy var popView: FilterRepayView = {
        let filterView = FilterRepayView()
        
        return filterView
    }()
    
    //MARK: - UITableView Delegate&&DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
      return self.dataArray[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repayDetailCellID") as! RepayDetailTableViewCell
        
        if indexPath.section == 0{
            cell.textColorTheme = .light
            cell.waitCellWithData(dic: self.dataArray[indexPath.section][indexPath.row])
            
        }else {
            cell.textColorTheme = .dark
            cell.alreadyCellWithData(dic:self.dataArray[indexPath.section][indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var monthRepayStatus: RepayStatusType = .finish
        //0-已支付 1-未支付 2-提前支付 3-逾期未支付 4-逾期已支付
        let repayStatus = self.dataArray[indexPath.section][indexPath.row]["is_pay"].stringValue
        if repayStatus == "0" ||  repayStatus == "2" || repayStatus == "4"{
            monthRepayStatus = .finish
        }else  {//有逾期
            let penaltyDay = self.dataArray[indexPath.section][indexPath.row]["penalty_day"].intValue
             if penaltyDay > 0 {
                 monthRepayStatus = .overdue
             }else {
                 monthRepayStatus = .not
            }
         }
        let repayDetailVC = RepayPeriodDetailVC()
        repayDetailVC.repaymentId = self.dataArray[indexPath.section][indexPath.row]["repayment_id"].stringValue
        repayDetailVC.repayStatusType = monthRepayStatus //还款状态
        self.navigationController?.pushViewController(repayDetailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        }else {
            let headerView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 10*UIRate))
            headerView.backgroundColor = defaultBackgroundColor
            
            headerView.addSubview(divideLine1)
            headerView.addSubview(divideLine2)
            
            divideLine1.snp.makeConstraints { (make) in
                make.width.equalTo(headerView)
                make.height.equalTo(0.5*UIRate)
                make.centerX.equalTo(headerView)
                make.top.equalTo(headerView)
            }

            divideLine2.snp.makeConstraints { (make) in
                make.width.equalTo(headerView)
                make.height.equalTo(0.5*UIRate)
                make.centerX.equalTo(headerView)
                make.bottom.equalTo(headerView)
            }
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }else {
            if alreadyDataArray.count > 0 {
                return 10*UIRate
            }else {
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50*UIRate
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
    
    ///消除手势与TableView的冲突
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if NSStringFromClass((touch.view?.classForCoder)!) == "UITableViewCellContentView" {
            return false
        }
        return true
    }
    
    //点击背景筛选消失
    func tapViewAction(){
        
        UIView.animate(withDuration: 0.5, animations: { _ in
            self.popBgHoldView.alpha = 0
        })
    }
    
    func rightNavigationBarBtnAction(){
        
        UIView.animate(withDuration: 0.5, animations: { _ in
            self.popBgHoldView.alpha = 1
        })
        popView.onClickCell = {[unowned self] index in
            self.selectIndex = index
            self.requestData()
            UIView.animate(withDuration: 0.5, animations: { _ in
                self.popBgHoldView.alpha = 0
            })
        }
    }
    
    /********如果是从推送而来*******/
    func leftBarButton(){
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - 请求数据
    func requestData(){
        
        var params = NetConnect.getBaseRequestParams()
        params["userId"] = UserHelper.getUserId()
        params["orderId"] = self.orderId//产品id
        params["flag"] = selectIndex //1-全部 2-待还 3-完成
        
        NetConnect.pc_repayment_all_detail(parameters: params, success: { response in
            let json = JSON(response)
            guard json["RET_CODE"] == "000000" else{
                return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
            }
            
             self.refreshUI(json: json)
             self.aTableView.stopPullRefreshEver()
            
        }, failure:{ error in
            self.aTableView.stopPullRefreshEver()
        })
    }

    func refreshUI(json: JSON){
        //重设标题
        self.navigationItem.title = json["back"]["orderName"].stringValue
    
        //H 测试  申请状态
//        headerView.stateLabel.text = 
        
        waitDataArray = json["waitPay"].arrayValue
        alreadyDataArray = json["alreayPay"].arrayValue
        dataArray.removeAll()
        dataArray.append(waitDataArray)
        dataArray.append(alreadyDataArray)
        self.aTableView.reloadData()
    }
}

