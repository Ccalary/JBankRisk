//
//  ProductViewController.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/1.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit
import SwiftyJSON

class ProductViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,AMapLocationManagerDelegate {
    
     var ProductCellData:[CellDataInfo] = [ CellDataInfo(leftText: "所属商户", holdText: "商户名称", content: "", cellType: .defaultType),
        CellDataInfo(leftText: "产品名称", holdText: "请输入产品名称", content: "", cellType: .clearType),
        CellDataInfo(leftText: "", holdText: "", content: "", cellType: .defaultType),
        CellDataInfo(leftText: "借款金额", holdText: "可借区间2,000-3,0000", content: "", cellType: .textType),
        CellDataInfo(leftText: "申请期限", holdText: "", content: "", cellType: .arrowType),
        CellDataInfo(leftText: "月还款额", holdText: "", content: "", cellType: .textType),
        CellDataInfo(leftText: "", holdText: "", content: "", cellType: .defaultType),
        CellDataInfo(leftText: "业务员", holdText: "请输入业务员工号", content: "", cellType: .clearType)
    ]
    
    //商户名称
    var saleName = "jinjinsuo"
    //产品名称
    var proName = ""
    //选择的期限
    var selectPeriodInfo:(cell:Int, text:String) = (0,"")
    //借款金额
    var borrowMoney:String = ""
    //月还款
    var repayment: String = ""
    //业务员
    var workerName = ""
    
    var locationManager: AMapLocationManager!//定位管理
    var longitude: Double = 0 //经度
    var latitude: Double = 0 //纬度
    
    override func viewDidLoad() {
        super.viewDidLoad()
       //高德地图配置key
       AMapServices.shared().apiKey = "41b0c56389d5985147098b2d6b18898f";
        
        self.setupUI()
        self.initLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    func setupUI(){
        self.navigationController!.navigationBar.isTranslucent = true;
        self.automaticallyAdjustsScrollViewInsets = false;
        self.view.backgroundColor = defaultBackgroundColor
        self.title = "产品信息"
        
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
    
    lazy var aTableView: UITableView = {
        
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
        return ProductCellData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProCellID") as! BMTableViewCell
        //去除选择效果
        cell.selectionStyle = .none
        cell.cellDataInfo = ProductCellData[indexPath.row]
        cell.backgroundColor = UIColor.white
        
        switch indexPath.row {
        case 0://商户名称
            cell.centerTextField.text = self.saleName
        case 1:
            cell.centerTextField.tag = 20000
            cell.centerTextField.addTarget(self, action: #selector(textFieldAction(_:)), for: UIControlEvents.editingChanged)
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
       
        self.view.endEditing(true)
        
        if indexPath.row == 0 { //获取商户名称
            self.getAddress()
        }
        
        if indexPath.row == 4 { //申请期限
            guard self.borrowMoney.characters.count>0 else {
                self.showHint(in: self.view, hint: "请输入借款金额")
                return
            }
            //添加HUD
            self.showHud(in: self.view)
            
            let param = ["para_key":"pay_member"]
            NetConnect.bm_applyPeriod(parameters: param, success: { (response) in
                let json = JSON(response)
                //隐藏HUD
                self.hideHud()
                
                guard json["RET_CODE"] == "000000" else{
                    return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
                }
                if let dataArray = json["terms"].arrayObject {
                    
                    let phoneCallView = PopupDeadlineView(dataArray: dataArray, selectedCell: self.selectPeriodInfo.cell, borrowMoney: self.borrowMoney,mViewController: self)
                    let popupController = CNPPopupController(contents: [phoneCallView])!
                    popupController.present(animated: true)
                    //返回的数据展示
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
                //隐藏HUD
                self.hideHud()
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
    
    //MARK: - 高德地图定位
    //初始化定位
    func initLocation(){
        
        locationManager = AMapLocationManager()
        locationManager.delegate = self
        locationManager.allowsBackgroundLocationUpdates = false
        locationManager.pausesLocationUpdatesAutomatically = true
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters//定位精度
        self.getAddress()
    }
    
    //获取位置
    func getAddress(){
         self.showHud(in: self.view, hint: "加载中...")
        locationManager.requestLocation(withReGeocode: true, completionBlock: { (location, code, error) in
            
            if (error != nil){
                //隐藏HUD
                self.hideHud()
                let alertController = UIAlertController(title: "获取商户名称失败",
                                                        message: "请检查是否在“设置－中诚消费－位置”中未允许本App访问您的位置", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "好的", style: .default, handler: { action in
                    self.dismiss(animated: true, completion: nil)
                })
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                return
            }
            self.longitude =  (location?.coordinate.longitude)!
            self.latitude = (location?.coordinate.latitude)!
            self.requestSaleAddress()
        })
    }
    
    //MARK: - Action
    
    func textFieldAction(_ textField: UITextField){
        //tag: 10000- 借款金额 10001-业务员编号  20000- 产品名称
        if textField.tag == 10000 {
            //限制输入的长度，最长为9位
            if (textField.text?.characters.count)! > 9{
                let index = textField.text?.index((textField.text?.startIndex)!, offsetBy: 9)//到offsetBy的前一位
                textField.text = textField.text?.substring(to: index!)
            }
            self.borrowMoney = textField.text!
            //如果清空，则申请期限清空
            if self.borrowMoney == "" {
                self.selectPeriodInfo = (0,"")
                self.repayment = ""
                let position1 = IndexPath(row: 5, section: 0)
                let position2 = IndexPath(row: 4, section: 0)
                self.aTableView.reloadRows(at: [position1,position2], with: UITableViewRowAnimation.none)
            }
        }else if textField.tag == 10001 {
            //限制输入的长度，最长为8位
            if (textField.text?.characters.count)! > 8{
                let index = textField.text?.index((textField.text?.startIndex)!, offsetBy: 9)//到offsetBy的前一位
                textField.text = textField.text?.substring(to: index!)
            }
            self.workerName = textField.text!
        }else if textField.tag == 20000 {
            self.proName = textField.text!
        }
    }
    
    //上一步
    func lastStepBtnAction(){
        
    }
    //下一步
    func nextStepBtnAction(){
        //判断是否可以上传
        guard self.proName.characters.count > 0,
            self.borrowMoney.characters.count > 0,
            self.selectPeriodInfo.text.characters.count > 0,
            self.workerName.characters.count > 0
            else {
                self.showHint(in: self.view, hint: "请完善信息再上传!")
                
                return
        }
        
        //添加HUD
        self.showHud(in: self.view, hint: "上传中...")
        //期数
        let index = self.selectPeriodInfo.text.index(self.selectPeriodInfo.text.endIndex, offsetBy: -1)
        let totalStr = self.selectPeriodInfo.text.substring(to: index)
        let total = Int(totalStr)
        
        var params = NetConnect.getBaseRequestParams()
        params["saleName"] = self.saleName
        params["orderName"] = self.proName
        params["amt"] = self.borrowMoney
        params["employeeId"] = self.workerName
        params["total"] = total
        
        NetConnect.bm_upload_product_info(parameters: params, success:
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

//MARK: - 数据请求
extension ProductViewController {
    //获取商户地址
    func requestSaleAddress(){
        
        var params = NetConnect.getBaseRequestParams()
        params["accuracy"] = self.longitude
        params["dimension"] = self.latitude
        
        NetConnect.bm_get_sale_address(parameters: params, success:
            { response in
    
                //隐藏HUD
                self.hideHud()
                let json = JSON(response)
                guard json["RET_CODE"] == "000000" else{
                    return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
                }
                self.saleName = json["saleName"].stringValue
                //刷新tableView
                let position1 = IndexPath(row: 0, section: 0)
                self.aTableView.reloadRows(at: [position1], with: UITableViewRowAnimation.none)
                
        }, failure: {error in
            //隐藏HUD
            self.hideHud()
        })
    }
}

