//
//  ContactViewController.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/1.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,UIGestureRecognizerDelegate {
    
    var ContactCellData:[CellDataInfo] = [CellDataInfo(leftText: "常住地址", holdText: "请选择所属地区", content: "", cellType: .arrowType),
        CellDataInfo(leftText: "", holdText: "详细街道地址", content: "", cellType: .clearType),
        CellDataInfo(leftText: "住房情况", holdText: "请选择住房情况", content: "", cellType: .arrowType),
        CellDataInfo(leftText: "居住时间", holdText: "请选择居住时间", content: "", cellType: .arrowType),
        CellDataInfo(leftText: "直系亲属", holdText: "请选择直系亲属关系", content: "", cellType: .arrowType),
        CellDataInfo(leftText: "", holdText: "联系人姓名，可从通讯录中选择", content: "", cellType: .clearType),
        CellDataInfo(leftText: "", holdText: "请填写手机号", content: "", cellType: .clearType),
        CellDataInfo(leftText: "", holdText: "", content: "", cellType: .defaultType),
        CellDataInfo(leftText: "紧急联系人", holdText: "可从通讯录中选择", content: "", cellType: .arrowType),
        CellDataInfo(leftText: "", holdText: "填写姓名", content: "", cellType: .clearType),
        CellDataInfo(leftText: "", holdText: "填写手机号码", content: "", cellType: .clearType)]
    
    ///住房情况
    var houseInfo:(row: Int, text: String) = (0,"")
    ///亲属关系
    var relativeInfo:(row: Int, text: String) = (0,"")
    
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
        self.title = "联系信息"
        
        let aTap = UITapGestureRecognizer(target: self, action: #selector(tapViewAction))
        aTap.numberOfTapsRequired = 1
        aTap.delegate = self
        UIApplication.shared.keyWindow?.addGestureRecognizer(aTap)
        
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
        return ContactCellData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCellID") as! BMTableViewCell
        //去除选择效果
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.white
        cell.cellDataInfo = ContactCellData[indexPath.row]
        
        switch indexPath.row {
        case 2://住房情况
            cell.centerTextField.text = self.houseInfo.text
        case self.ContactCellData.count - 7: //亲属关系
            cell.centerTextField.text = self.relativeInfo.text
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
        
        if indexPath.row == 2 {//住房情况
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
            
        }else if indexPath.row == self.ContactCellData.count - 7 { //直系亲属关系
            let popupView =  PopupStaticSelectView(cellType: PopupStaticSelectView.PopupCellType.relative, selectRow: self.relativeInfo.row)
            let popupController = CNPPopupController(contents: [popupView])!
            popupController.present(animated: true)
            
            popupView.onClickSelect = { (row, text) in
                self.relativeInfo = (row,text)
                let position = IndexPath(row: indexPath.row, section: 0)
                self.aTableView.reloadRows(at: [position], with: UITableViewRowAnimation.none)
                popupController.dismiss(animated: true)
            }
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
    
}
