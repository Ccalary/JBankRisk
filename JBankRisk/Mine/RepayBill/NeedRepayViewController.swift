//
//  NeedRepayViewController.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/12.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//  还款记录（应还总额）

import UIKit
import SnapKit
import SwiftyJSON

class NeedRepayViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate, UIScrollViewDelegate{

    //是否打开了下拉框
    var isTransformed: Bool = false
    var selectViewConstraint: Constraint?
    
    //数据
    var dataArray: [JSON] = [] {
        didSet{
            self.aTableView.reloadData()
        }
    }
    //筛选
    var selectIndex = 1
    
    //分页
    var page: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTitle()
        self.setupUI()
        self.selectViewClick()
        self.requestData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setTitle(){
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 100*UIRate, height: 40))
        
        titleView.addSubview(titleTextLabel)
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
    
    //MARK: - 基本UI
    func setupUI(){
        self.view.backgroundColor = defaultBackgroundColor
        self.navigationController!.navigationBar.isTranslucent = true;
        self.automaticallyAdjustsScrollViewInsets = false;
        
        let aTap = UITapGestureRecognizer(target: self, action: #selector(tapViewAction))
        aTap.numberOfTapsRequired = 1
        aTap.delegate = self
        selectBgView.addGestureRecognizer(aTap)
        
        self.view.addSubview(aTableView)
        
        //刷新
        self.aTableView.addPullRefreshHandler({ [weak self] in
            self?.requestData()
            self?.aTableView.stopPullRefreshEver()
        })
        self.view.addSubview(defaultView)
        self.view.addSubview(selectBgView)
        self.view.addSubview(selectView)
        
        defaultView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(SCREEN_HEIGHT - 64)
            make.centerX.equalTo(self.view)
            make.top.equalTo(64)
        }

        aTableView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(SCREEN_HEIGHT - 64)
            make.centerX.equalTo(self.view)
            make.top.equalTo(64)
        }

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
    }
    
    //缺省页
    private lazy var defaultView: NothingDefaultView = {
        let holdView = NothingDefaultView(viewType: NothingDefaultView.DefaultViewType.nothing)
        holdView.isHidden = true
        return holdView
    }()
    
    //navigationBar图片
    private lazy var titleArrowImgView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "triangle_down_6x6")
        return imageView
    }()
    
    private lazy var titleTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 15*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "全部应还"
        return label
    }()
    
    //／title按钮
    private lazy var titleButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(titleButtonAction), for: .touchUpInside)
        return button
    }()

    private lazy var aTableView: UITableView = {
        
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(RepayDetailTableViewCell.self, forCellReuseIdentifier: "cellID")
        //tableView 单元格分割线的显示
        if tableView.responds(to:#selector(setter: UITableViewCell.separatorInset)) {
            tableView.separatorInset = .zero
        }
        
        if tableView.responds(to: #selector(setter: UITableViewCell.layoutMargins)) {
            tableView.layoutMargins = .zero
        }
        return tableView
        
    }()
    
    //下拉选择View
    private lazy var selectView: NeedRepayTimeView = {
        let selectView = NeedRepayTimeView()
        return selectView
    }()

    //下拉时变暗背景
    private lazy var selectBgView: UIView = {
        let holdView = UIView()
        holdView.alpha = 0
        holdView.backgroundColor = UIColorHex("000000", 0.6)
        return holdView
    }()
    
    //MARK: - UITableView Delegate&&DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //缺省页
        if dataArray.count == 0 {
            self.defaultView.isHidden = false
        }else {
             self.defaultView.isHidden = true
        }
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID") as! RepayDetailTableViewCell

        cell.textColorTheme = .needReDark
        cell.needRepayCellWithData(dic: dataArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50*UIRate
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var monthRepayStatus: RepayStatusType = .finish
        //0-已支付 1-未支付 2-提前支付 3-逾期未支付 4-逾期已支付
        let repayStatus = dataArray[indexPath.row]["is_pay"].stringValue
        if repayStatus == "0" ||  repayStatus == "2" || repayStatus == "4"{
            monthRepayStatus = .finish
        }else { //有逾期
            
        let penaltyDay = dataArray[indexPath.row]["penalty_day"].intValue
                
        if penaltyDay > 0 {
            monthRepayStatus = .overdue
         }else {
            monthRepayStatus = .not
         }
       }

        let repayDetailVC = RepayPeriodDetailVC()
        repayDetailVC.repaymentId = dataArray[indexPath.row]["repayment_id"].stringValue
        repayDetailVC.repayStatusType = monthRepayStatus //还款状态
        self.navigationController?.pushViewController(repayDetailVC, animated: true)
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
        selectView.onClickCell = {[unowned self] (title,index) in
            self.titleTextLabel.text = title
            self.selectIndex = index
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
        params["userId"] = UserHelper.getUserId()
        params["flag"] = selectIndex //1-全部应还 2-本月应还 3-近7日  4-今日
        
        NetConnect.pc_need_repayment_detail(parameters: params, success: { response in
            //隐藏HUD
            self.hideHud()
            let json = JSON(response)
            guard json["RET_CODE"] == "000000" else{
                return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
            }
            
            self.dataArray.removeAll()
            self.dataArray = json["backList"].arrayValue
            
        }, failure:{ error in
            //隐藏HUD
            self.hideHud()
        })
    }
    
    func refreshUI(json: JSON){
       
    }
    
}
