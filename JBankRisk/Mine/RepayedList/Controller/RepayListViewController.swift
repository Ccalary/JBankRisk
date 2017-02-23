//
//  RepayListViewController.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/18.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit
import SnapKit
import SwiftyJSON

class RepayListViewController: UIViewController,UIGestureRecognizerDelegate,UITableViewDelegate, UITableViewDataSource,TitleSelectViewDelegate {
    
    var isHaveData = true
    
    //产品列表
    var repayList: [RepayedListModel] = [] {
        didSet{
            self.aTableView.reloadData()
        }
    }
    
    //产品名字
    var orderNameList: [OrdersModel] = [] {
        didSet{
            self.selectView.repayNameData = orderNameList
        }
    }
    
    var orderId = ""
    
    //标题
    var titleText = "" {
        didSet{
            self.navTitleView.titleTextLabel.text = titleText
            navHoldView.navTextLabel.text = titleText
        }
    }
    
    //是否打开了下拉框
    var isTransformed: Bool = false
    var selectViewConstraint: Constraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()

       self.setupUI()
       self.requestData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //Nav
    func setNavUI(){
        self.view.addSubview(navHoldView)
        navHoldView.navTextLabel.text = self.title
     }
    
    func setupUI(){
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = defaultBackgroundColor
        self.title = "全部纪录"
        if isHaveData {
            self.setupUINormalUI()
            navHoldView.navTextLabel.text = self.navTitleView.titleTextLabel.text
        }else {
            self.setupDefaultUI()
            navHoldView.navTextLabel.text = self.title
        }
        self.setNavUI()
    }
    
    func setupDefaultUI(){
        self.title = "还款明细"
        self.view.addSubview(defaultView)
        
        defaultView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(SCREEN_HEIGHT - 64)
            make.centerX.equalTo(self.view)
            make.top.equalTo(50*UIRate + 64)
        }
    }
    
    func setupUINormalUI(){
        self.navigationItem.titleView = navTitleView
        
        self.view.addSubview(tableHeaderView)
        self.view.addSubview(aTableView)
        
        self.view.addSubview(selectBgView)
        self.view.addSubview(selectView)

        let aTap = UITapGestureRecognizer(target: self, action: #selector(tapViewAction))
        aTap.numberOfTapsRequired = 1
        aTap.delegate = self
        selectBgView.addGestureRecognizer(aTap)
        
        selectBgView.snp.makeConstraints { (make) in
            make.size.equalTo(self.view)
            make.center.equalTo(self.view)
        }
        
        selectView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(180*UIRate)
            make.centerX.equalTo(self.view)
            self.selectViewConstraint = make.top.equalTo(-180*UIRate).constraint
        }
        self.selectViewClick()
        
        aTableView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(SCREEN_HEIGHT - 64 - 45*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(tableHeaderView.snp.bottom)
        }
    }
    
    /***Nav隐藏时使用***/
    private lazy var navHoldView: NavigationView = {
        let holdView = NavigationView()
        return holdView
    }()
    /*********/
    //缺省页
    private lazy var defaultView: NothingDefaultView = {
        let holdView = NothingDefaultView(viewType: NothingDefaultView.DefaultViewType.nothing)
        return holdView
    }()
    
    //下拉选择View
    private lazy var selectView: RepayedNameView = {
        let selectView = RepayedNameView()
        return selectView
    }()
    
    //TitleView
    private lazy var navTitleView: TitleSelectView = {
        let titleView = TitleSelectView(frame: CGRect(x: 0, y: 0, width: 100*UIRate, height: 40))
        titleView.delegate = self
        return titleView
    }()
    
    //下拉时变暗背景
    private lazy var selectBgView: UIView = {
        let holdView = UIView()
        holdView.alpha = 0
        holdView.backgroundColor = UIColorHex("000000", 0.6)
        return holdView
    }()
    
    private lazy var tableHeaderView: RepayedListTopView = {
        let holdView = RepayedListTopView(frame: CGRect(x: 0, y: 64, width: SCREEN_WIDTH, height: 45*UIRate))
        return holdView
    }()
    
    private lazy var aTableView: UITableView = {
        
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = defaultBackgroundColor
        tableView.register(RepayListTableViewCell.self, forCellReuseIdentifier: "CellID")
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
        return repayList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID") as! RepayListTableViewCell
        //去除选择效果
        cell.selectionStyle = .none
        cell.repayModel = repayList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45*UIRate
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
    
    //MARK: - Method
    //点击了下拉框的回调
    func selectViewClick(){
        selectView.onClickCell = {[unowned self] (title, nameId) in
            self.titleText = title
            self.orderId = nameId
            self.closeSelectView()
            self.requestData()
        }
    }
    
    //MARK: - Action
    func tapViewAction(){
        if isTransformed{
            self.closeSelectView()
        }
    }
    
    //MARK:TitleSelectViewDelegate 头部图片点击
    func titleButtonOnClick(){
        
        if !isTransformed {
            //打开
            UIView.animate(withDuration: 0.6, animations: {
                self.navTitleView.titleArrowImgView.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
                self.selectViewConstraint?.update(offset: 64)
                self.view.layoutIfNeeded()//一定要加上这句话才会有动画效果
                self.selectBgView.alpha = 1
            })
            isTransformed = !isTransformed
        }else {
            self.closeSelectView()
        }
    }
    //关闭
    func closeSelectView(){
        
        UIView.animate(withDuration: 0.6, animations: {
            self.navTitleView.titleArrowImgView.transform = CGAffineTransform(rotationAngle: CGFloat(0))
            self.selectViewConstraint?.update(offset: -180*UIRate)
            self.view.layoutIfNeeded()
            self.selectBgView.alpha = 0
        })
        isTransformed = !isTransformed
    }
    
    
    //MARK: - 请求数据
    func requestData(){
        //添加HUD
        self.showHud(in: self.view, hint: "加载中...")
        
        var params = NetConnect.getBaseRequestParams()
        params["userId"] = UserHelper.getUserId()!
        params["orderId"] = self.orderId //""获取全部  有的话－筛选
        
        NetworkTools.sharedInstance.repayListDetail(parameters: params, finished: { (response, error) in
            //隐藏HUD
            self.hideHud()
            if let response = response {
                if response.isSuccess(){
                    
                    self.repayList = response.areadyList
                    self.orderNameList = response.orders
                    
                }else {
                    self.showHint(in: self.view, hint: response.RET_DESC)
                }
            }else {
                self.showHint(in: self.view, hint: "网络错误")
            }
        })
    }
    
}
