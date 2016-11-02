//
//  ProductViewController.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/1.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit
import SwiftyJSON

class ProductViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,UIGestureRecognizerDelegate {
    
     var ProductCellData:[CellDataInfo] = [ CellDataInfo(leftText: "所属商户", holdText: "商户名称", content: "", cellType: .defaultType),
        CellDataInfo(leftText: "产品名称", holdText: "请输入产品名称", content: "", cellType: .clearType),
        CellDataInfo(leftText: "", holdText: "", content: "", cellType: .defaultType),
        CellDataInfo(leftText: "借款金额", holdText: "可借区间2，000-3，0000", content: "", cellType: .textType),
        CellDataInfo(leftText: "申请期限", holdText: "", content: "", cellType: .arrowType),
        CellDataInfo(leftText: "月还款额", holdText: "", content: "", cellType: .textType),
        CellDataInfo(leftText: "", holdText: "", content: "", cellType: .defaultType),
        CellDataInfo(leftText: "业务员", holdText: "请输入业务员工号", content: "", cellType: .clearType)
    ]
    
    //选择的期限
    var selectPeriodInfo:(cell:Int, text:String) = (0,"")
    //借款金额
    var borrowMoney:String = ""
    //月还款
    var repayment: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    func setupUI(){
        self.navigationController!.navigationBar.isTranslucent = true;
        self.automaticallyAdjustsScrollViewInsets = false;
        self.view.backgroundColor = defaultBackgroundColor
        self.title = "产品信息"
        
        let aTap = UITapGestureRecognizer(target: self, action: #selector(tapViewAction))
        aTap.numberOfTapsRequired = 1
        aTap.delegate = self
        self.navigationController?.navigationBar.addGestureRecognizer(aTap)
        
        self.view.addSubview(aScrollView)
        self.aScrollView.addSubview(aTableView)
        self.aScrollView.addSubview(divideLine1)
        self.view.addSubview(lastStepBtn)
        self.view.addSubview(nextStepBtn)
        
        aScrollView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(SCREEN_HEIGHT - 64 - 64*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(64)
        }
        
        aScrollView.contentSize = CGSize(width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64 - 64*UIRate + 1)
        
        aTableView.snp.makeConstraints { (make) in
            make.width.equalTo(aScrollView)
            make.height.equalTo(320*UIRate)
            make.centerX.equalTo(aScrollView)
            make.top.equalTo(10*UIRate)
        }
        
        divideLine1.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(self.aScrollView)
            make.top.equalTo(aTableView)
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

    private lazy var aScrollView: UIScrollView = {
       let scrollView = UIScrollView()
        return scrollView
    }()
    
    private lazy var aTableView: UITableView = {
        
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.tableFooterView = UIView()
        tableView.register(BMTableViewCell.self, forCellReuseIdentifier: "ProCellID")
        
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
        button.setBackgroundImage(UIImage(named: "btn_grayred_254x44"), for: .normal)
//        button.isUserInteractionEnabled = false
        button.setTitle("下一步", for: UIControlState.normal)
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
        return ProductCellData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProCellID") as! BMTableViewCell
        //去除选择效果
        cell.selectionStyle = .none
        cell.cellDataInfo = ProductCellData[indexPath.row]
        cell.backgroundColor = UIColor.white
        
        switch indexPath.row {
        case 3://借款金额
            cell.centerTextField.keyboardType = .numberPad
            cell.centerTextField.tag = 10000
            cell.centerTextField.addTarget(self, action: #selector(textFieldAction(_:)), for: UIControlEvents.editingChanged)
        case 5:
            cell.centerTextField.text = self.repayment
            cell.centerTextField.isEnabled = false
            
        case 7:
             cell.centerTextField.keyboardType = .numberPad
             cell.centerTextField.tag = 10001
             cell.centerTextField.addTarget(self, action: #selector(textFieldAction(_:)), for: UIControlEvents.editingChanged)
        default:
            break
        }
        
        
        if indexPath.row == 2 || indexPath.row == 6 {
            cell.backgroundColor = defaultBackgroundColor
        }
        
        if indexPath.row == 4 { //期限
            cell.centerTextField.text = selectPeriodInfo.text
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 2 || indexPath.row == 6 {
            return 10*UIRate
        }else {
            return 50*UIRate
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.cellForRow(at: indexPath) as! BMTableViewCell
        if indexPath.row == 4 { //申请期限
            guard self.borrowMoney.characters.count>0 else {
                self.showHint(in: self.view, hint: "请输入借款金额")
                return
            }
            let param = ["para_key":"pay_member"]
            NetConnect.bm_applyPeriod(parameters: param, success: { (response) in
                let json = JSON(response)
                guard json["RET_CODE"] == "000000" else{
                    return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
                }
                if let dataArray = json["terms"].arrayObject {
                    
                    let phoneCallView = PopupDeadlineView(dataArray: dataArray, selectedCell: self.selectPeriodInfo.cell, borrowMoney: self.borrowMoney,mViewController: self)
                    let popupController = CNPPopupController(contents: [phoneCallView])!
                    popupController.present(animated: true)
                    phoneCallView.onClickSure = { (cell,text,moneyRepay) in
                        self.selectPeriodInfo = (cell,text)
                        self.repayment = moneyRepay
                        let position1 = IndexPath(row: 5, section: 0)
                        let position2 = IndexPath(row: 4, section: 0)
                        self.aTableView.reloadRows(at: [position1,position2], with: UITableViewRowAnimation.none)
                        
                        popupController.dismiss(animated: true)
                    }
                    phoneCallView.onClickCancle = { _ in
                        popupController.dismiss(animated: true)
                    }
                }
            
            }, failure: { error in
                
            })
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

    
    ///消除手势与TableView的冲突
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if NSStringFromClass((touch.view?.classForCoder)!) == "UITableViewCellContentView" {
            return false
        }
        return true
    }
    
    //MARK: - Action
    func tapViewAction() {
        self.view.endEditing(true)
    }
    
    
    func lastStepBtnAction(){
        
    }
    
    func nextStepBtnAction(){
        
    }
    
    func textFieldAction(_ textField: UITextField){
        //tag: 10000- 借款金额 10001-业务员编号
        if textField.tag == 10000 {
            //限制输入的长度，最长为9位
            if (textField.text?.characters.count)! > 9{
                let index = textField.text?.index((textField.text?.startIndex)!, offsetBy: 9)//到offsetBy的前一位
                textField.text = textField.text?.substring(to: index!)
            }
            self.borrowMoney = textField.text!
        }else if textField.tag == 10001 {
            //限制输入的长度，最长为8位
            if (textField.text?.characters.count)! > 8{
                let index = textField.text?.index((textField.text?.startIndex)!, offsetBy: 9)//到offsetBy的前一位
                textField.text = textField.text?.substring(to: index!)
            }
        }
    }
}
