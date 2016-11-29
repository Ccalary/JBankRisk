//
//  SysMessageViewController.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/4.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit
import SwiftyJSON

class SysMessageViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    var isHaveData = false 
    
    var page: Int = 1
    
    var messageId = ""
    
    var dataArray: [JSON] = [] {
        didSet{
            self.aTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if isHaveData {
            self.requestData()
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
            make.top.equalTo(50*UIRate + 64)
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
        
        self.aTableView.addPullRefreshHandler({ _ in
            self.requestData()
            self.aTableView.stopPullRefreshEver()
        })
    }
    
    func setupUI(){
        self.navigationController!.navigationBar.isTranslucent = true
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = defaultBackgroundColor
        self.title = "消息"
        self.setNavUI()
        
        if isHaveData {
            self.setupNormalUI()
        }else {
            self.setupDefaultUI()
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
    
    /**********/
    //缺省页
    private lazy var defaultView: NothingDefaultView = {
        let holdView = NothingDefaultView(viewType: NothingDefaultView.DefaultViewType.nothing)
        return holdView
    }()
    
    /********/
    private lazy var aTableView: UITableView = {
        
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = defaultBackgroundColor
        tableView.register(SysMessageTableViewCell.self, forCellReuseIdentifier: "messageCellID")
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCellID") as! SysMessageTableViewCell
        //去除选择效果
        cell.selectionStyle = .none
        
        //标题
        cell.topTextLabel.text = "借款进度提醒"
        cell.bottomTextLabel.text = dataArray[indexPath.row].dictionary?["result"]?.stringValue
        cell.timeTextLabel.text = toolsChangeDateStyle(toYYYYMMDD: (dataArray[indexPath.row].dictionary?["time_stamp"]!.stringValue)!)
        //0-未读  1-已读
        if dataArray[indexPath.row].dictionary?["flag"]?.stringValue == "0"{
           cell.redImageView.isHidden = false
        }else {
           cell.redImageView.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66*UIRate
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let viewController = MessageDetailViewController()
        viewController.timeStamp = toolsChangeDateStyle(toYYYYMMDD: (dataArray[indexPath.row].dictionary?["time_stamp"]!.stringValue)!)
        viewController.contentText = (dataArray[indexPath.row].dictionary?["result"]?.stringValue)!
        self.navigationController?.pushViewController(viewController, animated: true)
        
        self.messageId = (dataArray[indexPath.row].dictionary?["auditId"]?.stringValue)!
        
        self.requestReadData()
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
        params["page"] = self.page
        
        NetConnect.pc_message_detail(parameters: params, success: { response in
            //隐藏HUD
            self.hideHud()
            let json = JSON(response)
            guard json["RET_CODE"] == "000000" else{
                return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
            }
            self.refreshUI(josn: json["appInfoStatus"])
        
        }, failure:{ error in
            //隐藏HUD
            self.hideHud()
        })
    }

    func refreshUI(josn: JSON){
        dataArray.removeAll()
        dataArray = josn.arrayValue
    }
    
    //MARK: -消息已读
    func requestReadData(){
        
        var params = NetConnect.getBaseRequestParams()
        params["userId"] = UserHelper.getUserId()!
        params["auditId"] = self.messageId
        
        NetConnect.pc_message_readed(parameters: params, success: { response in
            
            let json = JSON(response)
            guard json["RET_CODE"] == "000000" else{
                return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
            }
            
        }, failure:{ error in
        
        })
    }

    
}

