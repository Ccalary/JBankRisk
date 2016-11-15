//
//  WorkViewController.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/1.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit
import SwiftyJSON

class WorkViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    var WorkCellData:[CellDataInfo] = [CellDataInfo(leftText: "单位名称", holdText: "请输入单位名称", content: "", cellType: .clearType),
        CellDataInfo(leftText: "单位性质", holdText: "请选择单位性质", content: "", cellType: .arrowType),
        CellDataInfo(leftText: "单位电话", holdText: "请填写单位电话", content: "", cellType: .clearType),
        CellDataInfo(leftText: "单位地址", holdText: "请选择所属地区", content: "", cellType: .arrowType),
        CellDataInfo(leftText: "", holdText: "详细街道地址", content: "", cellType: .clearType),
        CellDataInfo(leftText: "职位", holdText: "请填写当前职位", content: "", cellType: .clearType),
        CellDataInfo(leftText: "工作年限", holdText: "请选择工作年限", content: "", cellType: .arrowType),
        CellDataInfo(leftText: "月收入", holdText: "请填写月收入", content: "", cellType: .textType)]
    ///单位名称
    var unitName = ""
    //单位电话
    var unitPhone = ""
    //详细地址
    var areaDetail = ""
    //职位
    var unitPost = ""
    //收入
    var monthWages = ""
    ///单位性质
    var companyTypeInfo:(row: Int, text: String) = (0,"")
    ///工作年限
    var workYearsInfo:(row: Int, text: String) = (0,"")
    //所属地区
    var areaInfo:(pro:String, city:String, county:String) = ("","","")
    var areaRow:(proRow:Int, cityRow:Int, countyRow:Int) = (-1,-1,-1)
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
        self.title = "职业信息"
        
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
            make.height.equalTo(390*UIRate)
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
        tableView.register(BMTableViewCell.self, forCellReuseIdentifier: "WorkCellID")
        
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
        button.setBackgroundImage(UIImage(named: "login_btn_red_345x44"), for: .normal)
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
        return WorkCellData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkCellID") as! BMTableViewCell
        //去除选择效果
        cell.selectionStyle = .none
        cell.cellDataInfo = WorkCellData[indexPath.row]
        
        switch indexPath.row {
        case 0://单位名称
            cell.centerTextField.tag = 10000
            cell.centerTextField.addTarget(self, action: #selector(textFieldAction(_:)), for: UIControlEvents.editingChanged)
        case 1://单位性质
            cell.centerTextField.text = self.companyTypeInfo.text
        case 2://电话
            cell.centerTextField.keyboardType = .numberPad
            cell.centerTextField.tag = 10001
            cell.centerTextField.addTarget(self, action: #selector(textFieldAction(_:)), for: UIControlEvents.editingChanged)
        case 3://地区
            cell.centerTextField.text = self.areaInfo.pro + self.areaInfo.city + self.areaInfo.county
        case 4://详细地址
            cell.centerTextField.tag = 10002
            cell.centerTextField.addTarget(self, action: #selector(textFieldAction(_:)), for: UIControlEvents.editingChanged)
        case 5://职位
            cell.centerTextField.tag = 10003
            cell.centerTextField.addTarget(self, action: #selector(textFieldAction(_:)), for: UIControlEvents.editingChanged)
        case 6://工作年限
            cell.centerTextField.text = self.workYearsInfo.text
        case 7://月收入
            cell.centerTextField.keyboardType = .numberPad
            cell.centerTextField.tag = 10004
            cell.centerTextField.addTarget(self, action: #selector(textFieldAction(_:)), for: UIControlEvents.editingChanged)
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 4 {
            return 40*UIRate
        }else {
            return 50*UIRate
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        self.view.endEditing(true)
        
        if indexPath.row == 1 { //单位性质
            let popupView =  PopupStaticSelectView(cellType: PopupStaticSelectView.PopupCellType.companyType, selectRow: self.companyTypeInfo.row)
            let popupController = CNPPopupController(contents: [popupView])!
            popupController.present(animated: true)
            
            popupView.onClickSelect = { (row, text) in
                self.companyTypeInfo = (row,text)
                //刷新cell
                self.reloadOneCell(at: indexPath.row)
                popupController.dismiss(animated: true)
            }
            
        }else if indexPath.row == 3 {//所选地区
            let popupView = PopupAreaView(proRow: self.areaRow.proRow, cityRow: self.areaRow.cityRow, countyRow: self.areaRow.countyRow)
            let popupController = CNPPopupController(contents: [popupView])!
            popupController.present(animated: true)
            
            popupView.onClickSelect = { (pro,city,county) in
                self.areaInfo = (pro.pro + " ",city.city + " ",county.county)
                self.areaRow = (pro.proRow, city.cityRow, county.countyRow)
                self.reloadOneCell(at: indexPath.row)
                popupController.dismiss(animated: true)
            }
            popupView.onClickClose = { _ in
                 popupController.dismiss(animated: true)
            }
            
        }else if indexPath.row == 6{ //工作年限
            
            let popupView =  PopupStaticSelectView(cellType: PopupStaticSelectView.PopupCellType.year, selectRow: self.workYearsInfo.row)
            let popupController = CNPPopupController(contents: [popupView])!
            popupController.present(animated: true)
            
            popupView.onClickSelect = { (row, text) in
                self.workYearsInfo = (row,text)
                self.reloadOneCell(at: indexPath.row)
                popupController.dismiss(animated: true)
            }
        }
    }
    
    //设置分割线
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 3 {
            
            if cell.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
                cell.separatorInset = UIEdgeInsets(top: 0, left: 100*UIRate, bottom: 0, right: 0)
            }
            if cell.responds(to: #selector(setter: UITableViewCell.layoutMargins)) {
                cell.layoutMargins = UIEdgeInsets(top: 0, left: 100*UIRate, bottom: 0, right: 0)
            }
        }else {
            if cell.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
                cell.separatorInset = .zero
            }
            if cell.responds(to: #selector(setter: UITableViewCell.layoutMargins)) {
                cell.layoutMargins = .zero
            }
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
        //1000-单位名称 10001-电话,10002-详细地址  10003-职位 10004-月收入
        if textField.tag == 10000{
            self.unitName = textField.text!
        }
        if textField.tag == 10001{
            //限制输入的长度，最长为11位
            if (textField.text?.characters.count)! > 11{
                let index = textField.text?.index((textField.text?.startIndex)!, offsetBy: 11)//到offsetBy的前一位
                textField.text = textField.text?.substring(to: index!)
            }
            self.unitPhone = textField.text!
        }else if textField.tag == 10002{
            self.areaDetail = textField.text!
        }else if textField.tag == 10003{
            self.unitPost = textField.text!
        }
        else if textField.tag == 10004{
            //限制输入的长度，最长为8位
            if (textField.text?.characters.count)! > 8{
                let index = textField.text?.index((textField.text?.startIndex)!, offsetBy: 8)//到offsetBy的前一位
                textField.text = textField.text?.substring(to: index!)
            }
            self.monthWages = textField.text!
        }
    }
    
    func lastStepBtnAction(){
        
    }
    
    func nextStepBtnAction(){
        
        guard self.unitName.characters.count > 0,
            self.companyTypeInfo.text.characters.count > 0,
            self.areaInfo.county.characters.count > 0,
            self.unitPhone.characters.count > 0,
            self.areaDetail.characters.count > 0,
            self.unitPost.characters.count > 0,
            self.workYearsInfo.text.characters.count > 0,
            self.monthWages.characters.count > 0
            else {
                self.showHint(in: self.view, hint: "请完善信息再上传!")
                return
        }
        //添加HUD
        self.showHud(in: self.view, hint: "上传中...")
        var params = NetConnect.getBaseRequestParams()
        params["unitName"] = self.unitName
        params["unitPro"] = self.companyTypeInfo.row + 1
        params["unitMobile"] = self.unitPhone
        params["province"] = self.areaInfo.pro.replacingOccurrences(of: " ", with: "") //省(去除空格)
        params["county"] = self.areaInfo.city.replacingOccurrences(of: " ", with: "") //市(去除空格)
        params["area"] = self.areaInfo.county//县
        params["address"] = self.areaDetail //详址
        params["unitPost"] = self.unitPost //职位
        params["workLife"] = self.workYearsInfo.row + 1 //年限
        params["monthWages"] = self.monthWages //收入
        
        NetConnect.bm_upload_work_info(parameters: params, success:
            { response in
                //隐藏HUD
                self.hideHud()
                let json = JSON(response)
                guard json["RET_CODE"] == "000000" else{
                    return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
                }
                
        }, failure: {error in
            //隐藏HUD
            self.hideHud()
        })
    }

}
