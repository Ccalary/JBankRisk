//
//  ContactViewController.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/1.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit
import ContactsUI
import SwiftyJSON

class ContactViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,CNContactPickerDelegate {
    
    var ContactCellData:[CellDataInfo] = [CellDataInfo(leftText: "常住地址", holdText: "请选择所属地区", content: "", cellType: .arrowType),
        CellDataInfo(leftText: "", holdText: "详细街道地址", content: "", cellType: .clearType),
        CellDataInfo(leftText: "住房情况", holdText: "请选择住房情况", content: "", cellType: .arrowType),
        CellDataInfo(leftText: "居住时间", holdText: "请选择居住时间", content: "", cellType: .arrowType),
        CellDataInfo(leftText: "直系亲属", holdText: "请选择直系亲属关系", content: "", cellType: .arrowType),
        CellDataInfo(leftText: "", holdText: "联系人姓名，可从通讯录中选择", content: "", cellType: .arrowType),
        CellDataInfo(leftText: "", holdText: "请填写手机号", content: "", cellType: .clearType),
        CellDataInfo(leftText: "", holdText: "", content: "", cellType: .defaultType),
        CellDataInfo(leftText: "紧急联系人", holdText: "可从通讯录中选择", content: "", cellType: .arrowType),
        CellDataInfo(leftText: "", holdText: "填写姓名", content: "", cellType: .clearType),
        CellDataInfo(leftText: "", holdText: "填写手机号码", content: "", cellType: .clearType)]
    
    var uploadSucDelegate:UploadSuccessDelegate?
    
    var pickerVC:CNContactPickerViewController!
    
    //地区信息
    var areaInfo:(pro:String, city:String, county:String) = ("","","")
    var areaRow:(proRow:Int, cityRow:Int, countyRow:Int) = (-1,-1,-1)
    
    //详细地址
    var areaDetail = ""
    //月供
    var monthRent = ""
    ///住房情况
    var houseInfo:(row: Int, text: String) = (0,"")
    ///居住时间
    var liveTimeInfo:(row: Int, text: String) = (0,"")
    ///亲属关系
    var relativeInfo:(row: Int, text: String) = (0,"")
    ///直系亲属联系信息
    var relativeContactInfo: (name: String, number:String) = ("","")
    ///紧急联系人信息
    var urgentContactInfo: (name: String, number:String) = ("","")
    var contactType:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        //访问通讯录
        pickerVC = CNContactPickerViewController()
        pickerVC.delegate = self
        
        if UserHelper.getContactIsUpload() {
            self.requestContactInfo()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func setupUI(){
        self.navigationController!.navigationBar.isTranslucent = true;
        self.automaticallyAdjustsScrollViewInsets = false;
        self.view.backgroundColor = defaultBackgroundColor
        self.title = "联系信息"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"navigation_left_back_13x21"), style: .plain, target: self, action: #selector(leftNavigationBarBtnAction))
        
        self.view.frame = CGRect(x: 0, y: 64, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64 - 64*UIRate)
        
        
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
            make.height.equalTo(510*UIRate)
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
        tableView.backgroundColor = defaultBackgroundColor
        tableView.register(BMTableViewCell.self, forCellReuseIdentifier: "ContactCellID")
        
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
        return ContactCellData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCellID") as! BMTableViewCell
        //去除选择效果
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.white
        cell.cellDataInfo = ContactCellData[indexPath.row]
        
        switch indexPath.row {
        case 0://地区
            cell.centerTextField.text = self.areaInfo.pro + self.areaInfo.city + self.areaInfo.county
            cell.centerTextField.isEnabled = false
        case 1://详细地址
            cell.centerTextField.text = self.areaDetail
            cell.centerTextField.tag = 10000
            cell.centerTextField.addTarget(self, action: #selector(textFieldAction(_:)), for: UIControlEvents.editingChanged)
            cell.centerTextField.isEnabled = true
        case 2://住房情况
            cell.centerTextField.text = self.houseInfo.text
            cell.centerTextField.isEnabled = false
        case self.ContactCellData.count - 9://（若有）月供
            cell.centerTextField.text = self.monthRent
            cell.centerTextField.keyboardType = .numberPad
            cell.centerTextField.tag = 10001
            cell.centerTextField.addTarget(self, action: #selector(textFieldAction(_:)), for: UIControlEvents.editingChanged)
            cell.centerTextField.isEnabled = true
        case self.ContactCellData.count - 8://居住时间
            cell.centerTextField.isEnabled = false
            cell.centerTextField.text = self.liveTimeInfo.text
        case self.ContactCellData.count - 7: //亲属关系
            cell.centerTextField.isEnabled = false
            cell.centerTextField.text = self.relativeInfo.text
        case self.ContactCellData.count - 6: //亲属姓名
            cell.centerTextField.isEnabled = true
            cell.centerTextField.text = self.relativeContactInfo.name
            cell.centerTextField.keyboardType = .default
            cell.centerTextField.tag = 10002
            cell.centerTextField.addTarget(self, action: #selector(textFieldAction(_:)), for: UIControlEvents.editingChanged)
        case self.ContactCellData.count - 5: //亲属电话
            cell.centerTextField.isEnabled = true
            cell.centerTextField.text = self.relativeContactInfo.number
            cell.centerTextField.keyboardType = .numberPad
            cell.centerTextField.tag = 10003
            cell.centerTextField.addTarget(self, action: #selector(textFieldAction(_:)), for: UIControlEvents.editingChanged)
        case self.ContactCellData.count - 2: //紧急联系人姓名
            cell.centerTextField.isEnabled = true
            cell.centerTextField.text = self.urgentContactInfo.name
            cell.centerTextField.keyboardType = .default
            cell.centerTextField.tag = 10004
            cell.centerTextField.addTarget(self, action: #selector(textFieldAction(_:)), for: UIControlEvents.editingChanged)
        case self.ContactCellData.count - 1: //紧急联系人电话
            cell.centerTextField.isEnabled = true
            cell.centerTextField.text = self.urgentContactInfo.number
            cell.centerTextField.keyboardType = .numberPad
            cell.centerTextField.tag = 10005
            cell.centerTextField.addTarget(self, action: #selector(textFieldAction(_:)), for: UIControlEvents.editingChanged)
        default:
            break
        }
        
        if indexPath.row == ContactCellData.count - 4 {
            cell.backgroundColor = defaultBackgroundColor
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let row = indexPath.row
        let count = ContactCellData.count - 1
        
        if row == 1 || row == count || row == count-1 || row == count-4 || row == count-5 {
            return 40*UIRate
        }else if row == count - 3{
            return 10*UIRate
        }else {
            return 50*UIRate
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.view.endEditing(true)
        
        if indexPath.row == 0 {//选择地区
            let popupView = PopupAreaView(proRow: self.areaRow.proRow, cityRow: self.areaRow.cityRow, countyRow: self.areaRow.countyRow)
            let popupController = CNPPopupController(contents: [popupView])!
            popupController.present(animated: true)
            
            popupView.onClickSelect = { (pro,city,county) in
                self.areaInfo = (pro.pro + " ",city.city + " ",county.county)
                self.areaRow = (pro.proRow, city.cityRow, county.countyRow)
                //局部刷新cell
                self.reloadOneCell(at: indexPath.row)
                popupController.dismiss(animated: true)
            }
            popupView.onClickClose = { _ in
                popupController.dismiss(animated: true)
            }
        }
        
        if indexPath.row == 2 {//住房情况（有按揭多出一个cell显示月供）
            let popupView = PopupStaticSelectView(cellType: .house, selectRow: self.houseInfo.row)
            let popupController = CNPPopupController(contents: [popupView])!
            popupController.present(animated: true)
            popupView.onClickSelect = { (row, text) in
                self.houseInfo = (row,text)
                if row == 0 || row == 2 || row == 5 {
                    if self.ContactCellData.count == 11 {
                        self.ContactCellData.insert( CellDataInfo(leftText: "房租月供", holdText: "请填写每月供款金额", content: "", cellType: .textType), at: 3)
                       }
                    }else {
                        if self.ContactCellData.count == 12 {
                             self.ContactCellData.remove(at: 3)
                        }
                  }
                 self.aTableView.reloadData()
                 popupController.dismiss(animated: true)
            }
            
        }else if indexPath.row == self.ContactCellData.count - 8 { //居住时间
            let popupView =  PopupStaticSelectView(cellType: PopupStaticSelectView.PopupCellType.liveTime, selectRow: self.liveTimeInfo.row)
            let popupController = CNPPopupController(contents: [popupView])!
            popupController.present(animated: true)
            
            popupView.onClickSelect = { (row, text) in
                self.liveTimeInfo = (row,text)
                //局部刷新cell
                self.reloadOneCell(at: indexPath.row)
                popupController.dismiss(animated: true)
            }
        } else if indexPath.row == self.ContactCellData.count - 7 { //直系亲属关系
            let popupView =  PopupStaticSelectView(cellType: PopupStaticSelectView.PopupCellType.relative, selectRow: self.relativeInfo.row)
            let popupController = CNPPopupController(contents: [popupView])!
            popupController.present(animated: true)
            
            popupView.onClickSelect = { (row, text) in
                self.relativeInfo = (row,text)
                //局部刷新cell
                self.reloadOneCell(at: indexPath.row)
                popupController.dismiss(animated: true)
            }
        }else if indexPath.row == self.ContactCellData.count - 6 { //亲属联系人姓名
            contactType = 0
            self.present(pickerVC, animated: true, completion: nil)
        }else if indexPath.row == self.ContactCellData.count - 3 { //紧急联系人姓名
            contactType = 1
            self.present(pickerVC, animated: true, completion: nil)
        }
    }
    
    //设置分割线
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let row = indexPath.row
        let count = ContactCellData.count - 1
        
        if (row == 0 || row == count-1 || row == count-2 || row == count-5 || row == count-6){
            
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
    
    //MARK: - 访问通讯录
    //代理方法--可获得姓名，电话，邮箱等信息
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        var phoneNum = ""
        for i in contact.phoneNumbers {
             let numStr = i.value.stringValue //电话号码
             phoneNum = numStr.replacingOccurrences(of: "-", with: "")
             phoneNum = phoneNum.replacingOccurrences(of: " ", with: "")
        }
        if contactType == 0{
             self.relativeContactInfo = ((contact.familyName + contact.givenName),phoneNum)
        }else if contactType == 1{
            self.urgentContactInfo = ((contact.familyName + contact.givenName),phoneNum)
        }
        //刷新
        self.aTableView.reloadData()
    }
    
    //MARK: - Method
    //局部刷新cell
    func reloadOneCell(at row: Int){
        let position = IndexPath(row: row, section: 0)
        self.aTableView.reloadRows(at: [position], with: UITableViewRowAnimation.none)
    }
    
    //MARK: - Action

    func textFieldAction(_ textField: UITextField){
        // 10000-详细地址 10001-月供 10002-亲属名 10003-电话 10004-紧急名 10005-电话
        if textField.tag == 10000{
            self.areaDetail = textField.text!
        }else if textField.tag == 10001{
            self.monthRent = textField.text!
        }else if textField.tag == 10002{
            self.relativeContactInfo.name = textField.text!
        }else if textField.tag == 10003{
            //限制输入的长度，最长为11位
            if (textField.text?.characters.count)! > 11{
                let index = textField.text?.index((textField.text?.startIndex)!, offsetBy: 11)//到offsetBy的前一位
                textField.text = textField.text?.substring(to: index!)
            }
            self.relativeContactInfo.number = textField.text!
        }else if textField.tag == 10004{
            self.urgentContactInfo.name = textField.text!
        }else if textField.tag == 10005{
            //限制输入的长度，最长为11位
            if (textField.text?.characters.count)! > 11{
                let index = textField.text?.index((textField.text?.startIndex)!, offsetBy: 11)//到offsetBy的前一位
                textField.text = textField.text?.substring(to: index!)
            }
            self.urgentContactInfo.number = textField.text!
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
        //是否已生成订单
        guard !UserHelper.getAllFinishIsUpload() else {
            self.showHint(in: self.view, hint: "订单已生成，信息不可更改哦！")
            return
        }
        
        guard self.self.areaInfo.county.characters.count > 0,
            self.areaDetail.characters.count > 0,
            self.houseInfo.text.characters.count > 0,
            self.liveTimeInfo.text.characters.count > 0,
            self.relativeInfo.text.characters.count > 0,
            self.relativeContactInfo.name.characters.count > 0,
            self.relativeContactInfo.number.characters.count > 0,
            self.urgentContactInfo.name.characters.count > 0,
            self.urgentContactInfo.number.characters.count > 0
            else {
                self.showHint(in: self.view, hint: "请完善信息再上传!")
                return
        }
        
        //添加HUD
        self.showHud(in: self.view, hint: "上传中...")
        var params = NetConnect.getBaseRequestParams()
        params["companyType"] = "11" //固定
        params["role_auth"] = 999 //固定
        params["province"] = self.areaInfo.pro.replacingOccurrences(of: " ", with: "") //省(去除空格)
        params["county"] = self.areaInfo.city.replacingOccurrences(of: " ", with: "") //市(去除空格)
        params["area"] = self.areaInfo.county//县
        params["address"] = self.areaDetail //详细地址
        params["isHouse"] = self.houseInfo.row + 1 //住房情况
        params["forTheMonth"] = self.monthRent
        params["residenceTime"] = self.liveTimeInfo.text //居住时间
        params["contactsType1"] = "1"//固定
        params["contactsType2"] = "2"
        params["relation1"] = self.relativeInfo.row + 1//亲属关系
        params["name1"] = self.relativeContactInfo.name //直系姓名
        params["mobile1"] = self.relativeContactInfo.number //直系电话
        params["relation2"] = "4"//紧急联系人关系
        params["name2"] = self.urgentContactInfo.name
        params["mobile2"] = self.urgentContactInfo.number
        
        NetConnect.bm_upload_contact_info(parameters: params, success:
            { response in
                //隐藏HUD
                self.hideHud()
                let json = JSON(response)
                guard json["RET_CODE"] == "000000" else{
                    return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
                }
                
                UserHelper.setContact(isUpload: true)
                
                if self.uploadSucDelegate != nil {
                    self.uploadSucDelegate?.upLoadInfoSuccess()
                }
                self.showHintInKeywindow(hint: "联系信息上传完成！",yOffset: SCREEN_HEIGHT/2 - 100*UIRate)
                
                self.pushToNextVC()
                
        }, failure: {error in
            //隐藏HUD
            self.hideHud()
        })
    }
    
    func pushToNextVC(){
        let roleType = RoleType(rawValue: UserHelper.getUserRole()!)!
        let idVC = DataViewController(roleType: roleType)
        self.navigationController?.pushViewController(idVC, animated: true)
    }
    
    //MARK:请求联系人信息
    func requestContactInfo(){
        
        //添加HUD
        self.showHud(in: self.view, hint: "加载中...")
        
        let params = ["userId": UserHelper.getUserId()!]
        
        NetConnect.bm_get_contact_info(parameters: params, success: { response in
            //隐藏HUD
            self.hideHud()
            let json = JSON(response)
            guard json["RET_CODE"] == "000000" else{
                return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
            }
            
            self.refreshUI(json: json["ContractAddr"], contact: json["contacts"])
            
        }, failure:{ error in
            //隐藏HUD
            self.hideHud()
        })
    }
    //填充信息
    func refreshUI(json: JSON, contact: JSON){
        self.areaInfo.pro = json["province"].stringValue + " "
        self.areaInfo.city = json["county"].stringValue + " "
        self.areaInfo.county = json["AREA"].stringValue
        self.areaDetail = json["address"].stringValue
        self.houseInfo.row = json["is_house"].intValue - 1
        self.houseInfo.text = houseData[self.houseInfo.row]
        self.monthRent = json["forTheMonth"].stringValue
        self.liveTimeInfo.text = json["residenceTime"].stringValue
        
        self.relativeInfo.row = contact[0]["relation"].intValue - 1
        self.relativeInfo.text = relativeData[self.relativeInfo.row]
        self.relativeContactInfo.name = contact[0]["NAME"].stringValue
        self.relativeContactInfo.number = contact[0]["mobile"].stringValue
        
        self.urgentContactInfo.name = contact[1]["NAME"].stringValue
        self.urgentContactInfo.number = contact[1]["mobile"].stringValue
        
        //如果有月租则显示
        if self.houseInfo.row == 0 || self.houseInfo.row == 2 || self.houseInfo.row == 5 {
         self.ContactCellData.insert( CellDataInfo(leftText: "房租月供", holdText: "请填写每月供款金额", content: self.monthRent, cellType: .textType), at: 3)
        }
        self.aTableView.reloadData()
    }
}
