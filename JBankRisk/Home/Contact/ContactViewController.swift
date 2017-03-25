//
//  ContactViewController.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/1.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit
import SwiftyJSON
import AddressBookUI
import ContactsUI //iOS 9.0以上可用
import Contacts
import AddressBook

class ContactViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,ABPeoplePickerNavigationControllerDelegate,CNContactPickerDelegate {
    
    var contactCellData = UserInfoCellModel(dataType: UserInfoCellModel.CellModelType.contact)
    
    weak var uploadSucDelegate:UploadSuccessDelegate?
    
    //常住地址
    var homeInfo:(pro:String, city:String, county:String) = ("","","")
    var homeRow:(proRow:Int, cityRow:Int, countyRow:Int) = (-1,-1,-1)
    
    //详细地址
    var homeDetail = ""
    
    //地区信息
    var areaInfo:(pro:String, city:String, county:String) = ("","","")
    var areaRow:(proRow:Int, cityRow:Int, countyRow:Int) = (-1,-1,-1)
    
    //详细地址
    var areaDetail = ""
    //月供
    var monthRent = ""
    ///住房情况
    var houseInfo: (row: Int, text: String) = (0,"")
    ///居住时间
    var liveTimeInfo: (row: Int, text: String) = (0,"")
    ///婚姻状况
    var marryInfo: (row: Int, text: String) = (0,"")
    ///亲属关系
    var relativeInfo: (row: Int, text: String) = (0,"")
    ///直系亲属联系信息
    var relativeContactInfo: (name: String, number:String) = ("","")
    ///紧急联系人信息
    ///紧急关系
    var linkmanInfo: (row: Int, text: String) = (0,"")
    
    var urgentContactInfo: (name: String, number:String) = ("","")
    var contactType:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        homeDetail = UserHelper.getUserHomeAddress() ?? ""
        
        self.setupUI()
        
        //如果通讯录没有上传过则进行上传
        if !UserHelper.getContactListIsUpload() {
             self.uploadUserContact()
        }
       
        if UserHelper.getContactIsUpload() {
            self.requestContactInfo()
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupUI(){
        self.navigationController!.navigationBar.isTranslucent = true
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = defaultBackgroundColor
        self.navigationItem.title = "联系信息"
        
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
        
        nextStepBtn.snp.makeConstraints { (make) in
            make.width.equalTo(254*UIRate)
            make.height.equalTo(44*UIRate)
            make.right.equalTo(self.view).offset(-15*UIRate)
            make.bottom.equalTo(lastStepBtn)
        }
    }
    
    private lazy var aTableView: UITableView = {
        
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = defaultBackgroundColor
        tableView.showsVerticalScrollIndicator = false
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
        button.setTitle( UserHelper.getIsReject() ? "保存修改" : "下一步", for: UIControlState.normal)
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
        return contactCellData.cellData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCellID") as! BMTableViewCell
        //去除选择效果
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.white
        cell.cellDataInfo = contactCellData.cellData[indexPath.row]
        
        switch indexPath.row {
        case 0://家庭地址
            cell.centerTextField.text = self.homeInfo.pro + self.homeInfo.city + self.homeInfo.county
            cell.centerTextField.isEnabled = false
        case 1://家庭详细地址
            cell.centerTextField.text = self.homeDetail
            cell.centerTextField.tag = 20000
            cell.centerTextField.addTarget(self, action: #selector(textFieldAction(_:)), for: UIControlEvents.editingChanged)
            cell.centerTextField.isEnabled = true
        case 2://常住地区
            cell.centerTextField.text = self.areaInfo.pro + self.areaInfo.city + self.areaInfo.county
            cell.centerTextField.isEnabled = false
        case 3://详细地址
            cell.centerTextField.text = self.areaDetail
            cell.centerTextField.tag = 10000
            cell.centerTextField.addTarget(self, action: #selector(textFieldAction(_:)), for: UIControlEvents.editingChanged)
            cell.centerTextField.isEnabled = true
        case 4://住房情况
            cell.centerTextField.text = self.houseInfo.text
            cell.centerTextField.isEnabled = false
        case self.contactCellData.cellData.count - 10://（若有）月供
            cell.centerTextField.text = self.monthRent
            cell.centerTextField.keyboardType = .numberPad
            cell.centerTextField.tag = 10001
            cell.centerTextField.addTarget(self, action: #selector(textFieldAction(_:)), for: UIControlEvents.editingChanged)
            cell.centerTextField.isEnabled = true
        case self.contactCellData.cellData.count - 9://居住时间
            cell.centerTextField.isEnabled = false
            cell.centerTextField.text = self.liveTimeInfo.text
        case self.contactCellData.cellData.count - 8://婚姻状况
            cell.centerTextField.isEnabled = false
            cell.centerTextField.text = self.marryInfo.text
        case self.contactCellData.cellData.count - 7: //亲属关系
            cell.centerTextField.isEnabled = false
            cell.centerTextField.text = self.relativeInfo.text
        case self.contactCellData.cellData.count - 6: //亲属姓名
            cell.centerTextField.isEnabled = true
            cell.centerTextField.text = self.relativeContactInfo.name
            cell.centerTextField.keyboardType = .default
            cell.centerTextField.tag = 10002
            cell.centerTextField.addTarget(self, action: #selector(textFieldAction(_:)), for: UIControlEvents.editingChanged)
        case self.contactCellData.cellData.count - 5: //亲属电话
            cell.centerTextField.isEnabled = true
            cell.centerTextField.text = self.relativeContactInfo.number
            cell.centerTextField.keyboardType = .numberPad
            cell.centerTextField.tag = 10003
            cell.centerTextField.addTarget(self, action: #selector(textFieldAction(_:)), for: UIControlEvents.editingChanged)
        case self.contactCellData.cellData.count - 3: //联系人关系
            cell.centerTextField.isEnabled = false
            cell.centerTextField.text = self.linkmanInfo.text
        case self.contactCellData.cellData.count - 2: //紧急联系人姓名
            cell.centerTextField.isEnabled = true
            cell.centerTextField.text = self.urgentContactInfo.name
            cell.centerTextField.keyboardType = .default
            cell.centerTextField.tag = 10004
            cell.centerTextField.addTarget(self, action: #selector(textFieldAction(_:)), for: UIControlEvents.editingChanged)
        case self.contactCellData.cellData.count - 1: //紧急联系人电话
            cell.centerTextField.isEnabled = true
            cell.centerTextField.text = self.urgentContactInfo.number
            cell.centerTextField.keyboardType = .numberPad
            cell.centerTextField.tag = 10005
            cell.centerTextField.addTarget(self, action: #selector(textFieldAction(_:)), for: UIControlEvents.editingChanged)
        default:
            break
        }
        
        if indexPath.row == contactCellData.cellData.count - 4 {
            cell.backgroundColor = defaultBackgroundColor
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let row = indexPath.row
        let count = contactCellData.cellData.count - 1
        
        if row == 1 || row == 3 || row == count || row == count-1 || row == count-4 || row == count-5 {
            return 40*UIRate
        }else if row == count - 3{
            return 10*UIRate
        }else {
            return 50*UIRate
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.view.endEditing(true)
        
        switch indexPath.row {
        case 0://家庭地址
            let popupView = PopupAreaView(proRow: self.homeRow.proRow, cityRow: self.homeRow.cityRow, countyRow: self.homeRow.countyRow)
            let popupController = CNPPopupController(contents: [popupView])!
            popupController.present(animated: true)
            
            popupView.onClickSelect = {[unowned self] (pro,city,county) in
                self.homeInfo = (pro.pro + " ",city.city + " ",county.county)
                self.homeRow = (pro.proRow, city.cityRow, county.countyRow)
                //局部刷新cell
                self.reloadOneCell(at: indexPath.row)
                popupController.dismiss(animated: true)
            }
            popupView.onClickClose = { _ in
                popupController.dismiss(animated: true)
            }
        case 2://选择地区
            let popupView = PopupAreaView(proRow: self.areaRow.proRow, cityRow: self.areaRow.cityRow, countyRow: self.areaRow.countyRow)
            let popupController = CNPPopupController(contents: [popupView])!
            popupController.present(animated: true)
            
            popupView.onClickSelect = {[unowned self] (pro,city,county) in
                self.areaInfo = (pro.pro + " ",city.city + " ",county.county)
                self.areaRow = (pro.proRow, city.cityRow, county.countyRow)
                //局部刷新cell
                self.reloadOneCell(at: indexPath.row)
                popupController.dismiss(animated: true)
            }
            popupView.onClickClose = { _ in
                popupController.dismiss(animated: true)
            }
        case 4://住房情况（有按揭多出一个cell显示月供）
            let popupView = PopupStaticSelectView(cellType: .house, selectRow: self.houseInfo.row)
            let popupController = CNPPopupController(contents: [popupView])!
            popupController.present(animated: true)
            popupView.onClickSelect = {[unowned self] (row, text) in
                self.houseInfo = (row,text)
                if row == 0 || row == 2 || row == 5 {
                    if self.contactCellData.cellData.count == 14 {
                        self.contactCellData.cellData.insert( CellDataInfo(leftText: "房租月供", holdText: "请填写每月供款金额", content: "", cellType: .textType), at: 5)
                    }
                }else {
                    if self.contactCellData.cellData.count == 15 {
                        self.contactCellData.cellData.remove(at: 5)
                    }
                }
                self.aTableView.reloadData()
                popupController.dismiss(animated: true)
            }
        case self.contactCellData.cellData.count - 9://居住时间
            let popupView =  PopupStaticSelectView(cellType: PopupStaticSelectView.PopupCellType.liveTime, selectRow: self.liveTimeInfo.row)
            let popupController = CNPPopupController(contents: [popupView])!
            popupController.present(animated: true)
            
            popupView.onClickSelect = {[unowned self] (row, text) in
                self.liveTimeInfo = (row,text)
                //局部刷新cell
                self.reloadOneCell(at: indexPath.row)
                popupController.dismiss(animated: true)
            }
        case self.contactCellData.cellData.count - 8://婚姻状况
            let popupView =  PopupStaticSelectView(cellType: PopupStaticSelectView.PopupCellType.marry, selectRow: self.marryInfo.row)
            let popupController = CNPPopupController(contents: [popupView])!
            popupController.present(animated: true)
            
            popupView.onClickSelect = {[unowned self] (row, text) in
                self.marryInfo = (row,text)
                //局部刷新cell
                self.reloadOneCell(at: indexPath.row)
                popupController.dismiss(animated: true)
            }
        case self.contactCellData.cellData.count - 7://直系亲属关系
            let popupView =  PopupStaticSelectView(cellType: PopupStaticSelectView.PopupCellType.relative, selectRow: self.relativeInfo.row)
            let popupController = CNPPopupController(contents: [popupView])!
            popupController.present(animated: true)
            
            popupView.onClickSelect = {[unowned self] (row, text) in
                self.relativeInfo = (row,text)
                //局部刷新cell
                self.reloadOneCell(at: indexPath.row)
                popupController.dismiss(animated: true)
            }
        case self.contactCellData.cellData.count - 6://亲属联系人姓名
            contactType = 0
            
            if #available(iOS 9.0, *) {
                let pickerVC = CNContactPickerViewController()
                pickerVC.delegate = self
                self.present(pickerVC, animated: true, completion: nil)
                
            }else {
                let pickerVC = ABPeoplePickerNavigationController()
                pickerVC.peoplePickerDelegate = self
                self.present(pickerVC, animated: true, completion: nil)
            }
        case self.contactCellData.cellData.count - 3://紧急联系人关系
            let popupView =  PopupStaticSelectView(cellType: PopupStaticSelectView.PopupCellType.linkman, selectRow: self.linkmanInfo.row)
            let popupController = CNPPopupController(contents: [popupView])!
            popupController.present(animated: true)
            
            popupView.onClickSelect = {[unowned self] (row, text) in
                self.linkmanInfo = (row,text)
                //局部刷新cell
                self.reloadOneCell(at: indexPath.row)
                popupController.dismiss(animated: true)
            }
            
        case self.contactCellData.cellData.count - 2:  //紧急联系人姓名
            contactType = 1
            if #available(iOS 9.0, *) {
                let pickerVC = CNContactPickerViewController()
                pickerVC.delegate = self
                self.present(pickerVC, animated: true, completion: nil)
            }else {
                let pickerVC = ABPeoplePickerNavigationController()
                pickerVC.peoplePickerDelegate = self
                self.present(pickerVC, animated: true, completion: nil)
            }
        default:
           break
        }
    }
    
    //设置分割线
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let row = indexPath.row
        let count = contactCellData.cellData.count - 1
        
        if (row == 0 || row == 2 || row == count-1 || row == count-2 || row == count-5 || row == count-6){
            
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
    @available(iOS 9.0, *)
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

    @available(iOS 8.0, *)
    func peoplePickerNavigationController(_ peoplePicker: ABPeoplePickerNavigationController, didSelectPerson person: ABRecord) {
        //获取姓
        let lastName = ABRecordCopyValue(person, kABPersonLastNameProperty).takeRetainedValue()
            as! String
        PrintLog("选中人的姓：\(lastName)")
        
        //获取名
        let firstName = ABRecordCopyValue(person, kABPersonFirstNameProperty).takeRetainedValue()
            as! String
        PrintLog("选中人的名：\(firstName)")
        
        //获取电话
        var phoneValues:ABMutableMultiValue? =
            ABRecordCopyValue(person, kABPersonPhoneProperty).takeRetainedValue()
        if phoneValues == nil {
           phoneValues = "" as ABMutableMultiValue?
        }
        
        if contactType == 0{
            self.relativeContactInfo = ((lastName + firstName),phoneValues as! String)
        }else if contactType == 1{
            self.urgentContactInfo = ((lastName + firstName),phoneValues as! String)
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
        // 20000-家庭详细地址 10000-详细地址 10001-月供 10002-亲属名 10003-电话 10004-紧急名 10005-电话
        if textField.tag == 20000 {
            self.homeDetail = textField.text!
        }else if textField.tag == 10000{
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
    
        //是否已生成订单并且没有被驳回
        guard !(UserHelper.getAllFinishIsUpload() && !UserHelper.getIsReject()) else {
            self.showHint(in: self.view, hint: "订单已生成，信息不可更改哦！")
            return
        }
        
        guard
            self.homeInfo.county.characters.count > 0,
            self.homeDetail.characters.count > 0,
            self.areaInfo.county.characters.count > 0,
            self.areaDetail.characters.count > 0,
            self.houseInfo.text.characters.count > 0,
            self.liveTimeInfo.text.characters.count > 0,
            self.marryInfo.text.characters.count > 0,
            self.relativeInfo.text.characters.count > 0,
            self.linkmanInfo.text.characters.count > 0,
            self.relativeContactInfo.name.characters.count > 0,
            self.relativeContactInfo.number.characters.count > 0,
            self.urgentContactInfo.name.characters.count > 0,
            self.urgentContactInfo.number.characters.count > 0
            else {
                self.showHint(in: self.view, hint: "请完善信息再上传!")
                return
        }
        
        guard self.relativeContactInfo.number != self.urgentContactInfo.number else{
            self.showHint(in: self.view, hint: "不可使用同一联系人")
            return
        }
        
        //添加HUD
        self.showHud(in: self.view, hint: "上传中...")
        var params = NetConnect.getBaseRequestParams()
        params["companyType"] = "11" //固定
        params["role_auth"] = 999 //固定
        
        //家庭地址
        params["province"] = self.homeInfo.pro.replacingOccurrences(of: " ", with: "") //省(去除空格)
        params["county"] = self.homeInfo.city.replacingOccurrences(of: " ", with: "") //市(去除空格)
        params["area"] = self.homeInfo.county//县
        params["address"] = self.homeDetail //详细地址
        
        //常住地址
        params["cprovince"] = self.areaInfo.pro.replacingOccurrences(of: " ", with: "") //省(去除空格)
        params["ccounty"] = self.areaInfo.city.replacingOccurrences(of: " ", with: "") //市(去除空格)
        params["carea"] = self.areaInfo.county//县
        params["caddress"] = self.areaDetail //详细地址
        
        params["isHouse"] = self.houseInfo.row + 1 //住房情况
        params["forTheMonth"] = self.monthRent
        params["residenceTime"] = self.liveTimeInfo.text //居住时间
        
        if self.marryInfo.row == 2 { //婚姻状况（“其他”传6）
             params["isMarried"] = 6
        }else {
            params["isMarried"] = self.marryInfo.row + 1
        }
        params["contactsType1"] = "1"//固定
        params["contactsType2"] = "2"
        params["relation1"] = self.relativeInfo.row//亲属关系  /*神奇的从0开始*/
        params["name1"] = self.relativeContactInfo.name //直系姓名
        params["mobile1"] = self.relativeContactInfo.number //直系电话
        params["relation2"] = self.linkmanInfo.row + 3//紧急联系人关系 /*奇葩的从3开始*/
        params["name2"] = self.urgentContactInfo.name
        params["mobile2"] = self.urgentContactInfo.number
        
        //如果是驳回的则上传orderId
        if UserHelper.getIsReject() {
            params["orderId"] = UserHelper.getHomeNewOneOrderId()
        }
        
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
                //如果是驳回的则直接退出界面
                if UserHelper.getIsReject() {
                   self.leftNavigationBarBtnAction()
                }else{
                    self.pushToNextVC()
                }
                
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
        
        var params = ["userId": UserHelper.getUserId()]
        //如果是驳回的则上传orderId
        if UserHelper.getIsReject() {
            params["orderId"] = UserHelper.getHomeNewOneOrderId()
        }
        
        NetConnect.bm_get_contact_info(parameters: params, success: { response in
            //隐藏HUD
            self.hideHud()
            let json = JSON(response)
            guard json["RET_CODE"] == "000000" else{
                return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
            }
            
            self.refreshUI(homeJson: json["ContractAddr"], normalJson: json["ComAddr"], contact: json["contacts"])
            
        }, failure:{ error in
            //隐藏HUD
            self.hideHud()
        })
    }
    //填充信息
    func refreshUI(homeJson: JSON, normalJson:JSON, contact: JSON){
        self.homeInfo.pro = homeJson["province"].stringValue + " "
        self.homeInfo.city = homeJson["county"].stringValue + " "
        self.homeInfo.county = homeJson["AREA"].stringValue
        self.homeDetail = homeJson["address"].stringValue
       
        self.monthRent = homeJson["forTheMonth"].stringValue
        self.liveTimeInfo.text = homeJson["residenceTime"].stringValue
        let isHouse = homeJson["is_house"].intValue - 1
        self.houseInfo.row = isHouse < 0 ? 0 : isHouse
        self.houseInfo.text = houseData[self.houseInfo.row]
        let isMarried = homeJson["isMarried"].intValue - 1
        
        self.marryInfo.row = isMarried < 0 ? 0 : isMarried
        
        if self.marryInfo.row == 6 - 1 { //如果是其它则回传6
            self.marryInfo.text = marryData[2]
        }else {
            self.marryInfo.text = marryData[self.marryInfo.row]
        }
    
        self.areaInfo.pro = normalJson["province"].stringValue + " "
        self.areaInfo.city = normalJson["county"].stringValue + " "
        self.areaInfo.county = normalJson["AREA"].stringValue
        self.areaDetail = normalJson["address"].stringValue
        
        self.relativeInfo.row = contact[0]["relation"].intValue
        self.relativeInfo.text = relativeData[self.relativeInfo.row]
        self.relativeContactInfo.name = contact[0]["NAME"].stringValue
        self.relativeContactInfo.number = contact[0]["mobile"].stringValue
        
        let linkmanRow = contact[1]["relation"].intValue - 3
        self.linkmanInfo.row = linkmanRow < 0 ? 0 : linkmanRow
        self.linkmanInfo.text = linkmanData[self.linkmanInfo.row]
        self.urgentContactInfo.name = contact[1]["NAME"].stringValue
        self.urgentContactInfo.number = contact[1]["mobile"].stringValue
        
        //如果有月租则显示
        if self.houseInfo.row == 0 || self.houseInfo.row == 2 || self.houseInfo.row == 5 {
         self.contactCellData.cellData.insert( CellDataInfo(leftText: "房租月供", holdText: "请填写每月供款金额", content: self.monthRent, cellType: .textType), at: 5)
        }
        self.aTableView.reloadData()
    }
    
    
}

//MARK: 上传用户通讯录
extension ContactViewController {
    
    func uploadUserContact(){
        
        // MARK: - 获取原始顺序联系人的模型数组
        PPGetAddressBook.getOriginalAddressBook(addressBookArray: { (addressBookArray) in
            var contacts = [Dictionary<String,String>]()
            for dic in addressBookArray {
                contacts.append(["phone":dic.mobileArray.first ?? "","name":dic.name])
            }
            PrintLog("联系人\(contacts)")
            if (contacts.count > 0){
                var params = NetConnect.getBaseRequestParams()
                params["channel"] = "3"
                params["contracts"] = toolsChangeToJson(info: contacts)
                UserHelper.uploadUserContactInfo(withparams:params)
            }
            
        }, authorizationFailure: {
            let alertViewVC = UIAlertController.init(title: "提示", message: "请在iPhone的“设置-隐私-通讯录”选项中，允许访问您的通讯录", preferredStyle: UIAlertControllerStyle.alert)
            let confirm = UIAlertAction.init(title: "知道啦", style: UIAlertActionStyle.cancel, handler:nil)
            alertViewVC.addAction(confirm)
            self.present(alertViewVC, animated: true, completion: nil)
        })
    }
}
