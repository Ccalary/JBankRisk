//
//  BorrowRecordViewController.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/3.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit
import SwiftyJSON

class BorrowRecordViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    var dataArray = [(String,String)]()
    
    //借款状态信息
    var mJstatus = ""
    
    //是否有数据
    var isHaveData = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: -基本UI
    func setupUI(){
        self.navigationController!.navigationBar.isTranslucent = true;
        self.automaticallyAdjustsScrollViewInsets = false;
        self.title = "借款记录"
        self.view.backgroundColor = defaultBackgroundColor
        
        self.setNavUI()
        
        if isHaveData {
            setupNormalUI()
            self.requestData()
        }else{
           self.setupDefaultUI()
        }
    }
    
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
        self.view.addSubview(aTableView)
        
        aTableView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(SCREEN_HEIGHT - 64)
            make.centerX.equalTo(self.view)
            make.top.equalTo(64)
        }
        self.initHeader()
        
        //刷新
        self.aTableView.addPullRefreshHandler({ _ in
            self.requestData()
            self.aTableView.stopPullRefreshEver()
        })
    }
    
    //header
    func initHeader(){
        let headerHoldView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 206*UIRate))
        headerHoldView.backgroundColor = UIColorHex("000000")
        
        self.aTableView.tableHeaderView = headerHoldView
        
        headerHoldView.addSubview(topImageView)
        self.topImageView.addSubview(totalTextLabel)
        self.topImageView.addSubview(moneyLabel)
        
        headerHoldView.addSubview(iconHoldView)
        self.iconHoldView.addSubview(iconImageView)
        self.iconHoldView.addSubview(recodeTextLabel)
        self.iconHoldView.addSubview(divideLine1)

        topImageView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(156*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(0)
        }
        
        totalTextLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(40*UIRate)
        }
        
        moneyLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(totalTextLabel.snp.bottom).offset(23*UIRate)
        }
        
        iconHoldView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(50*UIRate)
            make.top.equalTo(topImageView.snp.bottom)
            make.centerX.equalTo(self.view)
        }
        
        recodeTextLabel.snp.makeConstraints { (make) in
            make.left.equalTo(30*UIRate)
            make.centerY.equalTo(topImageView.snp.bottom).offset(25*UIRate)
        }
        
        iconImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(20*UIRate)
            make.right.equalTo(recodeTextLabel.snp.left)
            make.centerY.equalTo(recodeTextLabel)
        }
        
        divideLine1.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(topImageView.snp.bottom).offset(50*UIRate)
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

    /********/
    //借款纪录缺省页
    private lazy var defaultView: BorrowDefaultView = {
        let holdView = BorrowDefaultView(viewType: BorrowDefaultView.BorrowDefaultViewType.borrowRecord)
        return holdView
    }()
    
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
        label.text = "累计成功借款(元)"
        return label
    }()
    
    private lazy var moneyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 30*UIRate)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.text = "0.00"
        return label
    }()
    
    private lazy var iconHoldView: UIView = {
        let holdView = UIView()
        holdView.backgroundColor = UIColor.white
        return holdView
    }()

    //图片
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "m_bm_record_20x20")
        return imageView
    }()
    
    private lazy var recodeTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "借款记录"
        return label
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
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "borrowCellID") as! BorrowRecordTableViewCell
        
        cell.leftTextLabel.text = dataArray[indexPath.row].0
        cell.rightTextLabel.text = dataArray[indexPath.row].1
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45*UIRate
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //录入中 进入借款流程
        if mJstatus == "99" {
            let borrowMoneyVC = BorrowMoneyViewController()
            self.navigationController?.pushViewController(borrowMoneyVC, animated: false)
        }else {
            let borrowStatusVC = BorrowStatusVC()
            self.navigationController?.pushViewController(borrowStatusVC, animated: true)
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
        params["pFlag"] = "1"//固定值，用来区分返回的金额数值
        
        NetConnect.pc_borrow_record(parameters: params, success: { response in
            //隐藏HUD
            self.hideHud()
            let json = JSON(response)
            guard json["RET_CODE"] == "000000" else{
                return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
            }
            
            self.refreshUI(json: json["orderInfo"])
            
        }, failure:{ error in
            //隐藏HUD
            self.hideHud()
        })
    }
    
    //刷新界面
    func refreshUI(json: JSON){
        let money = json["amt"].doubleValue
        self.moneyLabel.text = toolsChangeMoneyStyle(amount: money)
        self.dataArray.removeAll()
        self.dataArray.append((json["orderName"].stringValue,json["status"].stringValue))
        self.mJstatus = json["jstatus"].stringValue
        self.aTableView.reloadData()
    }

}
