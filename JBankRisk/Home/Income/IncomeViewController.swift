//
//  IncomeViewController.swift
//  JBankRisk
//
//  Created by caohouhong on 16/12/23.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit
import SwiftyJSON

class IncomeViewController:  UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    var incomeCellData = UserInfoCellModel(dataType: UserInfoCellModel.CellModelType.income)
    
    weak var uploadSucDelegate:UploadSuccessDelegate?
    
    var incomeAmount = ""//收入
    var incomeWay = "" //收入来源
    var payWayInfo: (row: Int, text: String) = (0,"")//结算方式

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
        if UserHelper.getIncomeIsUpload() {
            self.requestIncomeInfo()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func setupUI(){
        self.navigationController!.navigationBar.isTranslucent = true
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = defaultBackgroundColor
        self.navigationItem.title = "收入信息"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"navigation_left_back_13x21"), style: .plain, target: self, action: #selector(leftNavigationBarBtnAction))
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 10*UIRate))
        headerView.backgroundColor = defaultBackgroundColor
        
        self.view.addSubview(aTableView)
        self.aTableView.tableHeaderView = headerView
        
        headerView.addSubview(divideLine1)
        self.view.addSubview(lastStepBtn)
        self.view.addSubview(nextStepBtn)
        
        aTableView.snp.makeConstraints { (make) in
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(SCREEN_HEIGHT - 64 - 64*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(64)
        }
        
        divideLine1.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(headerView)
        }
        
        lastStepBtn.snp.makeConstraints { (make) in
            make.width.equalTo(85*UIRate)
            make.height.equalTo(44*UIRate)
            make.left.equalTo(15*UIRate)
            make.bottom.equalTo(self.view).offset(-10*UIRate)
        }
        
        lastStepBtn.snp.makeConstraints { (make) in
            make.width.equalTo(85*UIRate)
            make.height.equalTo(44*UIRate)
            make.left.equalTo(15*UIRate)
            make.bottom.equalTo(self.view).offset(-10*UIRate)
        }
        
        nextStepBtn.snp.makeConstraints { (make) in
            make.width.equalTo(254*UIRate)
            make.height.equalTo(44*UIRate)
            make.right.equalTo(self.view).offset(-15*UIRate)
            make.bottom.equalTo(lastStepBtn)
        }
    }
    
    lazy var aTableView: UITableView = {
        
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.tableFooterView = UIView()
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = defaultBackgroundColor
        tableView.register(BMTableViewCell.self, forCellReuseIdentifier: "IncomeCellID")
        
        //tableView 单元格分割线的显示
        if tableView.responds(to:#selector(setter: UITableViewCell.separatorInset)) {
            tableView.separatorInset = .zero
        }
        
        if tableView.responds(to: #selector(setter: UITableViewCell.layoutMargins)) {
            tableView.layoutMargins = .zero
        }
        return tableView
    }()
    
    //分割线
    private lazy var divideLine1: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()
    
    //／按钮
    private lazy var nextStepBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "btn_red_254x44"), for: .normal)
        button.setTitle(UserHelper.getIsReject() ? "保存修改" : "下一步", for: UIControlState.normal)
        button.titleLabel?.font = UIFontBoldSize(size: 18*UIRate)
        button.addTarget(self, action: #selector(nextStepBtnAction), for: .touchUpInside)
        return button
    }()
    
    //／上一步按钮
    private lazy var lastStepBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "btn_red_85x44"), for: .normal)
        button.setTitle("上一步", for: UIControlState.normal)
        button.titleLabel?.font = UIFontBoldSize(size: 18*UIRate)
        button.addTarget(self, action: #selector(lastStepBtnAction), for: .touchUpInside)
        return button
    }()
    
    //MARK: - UITableViewDelegate&&DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return incomeCellData.cellData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IncomeCellID") as! BMTableViewCell
        //去除选择效果
        cell.selectionStyle = .none
        cell.cellDataInfo = incomeCellData.cellData[indexPath.row]
        
        switch indexPath.row {
        case 0://每月收入
            cell.centerTextField.text = self.incomeAmount
            cell.centerTextField.tag = 10000
            cell.centerTextField.keyboardType = .numberPad
            cell.centerTextField.addTarget(self, action: #selector(textFieldAction(_:)), for: UIControlEvents.editingChanged)
            cell.centerTextField.isEnabled = true
        case 1://收入来源
            cell.centerTextField.text = self.incomeWay
            cell.centerTextField.tag = 10001
            cell.centerTextField.addTarget(self, action: #selector(textFieldAction(_:)), for: UIControlEvents.editingChanged)
            cell.centerTextField.isEnabled = true
        case 2:
            cell.centerTextField.isEnabled = false
            cell.centerTextField.text = self.payWayInfo.text
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
        
        if indexPath.row == 2 {//结算方式
            let popupView =  PopupStaticSelectView(cellType: PopupStaticSelectView.PopupCellType.incomePayWay, selectRow: self.payWayInfo.row)
            let popupController = CNPPopupController(contents: [popupView])!
            popupController.present(animated: true)
            
            popupView.onClickSelect = {[unowned self] (row, text) in
                self.payWayInfo = (row,text)
                let position = IndexPath(row: indexPath.row, section: 0)
                self.aTableView.reloadRows(at: [position], with: UITableViewRowAnimation.none)
                popupController.dismiss(animated: true)
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
    
    //MARK: - Method
    //局部刷新cell
    func reloadOneCell(at row: Int){
        let position = IndexPath(row: row, section: 0)
        self.aTableView.reloadRows(at: [position], with: UITableViewRowAnimation.none)
    }
    
    //MARK: - Action
    func textFieldAction(_ textField: UITextField){
        //10000-每月收入
        if textField.tag == 10000{
            //限制输入的长度，最长为8位
            if (textField.text?.characters.count)! > 8{
                let index = textField.text?.index((textField.text?.startIndex)!, offsetBy: 8)//到offsetBy的前一位
                textField.text = textField.text?.substring(to: index!)
            }
            self.incomeAmount = textField.text!
        }else if textField.tag == 10001{
            self.incomeWay = textField.text!
        }
    }
    
    func lastStepBtnAction(){
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    //返回
    func leftNavigationBarBtnAction(){
        for i in 0..<(self.navigationController?.viewControllers.count)! {
            
            if self.navigationController?.viewControllers[i].isKind(of: BorrowMoneyViewController.self) == true {
                
                _ = self.navigationController?.popToViewController(self.navigationController?.viewControllers[i] as! BorrowMoneyViewController, animated: true)
                break
            }
        }
    }
    //下一步
    func nextStepBtnAction(){
        
        //是否已生成订单并且没有被驳回
        guard !(UserHelper.getAllFinishIsUpload() && !UserHelper.getIsReject()) else {
            self.showHint(in: self.view, hint: "订单已生成，信息不可更改哦！")
            return
        }
        
        guard self.incomeAmount.isEmpty == false,
              self.incomeWay.isEmpty == false,
              self.payWayInfo.text.isEmpty == false
              else {
                self.showHint(in: self.view, hint: "请完善信息再上传!")
                return
        }
        
        //添加HUD
        self.showHud(in: self.view, hint: "上传中...")
        var params = NetConnect.getBaseRequestParams()
        params["month_wages"] = self.incomeAmount
        params["income"] = incomeWay
        params["settlement"] = self.payWayInfo.row + 1 //结算方式
        //如果是驳回的则上传orderId
        if UserHelper.getIsReject() {
            params["orderId"] = UserHelper.getHomeNewOneOrderId()
        }
        
        NetConnect.bm_upload_income_info(parameters: params, success:
            { response in
                //隐藏HUD
                self.hideHud()
                let json = JSON(response)
                guard json["RET_CODE"] == "000000" else{
                    return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
                }
                
                UserHelper.setIncome(isUpload: true)
                
                if self.uploadSucDelegate != nil {
                    self.uploadSucDelegate?.upLoadInfoSuccess()
                }
                self.showHintInKeywindow(hint: "收入信息上传完成！",yOffset: SCREEN_HEIGHT/2 - 100*UIRate)
                
                let idVC = ContactViewController()
                self.navigationController?.pushViewController(idVC, animated: true)
                
        }, failure: {error in
            //隐藏HUD
            self.hideHud()
        })
    }
    
    //MARK:请求收入信息
    func requestIncomeInfo(){
        
        //添加HUD
        self.showHud(in: self.view, hint: "加载中...")
        
        var params = ["userId": UserHelper.getUserId()!]
        //如果是驳回的则上传orderId
        if UserHelper.getIsReject() {
            params["orderId"] = UserHelper.getHomeNewOneOrderId()
        }
        NetConnect.bm_upload_income_info(parameters: params, success: { response in
            //隐藏HUD
            self.hideHud()
            let json = JSON(response)
            guard json["RET_CODE"] == "000000" else{
                return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
            }

            self.refreshUI(json: json)
        }, failure:{ error in
            //隐藏HUD
            self.hideHud()
        })
    }
    //填充信息
    func refreshUI(json: JSON){
        self.incomeAmount = json["month_wages"].stringValue
        self.incomeWay = json["income"].stringValue
        let settlement = json["settlement"].intValue - 1
        self.payWayInfo.row = settlement < 0 ? 0 : settlement
        self.payWayInfo.text = incomePayWayData[self.payWayInfo.row]
        self.aTableView.reloadData()
    }
}
