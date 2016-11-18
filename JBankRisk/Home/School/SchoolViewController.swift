//
//  SchoolViewController.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/1.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit
import SwiftyJSON

class SchoolViewController:  UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    var SchoolCellData:[CellDataInfo] = [
        CellDataInfo(leftText: "学校地址", holdText: "请选择所属地区", content: "", cellType: .arrowType),
        CellDataInfo(leftText: "", holdText: "详细街道地址", content: "", cellType: .clearType),
        CellDataInfo(leftText: "学校名称", holdText: "请选择学校名称", content: "", cellType: .arrowType),
        CellDataInfo(leftText: "学历", holdText: "请选择学历", content: "", cellType: .arrowType),
        CellDataInfo(leftText: "年级", holdText: "请选择年级", content: "", cellType: .arrowType),
        CellDataInfo(leftText: "专业", holdText: "请填写专业", content: "", cellType: .clearType),
        CellDataInfo(leftText: "学制", holdText: "请选择学制", content: "", cellType: .arrowType)]
    
    var uploadSucDelegate:UploadSuccessDelegate?
    
    //地区信息
    var areaInfo:(pro:String, city:String, county:String) = ("","","")
    var areaRow:(proRow:Int, cityRow:Int, countyRow:Int) = (-1,-1,-1)
    var province = "" //省
    //街道地址
    var placeText = ""
    //专业
    var majoyText = ""
    
    //学校名字
    var schoolInfo: (row: Int, text:String, code:String) = (0,"","")
    ///学历
    var eduDegreeInfo:(row: Int, text: String) = (0,"")
    ///年级
    var eduGradeInfo:(row: Int, text: String) = (0,"")
    ///学制
    var eduSystemInfo:(row: Int, text: String) = (0,"")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
        if UserHelper.getSchoolIsUpload() {
            self.requestSchoolInfo()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func setupUI(){
        self.navigationController!.navigationBar.isTranslucent = true;
        self.automaticallyAdjustsScrollViewInsets = false;
        self.view.backgroundColor = defaultBackgroundColor
        self.title = "学校信息"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"navigation_left_back_13x21"), style: .plain, target: self, action: #selector(leftNavigationBarBtnAction))
        
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
            make.height.equalTo(340*UIRate)
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
    
    lazy var aTableView: UITableView = {
        
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.tableFooterView = UIView()
        tableView.register(BMTableViewCell.self, forCellReuseIdentifier: "SchoolCellID")
        
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
        return SchoolCellData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SchoolCellID") as! BMTableViewCell
        //去除选择效果
        cell.selectionStyle = .none
        cell.cellDataInfo = SchoolCellData[indexPath.row]
        
        switch indexPath.row {
        case 0://地区
            cell.centerTextField.text = self.areaInfo.pro + self.areaInfo.city + self.areaInfo.county
        case 1://街道
            cell.centerTextField.text = self.placeText
            cell.centerTextField.tag = 10000
            cell.centerTextField.addTarget(self, action: #selector(textFieldAction(_:)), for: UIControlEvents.editingChanged)
        case 2://学校名称
            cell.centerTextField.text = self.schoolInfo.text
        case 3://学历
            cell.centerTextField.text = eduDegreeInfo.text
        case 4://年级
            cell.centerTextField.text = eduGradeInfo.text
        case 5://专业
            cell.centerTextField.text = self.majoyText
            cell.centerTextField.tag = 10001
            cell.centerTextField.addTarget(self, action: #selector(textFieldAction(_:)), for: UIControlEvents.editingChanged)
        case 6://学制
             cell.centerTextField.text = eduSystemInfo.text
        default:
            break
        }
        
        return cell
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
                self.province = pro.pro
                //局部刷新cell
                self.reloadOneCell(at: indexPath.row)
                popupController.dismiss(animated: true)
            }
            popupView.onClickClose = { _ in
                popupController.dismiss(animated: true)
            }
        
        }else if indexPath.row == 2 { //学校名称
            guard self.areaInfo.pro.characters.count > 0 else {
                self.showHint(in: self.view, hint: "请先选择学校地址")
                return
            }
            self.requestSchoolData()
            
            
        }else if indexPath.row == 3 { //请选择学历
            let popupView =  PopupStaticSelectView(cellType: PopupStaticSelectView.PopupCellType.eduDegree, selectRow: self.eduDegreeInfo.row)
            let popupController = CNPPopupController(contents: [popupView])!
            popupController.present(animated: true)
            
            popupView.onClickSelect = { (row, text) in
                self.eduDegreeInfo = (row,text)
                let position = IndexPath(row: indexPath.row, section: 0)
                self.aTableView.reloadRows(at: [position], with: UITableViewRowAnimation.none)
                popupController.dismiss(animated: true)
            }

        }else if indexPath.row == 4 { //年级
            let popupView =  PopupStaticSelectView(cellType: PopupStaticSelectView.PopupCellType.eduGrade, selectRow: self.eduGradeInfo.row)
            let popupController = CNPPopupController(contents: [popupView])!
            popupController.present(animated: true)
            
            popupView.onClickSelect = { (row, text) in
                self.eduGradeInfo = (row,text)
                let position = IndexPath(row: indexPath.row, section: 0)
                self.aTableView.reloadRows(at: [position], with: UITableViewRowAnimation.none)
                popupController.dismiss(animated: true)
            }

        }else if indexPath.row == 6 {//学制
            let popupView =  PopupStaticSelectView(cellType: PopupStaticSelectView.PopupCellType.eduSystem, selectRow: self.eduSystemInfo.row)
            let popupController = CNPPopupController(contents: [popupView])!
            popupController.present(animated: true)
            
            popupView.onClickSelect = { (row, text) in
                self.eduSystemInfo = (row,text)
                let position = IndexPath(row: indexPath.row, section: 0)
                self.aTableView.reloadRows(at: [position], with: UITableViewRowAnimation.none)
                popupController.dismiss(animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 {
            return 40*UIRate
        }else {
            return 50*UIRate
        }
    }
    
    //设置分割线
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
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
        
        if textField.tag == 10000 {
            self.placeText = textField.text!

        }else if textField.tag == 10001 {
            self.majoyText = textField.text!
        }
    }
    
    func lastStepBtnAction(){
         _ = self.navigationController?.popViewController(animated: true)
    }
    
    //返回
    func leftNavigationBarBtnAction(){
        let borrowVC = self.navigationController?.viewControllers[1] as! BorrowMoneyViewController
        _ = self.navigationController?.popToViewController(borrowVC, animated: true)
    }
    //下一步
    func nextStepBtnAction(){
        
        //是否已生成订单
        guard !UserHelper.getAllFinishIsUpload() else {
            self.showHint(in: self.view, hint: "订单已生成，信息不可更改哦！")
            return
        }
        
        guard self.placeText.characters.count > 0,
            self.majoyText.characters.count > 0,
            self.areaInfo.pro.characters.count > 0,
            self.schoolInfo.text.characters.count > 0,
            self.eduSystemInfo.text.characters.count > 0,
            self.eduGradeInfo.text.characters.count > 0,
            self.eduDegreeInfo.text.characters.count > 0
            else {
                self.showHint(in: self.view, hint: "请完善信息再上传!")
                return
        }
        
        //添加HUD
        self.showHud(in: self.view, hint: "上传中...")
        var params = NetConnect.getBaseRequestParams()
        params["province"] = self.province
        params["address"] = self.placeText
        params["school"] = self.schoolInfo.code
        params["studentType"] = "1" //学生类型，默认1-在校生
        params["education"] = self.eduDegreeInfo.row + 1 //学制
        params["school_len"] = self.eduSystemInfo.row + 1 //学制
        params["majoy"] = self.majoyText //专业
        params["grade"] = self.eduGradeInfo.row + 1
        
        NetConnect.bm_upload_school_info(parameters: params, success:
            { response in
                //隐藏HUD
                self.hideHud()
                let json = JSON(response)
                guard json["RET_CODE"] == "000000" else{
                    return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
                }
                
                UserHelper.setSchool(isUpload: true)
                
                if self.uploadSucDelegate != nil {
                    self.uploadSucDelegate?.upLoadInfoSuccess()
                }
                self.showHintInKeywindow(hint: "学校信息上传完成！",yOffset: SCREEN_HEIGHT/2 - 100*UIRate)
                
                let idVC = ContactViewController()
                self.navigationController?.pushViewController(idVC, animated: true)
                
        }, failure: {error in
            //隐藏HUD
            self.hideHud()
        })
    }
    
    //MARK:请求学校信息
    func requestSchoolInfo(){
        
        //添加HUD
        self.showHud(in: self.view, hint: "加载中...")
        
        let params = ["userId": UserHelper.getUserId()!]
        
        NetConnect.bm_get_school_info(parameters: params, success: { response in
            //隐藏HUD
            self.hideHud()
            let json = JSON(response)
            guard json["RET_CODE"] == "000000" else{
                return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
            }
            
            self.refreshUI(json: json["schoolInfo"])
            
        }, failure:{ error in
            //隐藏HUD
            self.hideHud()
        })
        
    }
    //填充信息
    func refreshUI(json: JSON){
        self.areaInfo.pro = json["province"].stringValue
        self.province = self.areaInfo.pro
        self.placeText = json["address"].stringValue
        self.schoolInfo.text = json["school"].stringValue
        self.eduDegreeInfo.row = json["education"].intValue - 1
        self.eduDegreeInfo.text = eduDegreeData[self.eduDegreeInfo.row]
        self.eduGradeInfo.row = json["grade"].intValue - 1
        self.eduGradeInfo.text = eduGradeData[self.eduGradeInfo.row]
        self.eduSystemInfo.row = json["school_len"].intValue - 1
        self.eduSystemInfo.text = eduSystemData[self.eduSystemInfo.row]
        self.majoyText = json["majoy"].stringValue
        self.aTableView.reloadData()
    }
}


extension SchoolViewController {
    //请求学校信息
    func requestSchoolData(){
        
        //添加HUD
        self.showHud(in: self.view)
        
        var params = NetConnect.getBaseRequestParams()
        params["province"] = self.province
        
        NetConnect.bm_get_school_name(parameters: params, success:
            { response in
                
                //隐藏HUD
                self.hideHud()
                let json = JSON(response)
                guard json["RET_CODE"] == "000000" else{
                    return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
                }
               
                let schoolArray = json["schoolCode"].arrayObject as! Array<Dictionary<String, Any>>
                
                let nameArray = schoolArray.map({ (schoolDic) in
                    return schoolDic["school_name"] as! String
                })
                
                let codeArray = schoolArray.map({ (schoolDic) in
                    return schoolDic["school_code"] as! String
                })
                
                let popupView =  PopupStaticSelectView(schoolInfo: nameArray, selectRow:self.schoolInfo.row)
                let popupController = CNPPopupController(contents: [popupView])!
                popupController.present(animated: true)
                
                popupView.onClickSelect = { (row, text) in
                    self.schoolInfo = (row,text,codeArray[row])
                    let position = IndexPath(row: 2, section: 0)
                    self.aTableView.reloadRows(at: [position], with: UITableViewRowAnimation.none)
                    popupController.dismiss(animated: true)
                }
                
        }, failure: {error in
            //隐藏HUD
            self.hideHud()
        })
        
    }
}
