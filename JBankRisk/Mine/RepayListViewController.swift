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

class RepayListViewController: UIViewController,UIGestureRecognizerDelegate,UITableViewDelegate, UITableViewDataSource {
    
    var isHaveData = true
    
    var dataArray: [JSON] = [] {
        didSet{
            self.aTableView.reloadData()
        }
    }
    
    //产品名字
    var nameArray: [JSON] = [] {
        didSet{
            self.selectView.dataArray = nameArray
        }
    }
    
    var orderId = ""
    
    //标题
    var titleText = "" {
        didSet{
            self.titleTextLabel.text = titleText
            self.navTextLabel.text = titleText
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

    func setTitle(){
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 100*UIRate, height: 40))
        
        titleView.addSubview(self.titleTextLabel)
        titleView.addSubview(titleButton)
        titleView.addSubview(titleArrowImgView)

        
        titleTextLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(titleView)
            make.centerY.equalTo(titleView)
        }
        
        titleButton.snp.makeConstraints { (make) in
            make.size.equalTo(titleView)
            make.center.equalTo(titleView)
        }

        titleArrowImgView.snp.makeConstraints { (make) in
            make.width.height.equalTo(6*UIRate)
            make.left.equalTo(titleTextLabel.snp.right).offset(2*UIRate)
            make.centerY.equalTo(titleTextLabel)
        }
        
        self.navigationItem.titleView = titleView
    }

    //Nav
    func setNavUI(){
        self.view.addSubview(navHoldView)
        self.navHoldView.addSubview(navImageView)
        self.navHoldView.addSubview(navTextLabel)
        self.navHoldView.addSubview(navDivideLine)
        
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
    
    func setupUI(){
        self.navigationController!.navigationBar.isTranslucent = true;
        self.automaticallyAdjustsScrollViewInsets = false;
        self.view.backgroundColor = defaultBackgroundColor
        
        if !isHaveData {
            self.setupDefaultUI()
            self.navTextLabel.text = self.title
        }else {
            self.setupUINormalUI()
            self.navTextLabel.text = self.titleTextLabel.text
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
        self.setTitle()
        
        self.view.addSubview(tableHeaderView)
        self.tableHeaderView.addSubview(timeTextLabel)
        self.tableHeaderView.addSubview(naemTextLabel)
        self.tableHeaderView.addSubview(moneyTextLabel)
        self.tableHeaderView.addSubview(divideLine1)
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

        /********/
        
        tableHeaderView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(45*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(64)
        }
        
        timeTextLabel.snp.makeConstraints { (make) in
            make.width.equalTo(SCREEN_WIDTH/3.0)
            make.height.equalTo(45*UIRate)
            make.left.equalTo(0)
            make.centerY.equalTo(tableHeaderView)
        }
        
        naemTextLabel.snp.makeConstraints { (make) in
            make.size.equalTo(timeTextLabel)
            make.left.equalTo(timeTextLabel.snp.right)
            make.centerY.equalTo(tableHeaderView)
        }
        
        moneyTextLabel.snp.makeConstraints { (make) in
            make.size.equalTo(timeTextLabel)
            make.right.equalTo(0)
            make.centerY.equalTo(tableHeaderView)
        }
        
        divideLine1.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(tableHeaderView)
        }
    
        aTableView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(SCREEN_HEIGHT - 64 - 45*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(tableHeaderView.snp.bottom)
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
        label.font = UIFontSize(size: 15*UIRate)
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
    
    /*********/
    //缺省页
    private lazy var defaultView: NothingDefaultView = {
        let holdView = NothingDefaultView(viewType: NothingDefaultView.DefaultViewType.nothing)
        return holdView
    }()
    
    //title
    private lazy var titleTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "全部纪录"
        return label
    }()
    
    //navigationBar图片
    private lazy var titleArrowImgView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "triangle_down_6x6")
        return imageView
    }()
    
    //／title按钮
    private lazy var titleButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(titleButtonAction), for: .touchUpInside)
        return button
    }()
    
    //下拉选择View
    private lazy var selectView: RepayedNameView = {
        let selectView = RepayedNameView()
        return selectView
    }()
    
    //下拉时变暗背景
    private lazy var selectBgView: UIView = {
        let holdView = UIView()
        holdView.alpha = 0
        holdView.backgroundColor = UIColorHex("000000", 0.6)
        return holdView
    }()
    
    private lazy var tableHeaderView: UIView = {
        let holdView = UIView()
        holdView.backgroundColor = UIColor.white
        return holdView
    }()
    
    private lazy var timeTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "时间"
        return label
    }()
    
    private lazy var naemTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "产品名称"
        return label
    }()
    
    private lazy var moneyTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "金额(元)"
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
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID") as! RepayListTableViewCell
        //去除选择效果
        cell.selectionStyle = .none
        cell.cellWithData(dic: dataArray[indexPath.row].dictionary!)
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
        selectView.onClickCell = { (title, nameId) in
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
    
    //头部图片点击
    func titleButtonAction(){
        
        if !isTransformed {
            //打开
            
            UIView.animate(withDuration: 0.6, animations: {
                self.titleArrowImgView.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
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
            self.titleArrowImgView.transform = CGAffineTransform(rotationAngle: CGFloat(0))
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
        
        NetConnect.pc_repay_list_detail(parameters: params, success: { response in
            //隐藏HUD
            self.hideHud()
            let json = JSON(response)
            guard json["RET_CODE"] == "000000" else{
                return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
            }
            
            self.refreshUI(json: json["areadyList"])
            self.refreshNameUI(json: json["OrderInfo"])
            
        }, failure:{ error in
            //隐藏HUD
            self.hideHud()
        })
    }

    
    func refreshUI(json: JSON){
        dataArray = json.arrayValue
    }
    
    func refreshNameUI(json: JSON){
        nameArray = json.arrayValue
    }
    
}
