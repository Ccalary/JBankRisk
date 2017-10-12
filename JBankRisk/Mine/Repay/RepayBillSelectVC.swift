//
//  RepayBillSelectVC.swift
//  JBankRisk
//
//  Created by caohouhong on 16/12/23.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit
import SwiftyJSON
import SnapKit

private let cellIdentity = "cellID"
class RepayBillSelectVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate{
    
    var isPush = false
    
    //单期还款id
    var periodInfo:(orderId: String, repaymentId: String) = ("","")
    
    private var dataArray:[JSON] = []
    
    private var selectInfo: [Dictionary<String,Any>] = []
    
    //筛选的id
    private var filterOrderId = ""
    //标题
    var titleText = "" {
        didSet{
            self.titleTextLabel.text = titleText
            
        }
    }
    
    //是否打开了下拉框
    var isTransformed: Bool = false
    var selectViewConstraint: Constraint?
    
    //还款总额
    var repayAmount = "0.00" {
        didSet{
          amountLabel.attributedText = changeTextColor(text: "将还款总额：\(repayAmount)元", color: UIColorHex("fb5c57"), range:NSRange(location: 6, length: repayAmount.characters.count))
        }
    }
    
    //全选
    var isSelectAll = false
    
    
    //产品名字
    var nameArray: [JSON] = [] {
        didSet{
            self.selectView.dataArray = nameArray
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //如果是从推送而来
        if isPush {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(leftBarButton))
        }
        
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
        self.requestData()
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

    func setupUI(){
        self.navigationItem.title = "全部账单"
        self.view.backgroundColor = defaultBackgroundColor
        setupNormalUI()
    }
    
    func setupNormalUI(){
        self.setTitle()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "全选", style: UIBarButtonItemStyle.plain, target: self, action: #selector(rightNavigationBarBtnAction))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColorHex("00b2ff")
        
        self.view.addSubview(aTableView)
        self.view.addSubview(bottomHoldView)
        self.bottomHoldView.addSubview(amountLabel)
        self.bottomHoldView.addSubview(nextStepBtn)
        
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
        selectView.titleText = "全部账单"
        self.selectViewClick()
    
        /******************/
        aTableView.snp.makeConstraints { (make) in
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(515*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view)
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
    
//    func setupDefaultUI(){
//        self.view.addSubview(defaultView)
//        defaultView.snp.makeConstraints { (make) in
//            make.width.equalTo(self.view)
//            make.height.equalTo(SCREEN_HEIGHT - 64)
//            make.centerX.equalTo(self.view)
//            make.top.equalTo(64)
//        }
//        
//        //去申请回调
//        defaultView.onClickApplyAction = {[unowned self] _ in
//            if UserHelper.getUserRole() == nil {
//                UserHelper.setUserRole(role: "白领")
//            }
//            let borrowMoneyVC = BorrowMoneyViewController()
//            borrowMoneyVC.currentIndex = 0
//            self.navigationController?.pushViewController(borrowMoneyVC, animated: false)
//        }
//    }
    
    //选择框
    //title
    private lazy var titleTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 18)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        label.text = "全部账单"
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
    private lazy var selectView: RepayedSelectNameView = {
        let selectView = RepayedSelectNameView()
        selectView.titleText = "全部账单"
        return selectView
    }()

    //下拉时变暗背景
    private lazy var selectBgView: UIView = {
        let holdView = UIView()
        holdView.alpha = 0
        holdView.backgroundColor = UIColorHex("000000", 0.6)
        return holdView
    }()
    
    //还款账单缺省页
    private lazy var defaultView: BorrowDefaultView = {
        let holdView = BorrowDefaultView(viewType: BorrowDefaultView.BorrowDefaultViewType.repayBill)
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
        label.text = "将还款总额：0.00元"
        label.attributedText = changeTextColor(text: "将还款总额：0.00元", color: UIColorHex("fb5c57"), range:NSRange(location: 6, length: 4))
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
         tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
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
        
        if dataArray[indexPath.row]["selected"] == 1 {
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
        
        if dataArray[indexPath.row]["selected"] == 1{
            dataArray[indexPath.row]["selected"] = 0
        }else {
            dataArray[indexPath.row]["selected"] = 1
        }
        self.aTableView.reloadData()
        //计算钱数
        self.calculateRepayAmount()
    }
    
    //MARK: Action
    func rightNavigationBarBtnAction(){
        
        if isSelectAll { //取消选中
            self.navigationItem.rightBarButtonItem?.title = "全选"
            isSelectAll = !isSelectAll
            
            for i in 0..<dataArray.count {
                dataArray[i]["selected"] = 0
            }
        }else { //选中
            self.navigationItem.rightBarButtonItem?.title = "取消"
            isSelectAll = !isSelectAll
            
            for i in 0..<dataArray.count {
                dataArray[i]["selected"] = 1
            }
        }
        
        self.aTableView.reloadData()
        //计算钱数
        self.calculateRepayAmount()
    }
    
    //MARK: 确认
    func nextStepBtnAction(){
        
        //选中的
        let selectInfotemp = dataArray.filter({ (json) -> Bool in
            return json["selected"] == 1
        })
        
        guard selectInfotemp.count > 0 else {
            self.showHint(in: self.view, hint: "请选择还款账单")
            return
        }
        //未选的
        let unselectInfoTemp = dataArray.filter({ (json) -> Bool in
            return json["selected"] != 1
        })
        
        for i in 0..<selectInfotemp.count{
            
            for j in 0..<nameArray.count{
                
                if selectInfotemp[i]["orderId"] == nameArray[j]["orderId"] {
                    if nameArray[j]["pay_flag"].intValue == 1 {
                        self.showHint(in: self.view, hint: "有结算申请中账单，取消后可还款")
                        return
                    }
                }
            }
            
            for j in 0..<unselectInfoTemp.count {
                //是同一个单号进行比较
                if selectInfotemp[i]["orderId"] == unselectInfoTemp[j]["orderId"]{
                    if selectInfotemp[i]["term"].intValue > unselectInfoTemp[j]["term"].intValue {
                        self.showHint(in: self.view, hint: "请按产品期数顺序依次还款")
                        return
                    }
                }
            }
        }
        
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
        //还款方式， 0 正常还款 1七日内还款 2账单清算
        repayVC.flag = 0
       self.navigationController?.pushViewController(repayVC, animated: true)
    }
    
    //MARK: 计算还款总额
    func calculateRepayAmount(){
        let selectInfotemp = dataArray.filter({ (json) -> Bool in
            return json["selected"] == 1
        })
        var money = 0.00
        for i in 0..<selectInfotemp.count {
            money += selectInfotemp[i]["showMoney"].doubleValue
        }
        repayAmount = toolsChangeMoneyStyle(amount: money)
    }
    
    //MARK: 消除手势与TableView的冲突
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
            self.filterOrderId = nameId
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
                self.titleArrowImgView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
                self.selectViewConstraint?.update(offset: 0)
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

    /********如果是从推送而来*******/
    func leftBarButton(){
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - 请求数据
    func requestData(){
        //添加HUD
        self.showHud(in: self.view, hint: "加载中...")
        
        var params = NetConnect.getBaseRequestParams()
        params["flag"] = 1 //1-全部应还 2-本月应还 3-近7日  4-今日
        //如果payOrderId 有值这是有清算账单
        params["orderId"] = filterOrderId
        
        NetConnect.pc_need_repayment_detail(parameters: params, success: { response in
            //隐藏HUD
            self.hideHud()
            let json = JSON(response)
            guard json["RET_CODE"] == "000000" else{
                return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
            }
            
            self.dataArray.removeAll()
            self.repayAmount = "0.00"
            self.dataArray = json["backList"].arrayValue
            self.nameArray = json["orderInfoList"].arrayValue
            
            //设置是否选中
            for i in 0..<self.dataArray.count {
                
                //如果一单还款的ID和存在的ID相同，则默认选中
                if self.periodInfo.repaymentId == self.dataArray[i]["repayment_id"].stringValue{
                    self.dataArray[i]["selected"] = 1
                    self.repayAmount = toolsChangeMoneyStyle(amount: self.dataArray[i]["showMoney"].doubleValue)
                }else {
                     self.dataArray[i]["selected"] = 0
                }
            }
            
            self.aTableView.reloadData()
            
        }, failure:{ error in
            //隐藏HUD
            self.hideHud()
        })
    }
}
