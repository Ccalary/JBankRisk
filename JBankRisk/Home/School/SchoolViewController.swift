//
//  SchoolViewController.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/1.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

class SchoolViewController:  UIViewController,UITableViewDelegate, UITableViewDataSource,UIGestureRecognizerDelegate {
    
    var SchoolCellData:[CellDataInfo] = [
        CellDataInfo(leftText: "学校地址", holdText: "请选择所属地区", content: "", cellType: .arrowType),
        CellDataInfo(leftText: "", holdText: "详细街道地址", content: "", cellType: .clearType),
        CellDataInfo(leftText: "学校名称", holdText: "请选择学校名称", content: "", cellType: .arrowType),
        CellDataInfo(leftText: "学历", holdText: "请选择学历", content: "", cellType: .arrowType),
        CellDataInfo(leftText: "年级", holdText: "请选择年级", content: "", cellType: .arrowType),
        CellDataInfo(leftText: "专业", holdText: "请填写专业", content: "", cellType: .clearType),
        CellDataInfo(leftText: "学制", holdText: "请选择学制", content: "", cellType: .arrowType)]
    
    ///学历
    var eduDegreeInfo:(row: Int, text: String) = (0,"")
    ///年级
    var eduGradeInfo:(row: Int, text: String) = (0,"")
    ///学制
    var eduSystemInfo:(row: Int, text: String) = (0,"")

    
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
        self.title = "学校信息"
        
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
    
    private lazy var aTableView: UITableView = {
        
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
        return SchoolCellData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SchoolCellID") as! BMTableViewCell
        //去除选择效果
        cell.selectionStyle = .none
        cell.cellDataInfo = SchoolCellData[indexPath.row]
        
        switch indexPath.row {
        case 3://学历
            cell.centerTextField.text = eduDegreeInfo.text
        case 4://年级
            cell.centerTextField.text = eduGradeInfo.text
        case 6://学制
             cell.centerTextField.text = eduSystemInfo.text
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 {
            return 40*UIRate
        }else {
            return 50*UIRate
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 3 { //请选择学历
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
