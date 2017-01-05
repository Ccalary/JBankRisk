//
//  RepayBillSelectVC.swift
//  JBankRisk
//
//  Created by caohouhong on 16/12/23.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit
import SwiftyJSON

private let cellIdentity = "cellID"
class RepayBillSelectVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var selectArray: [Int] = [] {
        didSet{
            self.aTableView.reloadData()
        }
    }
    
    var dataArray:[JSON] = []
    
    var selectInfo: [Dictionary<String,Any>] = []
    
    //全选
    var isSelectAll = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        requestData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    //nav
    func setNavUI(){
        self.view.addSubview(navHoldView)
        navHoldView.navTextLabel.text = self.title
        
        navHoldView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(64)
            make.centerX.equalTo(self.view)
            make.top.equalTo(0)
        }
    }
    
    func setupUI(){
        self.navigationController!.navigationBar.isTranslucent = true;
        self.automaticallyAdjustsScrollViewInsets = false;
        self.title = "账单选择"
        self.view.backgroundColor = defaultBackgroundColor
        
        self.setNavUI()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "全选", style: UIBarButtonItemStyle.plain, target: self, action: #selector(rightNavigationBarBtnAction))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColorHex("00b2ff")
        
        self.view.addSubview(aTableView)
        self.view.addSubview(bottomHoldView)
        self.bottomHoldView.addSubview(amountLabel)
        self.bottomHoldView.addSubview(nextStepBtn)
        
        aTableView.snp.makeConstraints { (make) in
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(515*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(64)
        }
        
        bottomHoldView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(95*UIRate)
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(0)
        }

        amountLabel.snp.makeConstraints { (make) in
            make.width.equalTo(300*UIRate)
            make.height.equalTo(15*UIRate)
            make.right.equalTo(-15*UIRate)
            make.top.equalTo(10*UIRate)
        }
        
        nextStepBtn.snp.makeConstraints { (make) in
            make.width.equalTo(345*UIRate)
            make.height.equalTo(44*UIRate)
            make.centerX.equalTo(bottomHoldView)
            make.bottom.equalTo(-10*UIRate)
        }
    }
    
    /***Nav隐藏时使用***/
    private lazy var navHoldView: NavigationView = {
        let holdView = NavigationView()
        return holdView
    }()
    
    private lazy var bottomHoldView: UIView = {
        let holdView = UIView()
        holdView.backgroundColor = UIColor.clear
        return holdView
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .right
        label.textColor = UIColorHex("666666")
        label.text = "将还款总额：11110元"
        return label
    }()

    //／按钮
    private lazy var nextStepBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "login_btn_red_345x44"), for: .normal)
        button.setTitle("确认", for: UIControlState.normal)
        button.titleLabel?.font = UIFontSize(size: 18*UIRate)
        button.addTarget(self, action: #selector(nextStepBtnAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var aTableView: UITableView = {
        
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = defaultBackgroundColor
        tableView.tableFooterView = UIView()
        tableView.register(BillSelectTableViewCell.self, forCellReuseIdentifier: cellIdentity)
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentity) as! BillSelectTableViewCell
        //去除选择效果
        cell.selectionStyle = .none
        
        if selectArray[indexPath.row] == 1 {
            cell.selectImageView.image = UIImage(named: "repay_selected_circle_20x20")
        }else {
            cell.selectImageView.image = UIImage(named: "repay_unselect_circle_20x20")
        }
        
        cell.cellWithDate(dic: dataArray[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60*UIRate
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if selectArray[indexPath.row] == 1{
            selectArray[indexPath.row] = 0
            
            dataArray[indexPath.row]["selected"] = 0
        }else {
            selectArray[indexPath.row] = 1
            
            dataArray[indexPath.row]["selected"] = 1
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
    
    //MARK: Action
    func rightNavigationBarBtnAction(){
        if isSelectAll {
            self.navigationItem.rightBarButtonItem?.title = "全选"
            selectArray = selectArray.map{$0 * 0}
            isSelectAll = !isSelectAll
        }else {
            self.navigationItem.rightBarButtonItem?.title = "取消"
            selectArray = selectArray.map{$0 * 0 + 1}
            isSelectAll = !isSelectAll
            
            for i in 0..<dataArray.count {
                dataArray[i]["selected"] = 1
            }
        }
    }
    
    //确认
    func nextStepBtnAction(){
    
        let selectInfotemp = dataArray.filter({ (json) -> Bool in
            return json["selected"] == 1
        })
        selectInfo.removeAll()
        selectInfo = selectInfotemp.reduce(selectInfo) { (selectInfo, jsonObject) -> [Dictionary<String,Any>] in
                var dic = [String:Any]()
                dic["orderId"] = jsonObject["orderId"].stringValue
                dic["repayment_id"] = jsonObject["repayment_id"].stringValue
            
                var dicArray = selectInfo
                dicArray.append(dic)
                return dicArray
        }
        
       let repayVC = RepayViewController()
        repayVC.selectInfo = self.selectInfo
       self.navigationController?.pushViewController(repayVC, animated: true)
    }
    
    //MARK: - 请求数据
    func requestData(){
        //添加HUD
        self.showHud(in: self.view, hint: "加载中...")
        
        var params = NetConnect.getBaseRequestParams()
        params["userId"] = UserHelper.getUserId()!
        params["flag"] = 1 //1-全部应还 2-本月应还 3-近7日  4-今日
        
        NetConnect.pc_need_repayment_detail(parameters: params, success: { response in
            //隐藏HUD
            self.hideHud()
            let json = JSON(response)
            guard json["RET_CODE"] == "000000" else{
                return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
            }
            
            self.dataArray.removeAll()
            self.dataArray = json["backList"].arrayValue
            
            self.selectArray.removeAll()
            self.selectArray = Array(repeating: 0, count: self.dataArray.count)
            
        }, failure:{ error in
            //隐藏HUD
            self.hideHud()
        })
    }
}
