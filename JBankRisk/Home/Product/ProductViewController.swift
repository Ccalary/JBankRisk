//
//  ProductViewController.swift
//  JBankRisk
//
//  Created by caohouhong on 16/11/1.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import UIKit
import SwiftyJSON

class ProductViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate,AMapLocationManagerDelegate {
    
    var productCellData = UserInfoCellModel(dataType: UserInfoCellModel.CellModelType.product)
    var uploadSucDelegate: UploadSuccessDelegate?
    
    //芝麻信用授权地址
    var zmUrl = ""
    
    //商户列表
    var saleList: [String] = []
    //商户选择情况
    var saleInfo: (row: Int, text: String) = (0,"")
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
        
        if UserHelper.getProductIsUpload() {
            self.requestProductInfo()
        }else {
            self.getAddress()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //如果没有进行过授权则展示
        if !UserHelper.getIsShowedZhiMa(){
            self.authorityAction()
            UserHelper.setIsShowedZhiMa(true)
        }
    }
    
    func setupUI(){
        self.view.backgroundColor = defaultBackgroundColor
        self.navigationItem.title = "产品信息"
        
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
            make.height.equalTo(SCREEN_HEIGHT - TopFullHeight - 64*UIRate)
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view)
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

    lazy var aTableView: UITableView = {
        
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = defaultBackgroundColor
        tableView.register(BMTableViewCell.self, forCellReuseIdentifier: "ProCellID")
        
        //tableView 单元格分割线的显示
        tableView.separatorInset = UIEdgeInsets.zero
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
        return productCellData.cellData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProCellID") as! BMTableViewCell
        //去除选择效果
        cell.selectionStyle = .none
        cell.cellDataInfo = productCellData.cellData[indexPath.row]
        cell.backgroundColor = UIColor.white

        switch indexPath.row {
        case 0://商户名称
            cell.centerTextField.text = self.saleInfo.text
        case 1://产品名称
            cell.centerTextField.text = self.proName
            cell.centerTextField.tag = 20000
            cell.centerTextField.addTarget(self, action: #selector(textFieldAction(_:)), for: UIControlEvents.editingChanged)
        case 3://借款金额
            cell.centerTextField.text = self.borrowMoney
            cell.centerTextField.keyboardType = .numberPad
            cell.centerTextField.tag = 10000
            cell.centerTextField.addTarget(self, action: #selector(textFieldAction(_:)), for: UIControlEvents.editingChanged)
        case 4://申请期限
             cell.centerTextField.text = selectPeriodInfo.text
        case 5://月还款额
            cell.centerTextField.text = self.repayment
            cell.centerTextField.isEnabled = false
        case 7://业务员
             cell.centerTextField.text = self.workerName
             cell.centerTextField.keyboardType = .numberPad
             cell.centerTextField.tag = 10001
             cell.centerTextField.addTarget(self, action: #selector(textFieldAction(_:)), for: UIControlEvents.editingChanged)
        default:
            cell.backgroundColor = defaultBackgroundColor
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
            guard !UserHelper.getProductIsUpload() else {
                return
            }
            
            if self.saleList.count > 0{
                let popupView =  PopupStaticSelectView(mDataArray: self.saleList, selectRow: self.saleInfo.row, title: "商户名称")
                let popupController = CNPPopupController(contents: [popupView])!
                popupController.present(animated: true)
                
                popupView.onClickSelect = {[unowned self] (row, text) in
                    self.saleInfo = (row,text)
                    //局部刷新cell
                    let position = IndexPath(row: indexPath.row, section: 0)
                    self.aTableView.reloadRows(at: [position], with: UITableViewRowAnimation.none)
                     popupController.dismiss(animated: true)
                }

            }else {
                self.getAddress()
            }
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
                    phoneCallView.onClickSure = {[unowned self] (cell,text,moneyRepay) in
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
    
    //MARK: - 芝麻信用授权
    func doVerify(_ url: String){
        // 这里使用固定appid 20000067
        let urlEncode = OCTools.urlEncodedString(withUrl: url);
        var alipayUrl = "alipays://platformapi/startapp?appId=20000067&url=";
        if let urlEncode = urlEncode {
            alipayUrl = alipayUrl + urlEncode
        }
        
        if self.canOpenAlipay(){
            UIApplication.shared.openURL(URL(string: alipayUrl)!)
        }else {
            let alertViewVC = UIAlertController(title: "", message: "是否下载并安装支付宝完成认证?", preferredStyle: UIAlertControllerStyle.alert)
            
            let cancel = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler:nil)
            let confirm = UIAlertAction(title: "好的", style: .default, handler: { _ in
                let appstoreUrl = "itms-apps://itunes.apple.com/app/id333206289";
                UIApplication.shared.openURL(URL(string: appstoreUrl)!)
            })
            alertViewVC.addAction(cancel)
            alertViewVC.addAction(confirm)
            self.present(alertViewVC, animated: true, completion: nil)
        }
    }
    
    
    func canOpenAlipay() -> Bool{
        return UIApplication.shared.canOpenURL(URL(string: "alipays://com.jjs.zmAlipay")!)
    }

    
    //MARK: - 高德地图定位
    //初始化定位
    func initLocation(){
        
        locationManager = AMapLocationManager()
        locationManager.delegate = self
        locationManager.allowsBackgroundLocationUpdates = false
        locationManager.pausesLocationUpdatesAutomatically = true
        locationManager.desiredAccuracy = kCLLocationAccuracyBest//定位精度
        locationManager.locationTimeout = 10
        locationManager.reGeocodeTimeout = 10
    }
    
    //获取位置
    func getAddress(){
        self.showHud(in: self.view, hint: "获取中...")
        locationManager.requestLocation(withReGeocode: true, completionBlock: { (location, code, error) in
            //隐藏HUD
            self.hideHud()
            if let error = error {
                
                let error = error as NSError
                
                if error.code == AMapLocationErrorCode.locateFailed.rawValue {
                    //定位错误：此时location和regeocode没有返回值，不进行annotation的添加
                   
                    let alertController = UIAlertController(title: "无访问权限",
                                                            message: "请允许本App访问您的位置",
                                                            preferredStyle: .alert)
                    
                    let okAction = UIAlertAction(title: "好的", style: .default, handler: { action in
                        self.dismiss(animated: true, completion: nil)
                        
                        if let url = URL(string: UIApplicationOpenSettingsURLString){
                            if (UIApplication.shared.canOpenURL(url)){
                                UIApplication.shared.openURL(url)
                            }
                        }
                    })
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                    return
                }else if error.code == AMapLocationErrorCode.reGeocodeFailed.rawValue
                    || error.code == AMapLocationErrorCode.timeOut.rawValue
                    || error.code == AMapLocationErrorCode.cannotFindHost.rawValue
                    || error.code == AMapLocationErrorCode.badURL.rawValue
                    || error.code == AMapLocationErrorCode.notConnectedToInternet.rawValue
                    || error.code == AMapLocationErrorCode.cannotConnectToHost.rawValue {
                    
                    let alertController = UIAlertController(title: "定位失败",
                                                            message: "请点击【所属商户】尝试再次获取",
                                                            preferredStyle: .alert)
                    
                    let okAction = UIAlertAction(title: "好的", style: .default, handler: { action in
                        self.dismiss(animated: true, completion: nil)
                    })
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                    return
                }
                else {
                    //没有错误：location有返回值，regeocode是否有返回值取决于是否进行逆地理操作，进行annotation的添加
                 
                }
            }
            //没有错误则去请求位置
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
            //如果改变，则申请期限清空
            if self.selectPeriodInfo.text.characters.count > 0 {
                
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
    
    //MARK:芝麻信用
    func authorityAction(){
        let authorityView = PopupAuthorityView()
        let popupController = CNPPopupController(contents: [authorityView])!
        popupController.present(animated: true)
        
        authorityView.onClickCancel = {_ in
            popupController.dismiss(animated:true)
        }
        
        authorityView.onClickSure = {[weak self] in
            popupController.dismiss(animated: true)
            //延时执行
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5){
                self?.doVerify((self?.zmUrl)!)
            }
        }
    }
    
    //上一步
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
    
    //下一步(上传用户信息)
    func nextStepBtnAction(){
       
        //是否已生成订单并且没有被驳回
        guard !(UserHelper.getAllFinishIsUpload() && !UserHelper.getIsReject()) else {
            self.showHint(in: self.view, hint: "订单已生成，信息不可更改哦！")
            return
        }
        
        //判断是否可以上传
        guard self.proName.characters.count > 0,
             self.saleInfo.text.characters.count > 0,
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
        params["saleName"] = self.saleInfo.text
        params["orderName"] = self.proName
        params["amt"] = self.borrowMoney
        params["employeeId"] = self.workerName
        params["total"] = total
        //如果是驳回的则上传orderId
        if UserHelper.getIsReject() {
            params["orderId"] = UserHelper.getHomeNewOneOrderId()
        }
        NetConnect.bm_upload_product_info(parameters: params, success:
            { response in
                
                //隐藏HUD
                self.hideHud()
                let json = JSON(response)
                guard json["RET_CODE"] == "000000" else{
                    return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
                }
                
                UserHelper.setProduct(isUpload: true)
                UserHelper.setUserBorrowAmt(money: Int(self.borrowMoney)!)
                
                if self.uploadSucDelegate != nil {
                    self.uploadSucDelegate?.upLoadInfoSuccess()
                }
                self.showHintInKeywindow(hint: "产品信息上传完成！",yOffset: SCREEN_HEIGHT/2 - 100*UIRate)
                self.pushToNextViewController()
                
        }, failure: {error in
            //隐藏HUD
            self.hideHud()
        })
   }
    
    //跳转到下一步的界面
    func pushToNextViewController(){
        let roleValue = RoleType(rawValue: UserHelper.getUserRole()!)!
        switch  roleValue{
        case .student:
            let idVC = SchoolViewController()
            self.navigationController?.pushViewController(idVC, animated: true)
        case .worker:
            let idVC = WorkViewController()
            self.navigationController?.pushViewController(idVC, animated: true)
        case .freedom:
            let idVC = IncomeViewController()
            self.navigationController?.pushViewController(idVC, animated: true)
        }
    }
    
    //MARK:请求产品信息
    func requestProductInfo(){
        
        //添加HUD
        self.showHud(in: self.view, hint: "加载中...")
        
        let params = ["userId": UserHelper.getUserId()]
        
        NetConnect.bm_get_product_info(parameters: params, success: { response in
            //隐藏HUD
            self.hideHud()
            let json = JSON(response)
            guard json["RET_CODE"] == "000000" else{
                return self.showHint(in: self.view, hint: json["RET_DESC"].stringValue)
            }
            self.refreshUI(json: json["orderInfo"])
            
        }, failure:{ error in
            //隐藏HUD
            self.hideHud()
        })
    }
    
    //填充信息
    func refreshUI(json: JSON){
       
        self.saleInfo.text = json["sale_name"].stringValue
        self.proName = json["orderName"].stringValue
        self.borrowMoney = json["amt"].stringValue
        self.selectPeriodInfo.text = json["total"].stringValue + "期"
        self.repayment = toolsChangeMoneyStyle(amount: json["term_amt"].doubleValue) 
        self.workerName = json["employee_id"].stringValue
        self.aTableView.reloadData()
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
                self.saleList.removeAll()
                
                if let namelist = json["saleList"].arrayObject{
                    for name in namelist{
                        if let name = name as? String{
                            self.saleList.append(name)
                        }
                    }
                }
                
                guard self.saleList.count > 0  else {
                    self.showHint(in: self.view, hint: "未能获取商户名称！")
                    return
                }
                self.saleInfo.text = self.saleList.first!
                //刷新tableView
                let position1 = IndexPath(row: 0, section: 0)
                self.aTableView.reloadRows(at: [position1], with: UITableViewRowAnimation.none)
                self.showHint(in: self.view, hint: "获取商户成功！")
                
        }, failure: {error in
            //隐藏HUD
            self.hideHud()
        })
    }
}


