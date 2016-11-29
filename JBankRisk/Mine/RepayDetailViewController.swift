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

    //产品id
    var orderId = ""
    //筛选
    var selectIndex = 1
    
    var waitDataArray: [JSON] = []
    
    var alreadyDataArray: [JSON] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.requestData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    deinit {
         self.popBgHoldView.removeFromSuperview()
    }
    
    func setupUI(){
        self.navigationController!.navigationBar.isTranslucent = true;
        self.automaticallyAdjustsScrollViewInsets = false;
        
        self.title = "还款详情"
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
        
        self.aTableView.tableHeaderView = self.topImageView
        self.topImageView.addSubview(nameTextLabel)
//        self.topImageView.addSubview(topDivideLine)
//        self.topImageView.addSubview(totalTextLabel)
//        self.topImageView.addSubview(totalMoneyLabel)
//        self.topImageView.addSubview(restTextLabel)
//        self.topImageView.addSubview(restMoneyLabel)
//        self.topImageView.addSubview(topVerDivideLine)
        
        aTableView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(SCREEN_HEIGHT - 64)
            make.centerX.equalTo(self.view)
            make.top.equalTo(64)
        }
        
        nameTextLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(0)
        }
        
        /*
        topDivideLine.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(35*UIRate)
        }
        
        totalTextLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(-SCREEN_WIDTH/4)
            make.top.equalTo(65*UIRate)
        }
        
        totalMoneyLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(totalTextLabel)
            make.top.equalTo(totalTextLabel.snp.bottom).offset(12*UIRate)
        }

        restTextLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(SCREEN_WIDTH/4)
            make.centerY.equalTo(totalTextLabel)
        }

        restMoneyLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(SCREEN_WIDTH/4)
            make.centerY.equalTo(totalMoneyLabel)
        }

        topVerDivideLine.snp.makeConstraints { (make) in
            make.width.equalTo(0.5*UIRate)
            make.height.equalTo(60*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(60*UIRate)
        }
 */
 
        popView.snp.makeConstraints { (make) in
            make.width.equalTo(80*UIRate)
            make.height.equalTo(125*UIRate)
            make.top.equalTo(55)
            make.right.equalTo(-8*UIRate)
        }
        
        self.aTableView.addPullRefreshHandler({ [weak self] in
            self?.requestData()
            self?.aTableView.stopPullRefreshEver()
        })
        
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
    private lazy var topImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 50*UIRate))
        imageView.image = UIImage(named: "m_banner_small_375x50")
        return imageView
    }()
    
    private lazy var nameTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 18*UIRate)
        label.textAlignment = .center
        label.textColor = UIColor.white
        return label
    }()
    
    /*
    //分割线
    private lazy var topDivideLine: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.white
        return lineView
    }()

    private lazy var totalTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.text = "账单总额(元)"
        return label
    }()
    
    private lazy var totalMoneyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 30*UIRate)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.text = "0.00"
        return label
    }()
    
    private lazy var restTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.text = "剩余未还(元)"
        return label
    }()
    
    private lazy var restMoneyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 30*UIRate)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.text = "0.00"
        return label
    }()
    
    //分割线
    private lazy var topVerDivideLine: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.white
        return lineView
    }()
    
 */
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
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return waitDataArray.count
        }else {
            return alreadyDataArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repayDetailCellID") as! RepayDetailTableViewCell
        //去除选择效果
        cell.selectionStyle = .none
        
        if indexPath.section == 0{
            cell.textColorTheme = .light
            cell.waitCellWithData(dic: (waitDataArray[indexPath.row].dictionary)!)
            
        }else {
            cell.textColorTheme = .dark
            cell.alreadyCellWithData(dic:(alreadyDataArray[indexPath.row].dictionary)!)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section ==  0 {
            var monthRepayStatus: RepayStatusType = .finish
            //0-已支付 1-未支付 2-提前支付 3-逾期未支付 4-逾期已支付
            let repayStatus = (waitDataArray[indexPath.row].dictionary?["is_pay"]?.stringValue)!
            if repayStatus == "0" ||  repayStatus == "2" || repayStatus == "4"{
                monthRepayStatus = .finish
            }else  {//有逾期
                if let penaltyDay = waitDataArray[indexPath.row].dictionary?["penalty_day"]?.intValue {
                    
                    if penaltyDay > 0 {
                        monthRepayStatus = .overdue
                    }else {
                        monthRepayStatus = .not
                    }
                    
                }else {
                    monthRepayStatus = .not
            }
        }
            let repayDetailVC = RepayPeriodDetailVC()
            repayDetailVC.repaymentId = (waitDataArray[indexPath.row].dictionary?["repayment_id"]?.stringValue)!
            repayDetailVC.repayStatusType = monthRepayStatus //还款状态
            self.navigationController?.pushViewController(repayDetailVC, animated: true)

        }else {
            
            var monthRepayStatus: RepayStatusType = .finish
            //0-已支付 1-未支付 2-提前支付 3-逾期未支付 4-逾期已支付
            let repayStatus = (alreadyDataArray[indexPath.row].dictionary?["is_pay"]?.stringValue)!
            if repayStatus == "0" ||  repayStatus == "2" || repayStatus == "4"{
                monthRepayStatus = .finish
            }else {
                //有逾期
                
                 if let penaltyDay = alreadyDataArray[indexPath.row].dictionary?["penalty_day"]?.intValue {
                    
                    if penaltyDay > 0 {
                         monthRepayStatus = .overdue
                    }else {
                        monthRepayStatus = .not
                    }
                   
                }else {
                    monthRepayStatus = .not
                }
            }

            let repayDetailVC = RepayPeriodDetailVC()
            repayDetailVC.repaymentId = (alreadyDataArray[indexPath.row].dictionary?["repayment_id"]?.stringValue)!
            repayDetailVC.repayStatusType = monthRepayStatus //还款状态
            self.navigationController?.pushViewController(repayDetailVC, animated: true)
        }
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
        popView.onClickCell = { index in
            self.selectIndex = index
            self.requestData()
            UIView.animate(withDuration: 0.5, animations: { _ in
                self.popBgHoldView.alpha = 0
            })
        }
    }
    
    //MARK: - 请求数据
    func requestData(){
        //添加HUD
        self.showHud(in: self.view, hint: "加载中...")
        
        var params = NetConnect.getBaseRequestParams()
        params["userId"] = UserHelper.getUserId()!
        params["orderId"] = self.orderId//产品id
        params["flag"] = selectIndex //1-全部 2-待还 3-完成
        
        NetConnect.pc_repayment_all_detail(parameters: params, success: { response in
            //隐藏HUD
            self.hideHud()
            let json = JSON(response)
            guard json["RET_CODE"] == "000000" else{
                return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
            }
            
            self.refreshUI(json: json["back"])
            self.refreshWaitUI(json: json["waitPay"])
            self.refreshAlreadyUI(json: json["alreayPay"])
            
            self.aTableView.reloadData()
            
        }, failure:{ error in
            //隐藏HUD
            self.hideHud()
        })
    }

    func refreshUI(json: JSON){
        nameTextLabel.text = json["orderName"].stringValue
//        totalMoneyLabel.text = toolsChangeMoneyStyle(amount: json["totalAmt"].doubleValue)
//        restMoneyLabel.text = toolsChangeMoneyStyle(amount: json["restTotal"].doubleValue)
    }
    
    func refreshAlreadyUI(json: JSON){
        alreadyDataArray.removeAll()
        alreadyDataArray = json.arrayValue
    }
    
    func refreshWaitUI(json: JSON){
        waitDataArray.removeAll()
        waitDataArray = json.arrayValue
    }
    
}

