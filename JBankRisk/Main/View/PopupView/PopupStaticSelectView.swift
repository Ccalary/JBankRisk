//
//  PopupStaticSelectView.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/2.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit

    let workYearData = ["3个月内","6个月内","1年","2年","3年","4年","5年","5年以上"]
    let relativeData = ["父亲","母亲","子女","配偶"]
    let houseData = ["自置按揭","自置无按揭","租用","宿舍","父母同住","其他"]
    let eduDegreeData = ["大专","本科","硕士","博士"]
    let eduSystemData = ["全日制","非全日制"]
    let eduGradeData = ["大一","大二","大三","大四"]
    let companyTypeData = ["外资（欧美）","外资（非欧美）","合资","国企","民营企业","外企代表处","政府机关","事业单位","非营利机构","上市公司","创业公司"]
    let workExpData = ["无经验","一年以内","1-3年","3-5年","5-10年","10年以上"]
    let liveTimeData = ["3个月内","6个月内","1年","3年","3年以上"]
    let incomePayWayData = ["打卡","现金"]
    let marryData = ["未婚","已婚"]

class PopupStaticSelectView: UIView, UITableViewDelegate, UITableViewDataSource {

    enum PopupCellType: String {
        case year = "工作年限"
        case relative = "直系亲属"
        case house = "住房情况"
        case eduDegree = "学历"
        case eduSystem = "学制"
        case eduGrade = "年级"
        case companyType = "单位性质"
        case workExp = "工作经验"
        case liveTime = "居住时间"
        case incomePayWay = "结算方式"
        case marry = "婚姻状况"
    }
    
    var dataArray = [""]
    var cellType:PopupCellType!
    
    var selectedCellInfo:(row: Int, text: String) = (0, "")
    
    var schoolCellInfo:(row: Int, name: String, code: String) = (0,"","")
    
    override init(frame: CGRect ) {
        super.init(frame: frame)
    }
    
    ///初始化默认frame
    convenience init(cellType: PopupCellType, selectRow: Int) {
        let frame = CGRect()
        self.init(frame: frame)
        
        self.cellType = cellType
        
        switch cellType {
        case .year:
            dataArray = workYearData
        case .relative:
            dataArray = relativeData
        case .house:
            dataArray = houseData
        case .eduDegree:
            dataArray = eduDegreeData
        case .eduSystem:
            dataArray = eduSystemData
        case .eduGrade:
            dataArray = eduGradeData
        case .companyType:
            dataArray = companyTypeData
        case .workExp:
            dataArray = workExpData
        case .liveTime:
            dataArray = liveTimeData
        case .incomePayWay:
            dataArray = incomePayWayData
        case .marry:
            dataArray = marryData
        }
        self.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH - 40*UIRate, height: 50*UIRate + 5*45*UIRate)
        
        self.titleLabel.text = self.cellType.rawValue
        self.selectedCellInfo = (selectRow, self.dataArray[selectRow])
        setupUI()
    }
    
    ///初始化默认frame(学校)
    convenience init(schoolInfo: Array<String>,selectRow: Int) {
        let frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH - 40*UIRate, height: 50*UIRate + 5*45*UIRate)
        self.init(frame: frame)
        
        self.titleLabel.text = "选择学校"
        dataArray = schoolInfo
        self.selectedCellInfo = (selectRow, self.dataArray[selectRow])
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        
        self.backgroundColor = UIColor.white
        
        self.addSubview(holdView)
        self.addSubview(titleLabel)
        self.addSubview(closeBtn)
        self.addSubview(divideLine)
        self.addSubview(aTableView)
        
        holdView.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.centerX.equalTo(self)
            make.width.equalTo(self)
            make.height.equalTo(50*UIRate)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(holdView)
            make.centerX.equalTo(self)
        }
        
        closeBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(17*UIRate)
            make.right.equalTo(self).offset(-20*UIRate)
            make.centerY.equalTo(holdView)
        }
        
        divideLine.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.height.equalTo(0.5*UIRate)
            make.centerX.equalTo(self)
            make.bottom.equalTo(holdView.snp.bottom)
        }

        aTableView.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.height.equalTo(5*45*UIRate)
            make.centerX.equalTo(self)
            make.top.equalTo(holdView.snp.bottom)
        }
        
        //选中cell
        let defaultCell = IndexPath(row: selectedCellInfo.row, section: 0)
        self.aTableView.selectRow(at: defaultCell, animated: true, scrollPosition: UITableViewScrollPosition.top)
    }
    
    private lazy var holdView: UIView = {
        let holdView = UIView()
        holdView.backgroundColor = UIColor.white
        return holdView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontSize(size: 18*UIRate)
        label.textAlignment = .center
        label.textColor = UIColorHex("666666")
        return label
    }()
    
    //分割线
    private lazy var divideLine: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = defaultDivideLineColor
        return lineView
    }()

    ///关闭按钮
    private lazy var closeBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "bm_close_gray_17x17"), for: .normal)
        button.addTarget(self, action:#selector(closeBtnAction), for: .touchUpInside)
        return button
    }()
    
    
    private lazy var aTableView: UITableView = {
        
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(PopupStaticTableViewCell.self, forCellReuseIdentifier: "popCellID")
        
        //tableView 单元格分割线的显示
        if tableView.responds(to:#selector(setter: UITableViewCell.separatorInset)) {
            tableView.separatorInset = .zero
        }
        
        if tableView.responds(to: #selector(setter: UITableViewCell.layoutMargins)) {
            tableView.layoutMargins = .zero
        }
        return tableView
        
    }()
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "popCellID") as! PopupStaticTableViewCell
        //去除选择效果
        cell.selectionStyle = .none
        cell.leftTextLabel.text = dataArray[indexPath.row]
        //默认选中
        if indexPath.row == selectedCellInfo.row {
            cell.checkImageView.isHidden = false
            cell.leftTextLabel.textColor = UIColorHex("e9342d")
        }else{
            cell.checkImageView.isHidden = true
            cell.leftTextLabel.textColor = UIColorHex("666666")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45*UIRate
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         if let onClickSelect = self.onClickSelect {
            onClickSelect(indexPath.row, self.dataArray[indexPath.row])
        }
    }

    //设置分割线
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if cell.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 20*UIRate, bottom: 0, right: 20*UIRate)
        }
        if cell.responds(to: #selector(setter: UITableViewCell.layoutMargins)) {
            cell.layoutMargins = UIEdgeInsets(top: 0, left: 20*UIRate, bottom: 0, right: 20*UIRate)
        }
    }
    
    //MARK: - Action
    
    var onClickSelect: ((_ row: Int,_ text: String)->())?
    
    //关闭
   func closeBtnAction(){
        if let onClickSelect = onClickSelect {
            onClickSelect(self.selectedCellInfo.row,self.selectedCellInfo.text)
        }
    }
}
